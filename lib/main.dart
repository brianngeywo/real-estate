import 'package:Realify/backend/router/router.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Future.delayed(Duration(milliseconds: 1)).then((value) => SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(49, 122, 87, 1),
        ),
      ));
  runApp(
    LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            onGenerateRoute: generateRoute,
            theme: ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.transparent,
            ),
          );
        },
      );
    }),
  );
}
