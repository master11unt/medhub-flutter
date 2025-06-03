import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/datasource/health_record_remote_datasource.dart';
import 'package:medhub/data/datasource/obat_remote_datasource.dart'; // Tambahkan import ini
import 'package:medhub/presentation/auth/bloc/login/login_bloc.dart';
import 'package:medhub/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:medhub/presentation/auth/bloc/medical_info/medical_info_bloc.dart';
import 'package:medhub/presentation/auth/bloc/register/register_bloc.dart';
import 'package:medhub/presentation/home/bloc/obat/obat_bloc.dart'; // Tambahkan import ini
import 'package:medhub/presentation/auth/pages/login_page.dart';
import 'package:medhub/presentation/auth/pages/medical_info_page.dart';
import 'package:medhub/presentation/auth/pages/signup_page.dart';
import 'package:medhub/presentation/auth/pages/splash_screen.dart';
import 'package:medhub/presentation/home/pages/profile/edit_medical_info_page.dart';
import 'package:medhub/presentation/home/pages/profile/edit_profile_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:medhub/presentation/home/pages/profile/kebijakan_privasi_page.dart';
import 'package:medhub/presentation/home/pages/profile/profile_page.dart';
import 'package:medhub/presentation/home/pages/profile/pusat_bantuan_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting untuk locale Indonesia
  try {
    await initializeDateFormatting('id_ID', null);
    Intl.defaultLocale = 'id_ID';
    debugPrint('Locale initialized successfully');
  } catch (e) {
    debugPrint('Error initializing locale: $e');
  }

  GestureBinding.instance.resamplingEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AuthLocalDatasource().getToken(),
      builder: (context, snapshot) {
        final token = snapshot.data ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginBloc(AuthRemoteDatasource()),
            ),
            BlocProvider(
              create: (context) => LogoutBloc(AuthRemoteDatasource()),
            ),
            BlocProvider(
              create: (context) => RegisterBloc(AuthRemoteDatasource()),
            ),
            BlocProvider(
              create: (context) => MedicalInfoBloc(HealthRecordRemoteDatasource(), token),
            ),
            // Tambahkan ObatBloc di sini
            BlocProvider(
              create: (context) => ObatBloc(ObatRemoteDatasource()),
            ),
          ],
          child: MaterialApp(
            title: 'MedHub',
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('id', 'ID'),
            ],
            locale: const Locale('id', 'ID'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xff00C8B5),
              ),
            ),
            home: const SplashScreen(),
            routes: {
              '/login': (context) => const LoginPage(),
              '/signup': (context) => const SignUpPage(),
              '/profile': (context) => const ProfilePage(),
              '/editProfile': (context) => const MyEditProfilePage(),
              '/editMedicalInfo': (context) => FutureBuilder<String>(
                future: AuthLocalDatasource().getToken(),
                builder: (context, snapshot) {
                  final token = snapshot.data ?? '';
                  return BlocProvider(
                    create: (context) => MedicalInfoBloc(
                      HealthRecordRemoteDatasource(),
                      token,
                    ),
                    child: EditMedicalInfoPage(),
                  );
                },
              ),
              '/main': (context) => const MainPage(),
              '/medicalInfo': (context) => MedicalInfoPage(),
              '/helpCenter': (context) => const HelpCenterPage(),
              '/privacyPolicy': (context) => const KebijakanPrivasiPage(),
            },
          ),
        );
      },
    );
  }
}
