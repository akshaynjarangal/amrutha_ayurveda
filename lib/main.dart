import 'dart:developer';

import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/presentation/provider/patient_provider.dart';
import 'package:ayurveda/presentation/provider/registration_provider.dart';
import 'package:ayurveda/presentation/screens/home_screen.dart';
import 'package:ayurveda/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import 'di/di.dart';
import 'presentation/screens/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await storage.read(key: "token");
  log("Token: $token");
  await configureDependencies();
  runApp(MyApp(isLogin: token == null ? false : true));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => getIt<PatientProvider>(),
      child: MaterialApp(
        navigatorKey: kNavigationKey,
        debugShowCheckedModeBanner: false,
        title: 'Amrutha Ayurveda',
        theme: ThemeData(
          datePickerTheme: DatePickerThemeData(
            backgroundColor: AppColors.white,
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: GoogleFonts.poppins(),
              hintStyle: GoogleFonts.poppins(),
            ),
          ),
          indicatorColor: AppColors.primaryColor,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppColors.primaryColor,
          ),
          primaryColor: AppColors.primaryColor,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.black.withOpacity(0.3),
              ),
            ),
          ),
          fontFamily: GoogleFonts.poppins().fontFamily,
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
        ),
        initialRoute: isLogin ? '/' : '/login',
        routes: {
          '/': (context) => ChangeNotifierProvider.value(
                value: getIt<PatientProvider>()..fetchPatients(),
                child: const HomeScreen(),
              ),
          '/login': (context) => const LoginScreen(),
          '/registration': (context) => ChangeNotifierProvider.value(
                value: getIt<RegistrationProvider>()..fetchBranches()..fetchTreatment(),
                child: const RegistrationScreen(),
              ),
        },
      ),
    );
  }
}
