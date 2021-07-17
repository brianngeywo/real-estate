const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();


exports.createAllUsersRentals = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onCreate(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        const user_id = context.params.user_id;
        const allUsersRentalsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("rentals")

        const allUsersRentalsListings = admin
            .firestore()
            .collection("rentals")
        const userRentalSnapshot = await allUsersRentalsRef.get();
        userRentalSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersListingData = doc.data();
                allUsersRentalsListings.doc(rentalId).set(allUsersListingData);
            }
        })
    });

exports.updateAllUsersRentals = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onUpdate(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        const user_id = context.params.user_id;
        const allUsersRentalsRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("rentals")
        const allUsersRentalsListing = admin
            .firestore()
            .collection("rentals")
        const userRentalSnapshot = await allUsersRentalsRef.get();
        userRentalSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersRentalsData = doc.data();
                allUsersRentalsListing.doc(rentalId).update(allUsersRentalsData);
            }
        })
    });
exports.deleteRentalOnAllListings = functions.firestore
    .document("/users/{user_id}/rentals/{rentalId}")
    .onDelete(async (snapshot, context) => {
        const rentalId = context.params.rentalId;
        admin
            .firestore()
            .collection("rentals").doc(rentalId).delete();
    });

exports.createUserSearchQuery = functions.firestore
    .document("/users/{user_id}/searches/{searchId}")
    .onCreate(async (snapshot, context) => {
        const searchId = context.params.searchId;
        const user_id = context.params.user_id;
        const userSearchRef = admin
            .firestore()
            .collection("users")
            .doc(user_id)
            .collection("searches")

        const allUsersSearchesListings = admin
            .firestore()
            .collection("searches")
        const userSearchSnapshot = await userSearchRef.get();
        userSearchSnapshot.forEach(doc => {
            if (doc.exists) {
                const allUsersSearchListingData = doc.data();
                allUsersSearchesListings.doc(searchId).set(allUsersSearchListingData);
            }
        })
    });

exports.paymentCallback = functions.https.onRequest(async (req, res) => {
    // Get the stk response body
    const callbackData = req.body.Body.stkCallback;

    console.log("Received payload: ", callbackData);

    const responseCode = callbackData.ResultCode;
    const mCheckoutRequestID = callbackData.CheckoutRequestID;

    if (responseCode === 0) {
        const details = callbackData.CallbackMetadata.Item

        var mReceipt;
        var mPhonePaidFrom;
        var mAmountPaid;

        await details.forEach(entry => {
            switch (entry.Name) {
                case "MpesaReceiptNumber":
                    mReceipt = entry.Value
                    break;

                case "PhoneNumber":
                    mPhonePaidFrom = entry.Value
                    break;

                case "Amount":
                    mAmountPaid = entry.Value;
                    break;

                default:
                    break;
            }
        })

        const mEntryDetails = {
            "receipt": mReceipt,
            "phone": mPhonePaidFrom,
            "amount": mAmountPaid
        }

        // Find the document initialized from client device containing the CheckoutRequestID.
        try {
            var matchingCheckoutID = await admin.firestore().collectionGroup('deposit')
                .where('CheckoutRequestID', '==', mCheckoutRequestID);

        } catch (e) {
            console.log(e);
        }


        const queryResults = await matchingCheckoutID.get();

        if (!queryResults.empty) {
            // Case the match is found
            var documentMatchingID = queryResults.docs[0];
            //update account balance - first get the mail for particular user
            const mail = documentMatchingID.ref.path.split('/')[1]

            documentMatchingID.ref.update(mEntryDetails);

            admin.firestore().collection('payments')
                .doc(mail).collection('balance')
                .doc('account').get().then(async (account) => {

                    if (account.data() !== undefined) {
                        // When it's not the first time
                        var balance = account.data().wallet
                        const newBalance = balance + mAmountPaid
                        console.log("Account found updating with balance ", newBalance, " from ", balance);

                        return account.ref.update({ wallet: newBalance })
                    } else {
                        console.log("No account found...creating with new balance ", mAmountPaid);
                        //create fresh wallet
                        try {
                            return admin.firestore().collection('payments')
                                .doc(mail).collection('balance')
                                .doc('account').set({ wallet: mAmountPaid });
                        } catch (err) {
                            console.log("Error creating account when not found ", err);
                            return 1;
                        }
                    }
                }).catch((exc) => {
                    console.log("Exception getting account ", exc);
                    return { "data": exc }
                })

            console.log("Updated document: ", documentMatchingID.ref.path);

        } else {
            console.log("No document found matching the checkoutRequestID : ", mCheckoutRequestID);
            //Persist the data somewhere for reference.
            admin.firestore().doc('lost_found_receipts/deposit_info/all/'
                + mCheckoutRequestID).set(mEntryDetails);

        }

    } else {
        console.log("Failed transaction.");
        //You may wish to persist the data sent as well here.
    }

    // Send back a message that we've succesfully written the message
    res.json({ 'result': `Payment for ${mCheckoutRequestID} response received.` });

});