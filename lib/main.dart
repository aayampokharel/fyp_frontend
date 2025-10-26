import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dashboard/core/constants/color_constants.dart';
import 'package:flutter_dashboard/core/constants/dependency_injection/di.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/admin_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/faculty_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/institution_usecase.dart';
import 'package:flutter_dashboard/features/authentication/domain/use_case/user_account_usecase.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/admin_log_in.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view/pages/sign_in_institution_page.dart';
import 'package:flutter_dashboard/features/authentication/presentation/view_model/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

// ==================== MAIN APP ====================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            institutionUsecase: getIt<InstitutionUseCase>(),
            userAccountUsecase: getIt<UserAccountUseCase>(),
            facultyUsecase: getIt<FacultyUseCase>(),
            adminAccountUsecase: getIt<AdminAccountUseCase>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Modern Admin Dashboard (Static UI)',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorConstants.primaryPurple,
          scaffoldBackgroundColor: ColorConstants.lightGray,
          fontFamily: 'Exo',
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
          ),
        ),
        home: AdminLoginPage(),
      ),
    );
  }
}
