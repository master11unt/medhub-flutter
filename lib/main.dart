import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:medhub/data/datasource/auth_local_datasource.dart';
import 'package:medhub/data/datasource/auth_remote_datasource.dart';
import 'package:medhub/data/datasource/health_record_remote_datasource.dart';
import 'package:medhub/presentation/auth/bloc/login/login_bloc.dart';
import 'package:medhub/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:medhub/presentation/auth/bloc/medical_info/medical_info_bloc.dart';
import 'package:medhub/presentation/auth/bloc/register/register_bloc.dart';
import 'package:medhub/presentation/auth/pages/login_page.dart';
import 'package:medhub/presentation/auth/pages/medical_info_page.dart';
import 'package:medhub/presentation/auth/pages/signup_page.dart';
import 'package:medhub/presentation/auth/pages/splash_screen.dart';
import 'package:medhub/presentation/home/pages/profile/edit_medical_info_page.dart';
import 'package:medhub/presentation/home/pages/profile/edit_profile_page.dart';
import 'package:medhub/presentation/home/pages/home_dan_konsultasi/main_page.dart';
import 'package:medhub/presentation/home/pages/profile/kebijakan_privasi_page.dart';
import 'package:medhub/presentation/home/pages/profile/pusat_bantuan_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: AuthLocalDatasource().getToken(), // pastikan ini Future<String>
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
              create:
                  (context) =>
                      MedicalInfoBloc(HealthRecordRemoteDatasource(), token),
            ),
          ],
          child: MaterialApp(
            title: 'MedHub',
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
              '/editProfile': (context) => const MyEditProfilePage(),
              '/editMedicalInfo': (context) => EditMedicalInfoPage(),
              '/main': (context) => const MainPage(),
              '/medicalInfo': (context) => MedicalInfoPage(),
              '/helpCenter': (context) => const HelpCenterPage(),
              '/privacyPolicy': (context) => const KebijakanPrivasiPage(),
              // '/editMedicalInfo':
              //     (context) => BlocProvider(
              //       create:
              //           (context) => MedicalInfoBloc(
              //             HealthRecordRemoteDatasource(),
              //             // Ambil token dari AuthLocalDatasource atau provider lain
              //             '', // Ganti dengan token yang sesuai
              //           ),
              //       child: EditMedicalInfo(),
              //     ),
            },
          ),
        );
      },
    );
  }
}
