import 'package:Realify/backend/repositories/RealifyPropertyRepository.dart';
import 'package:Realify/presentation/my_imports.dart';
import 'package:Realify/presentation/public/HomePage/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  RealifyPropertyRepository realifyPropertyRepository;
  runApp(
    LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(
        builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(realifyPropertyRepository: realifyPropertyRepository),
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
