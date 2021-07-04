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