import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/registration_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/sign_in_or_register_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/forgot_otp_screen.dart';
import 'package:stays_hotel_booking/features/home/presentation/screens/home_screen.dart';
import 'package:stays_hotel_booking/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:stays_hotel_booking/features/splash/presentation/screens/splash_screen.dart';
import 'package:stays_hotel_booking/features/subscription/presentation/screens/subscription_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String signInOrRegister = '/sign-in-or-register';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String test = '/test';
  static const String subscription = '/subscription';
  static const String signIn = '/sign-in';
  static const String forgotPassword = '/forgot-password';
  static const String forgotOtp = '/forgot-otp';
  static const String createNewPassword = '/create-new-password';

  static final List<RouteBase> routes = <RouteBase>[
    GoRoute(
      path: splash,
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    GoRoute(
      path: onboarding,
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: signInOrRegister,
      name: 'signInOrRegister',
      builder: (BuildContext context, GoRouterState state) => const SignInOrRegisterScreen(),
    ),
    GoRoute(
      path: registration,
      name: 'registration',
      builder: (BuildContext context, GoRouterState state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: home,
      name: 'home',
      builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
    ),
    GoRoute(
      path: subscription,
      name: 'subscription',
      builder: (BuildContext context, GoRouterState state) => const SubscriptionScreen(),
    ),
    GoRoute(
      path: signIn,
      name: 'signIn',
      builder: (BuildContext context, GoRouterState state) => const SignInScreen(),
    ),
    GoRoute(
      path: forgotPassword,
      name: 'forgotPassword',
      builder: (BuildContext context, GoRouterState state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: forgotOtp,
      name: 'forgotOtp',
      builder: (BuildContext context, GoRouterState state) => const ForgotOtpScreen(),
    ),

    GoRoute(
  path: createNewPassword,
  name: 'createNewPassword',
  builder: (context, state) => const CreateNewPasswordScreen(),
),
      ];
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: AppRoutes.routes,
  );
});
