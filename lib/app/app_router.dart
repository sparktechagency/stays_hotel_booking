import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/registration_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/sign_in_or_register_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/forgot_otp_screen.dart';
import 'package:stays_hotel_booking/features/booking/presentation/screens/booking_screen.dart';
import 'package:stays_hotel_booking/features/booking/presentation/screens/booking_payment_screen.dart';
import 'package:stays_hotel_booking/features/booking/presentation/screens/booking_details_screen.dart';
import 'package:stays_hotel_booking/features/booking/presentation/screens/my_booking_screen.dart';
import 'package:stays_hotel_booking/features/saved/presentation/screens/total_saved_screen.dart';
import 'package:stays_hotel_booking/features/invite/presentation/screens/invite_member_screen.dart';
import 'package:stays_hotel_booking/features/auth/presentation/screens/change_password_screen.dart';
import 'package:stays_hotel_booking/features/language/presentation/screens/language_screen.dart';
import 'package:stays_hotel_booking/features/faq/presentation/screens/faq_screen.dart';
import 'package:stays_hotel_booking/features/about/presentation/screens/about_us_screen.dart';
import 'package:stays_hotel_booking/features/privacy/presentation/screens/privacy_policy_screen.dart';
import 'package:stays_hotel_booking/features/terms/presentation/screens/terms_conditions_screen.dart';
import 'package:stays_hotel_booking/features/notifications/presentation/screens/notifications_screen.dart';
import 'package:stays_hotel_booking/features/favorite/presentation/screens/favorite_screens.dart';
import 'package:stays_hotel_booking/features/home/presentation/screens/home_screen.dart';
import 'package:stays_hotel_booking/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:stays_hotel_booking/features/profile/presentation/screens/personal_information_screen.dart';
import 'package:stays_hotel_booking/features/profile/presentation/screens/profile_screen.dart';
import 'package:stays_hotel_booking/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:stays_hotel_booking/features/search/presentation/screens/search_results_screen.dart';
import 'package:stays_hotel_booking/features/splash/presentation/screens/splash_screen.dart';
import 'package:stays_hotel_booking/features/subscription/presentation/screens/subscription_screen.dart';
import 'package:stays_hotel_booking/features/my_plan/presentation/screens/my_plan_screen.dart';
import 'package:stays_hotel_booking/features/hotel_details/presentation/screens/hotel_details_screen.dart';
import 'package:stays_hotel_booking/features/hotel_details/presentation/screens/click_reserve_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String signInOrRegister = '/sign-in-or-register';
  static const String registration = '/registration';
  static const String home = '/home';
  static const String subscription = '/subscription';
  static const String signIn = '/sign-in';
  static const String forgotPassword = '/forgot-password';
  static const String searchResults = '/search-results';
  static const String personalInformation = '/personal-information';
  static const String editProfile = '/edit-profile';
  static const String forgotOtp = '/forgot-otp';
  static const String createNewPassword = '/create-new-password';
  static const String booking = '/booking';
  static const String bookingPayment = '/booking-payment';
  static const String bookingDetails = '/booking-details';
  static const String myBooking = '/my-booking';
  static const String totalSaved = '/total-saved';
  static const String inviteMember = '/invite-member';
  static const String changePassword = '/change-password';
  static const String language = '/language';
  static const String faq = '/faq';
  static const String aboutUs = '/about-us';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsConditions = '/terms-conditions';
  static const String notifications = '/notifications';
  static const String favorite = '/favorite';
  static const String profile = '/profile';
  static const String hotelDetails = '/hotel-details';
  static const String clickReserve = '/click-reserve';
  static const String myPlan = '/my-plan';
  static const String staysWeb = '/stays-web';

  // Router configuration
  static final router = GoRouter(
    initialLocation: splash,
    routes: [
      // Splash Screen
      GoRoute(
        path: splash,
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),

      // Onboarding
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),

      // Stays WebView
      GoRoute(
        path: staysWeb,
        name: 'staysWeb',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const StaysWebViewScreen(),
        ),
      ),

      // Auth
      GoRoute(
        path: signInOrRegister,
        name: 'signInOrRegister',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SignInOrRegisterScreen(),
        ),
      ),
      GoRoute(
        path: registration,
        name: 'registration',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegistrationScreen(),
        ),
      ),
      GoRoute(
        path: signIn,
        name: 'signIn',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SignInScreen(),
        ),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgotPassword',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: searchResults,
        name: 'searchResults',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SearchResultsScreen(),
        ),
      ),
      GoRoute(
        path: personalInformation,
        name: 'personalInformation',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PersonalInformationScreen(),
        ),
      ),
      GoRoute(
        path: editProfile,
        name: 'editProfile',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: forgotOtp,
        name: 'forgotOtp',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ForgotOtpScreen(),
        ),
      ),
      GoRoute(
        path: createNewPassword,
        name: 'createNewPassword',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CreateNewPasswordScreen(),
        ),
      ),
      GoRoute(
        path: myPlan,
        name: 'myPlan',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyPlanScreen(),
        ),
      ),

 

        GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: hotelDetails,
        name: 'hotel-details',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HotelDetailsScreen(),
        ),
      ),
      GoRoute(
        path: clickReserve,
        name: 'click-reserve',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ClickReserveScreen(),
        ),
      ),

      // Bottom Navigation
      GoRoute(
        path: booking,
        name: 'booking',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const BookingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: bookingDetails,
        name: 'bookingDetails',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const BookingDetailsScreen(),
        ),
      ),
      GoRoute(
        path: myBooking,
        name: 'myBooking',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyBookingScreen(),
        ),
      ),
      GoRoute(
        path: totalSaved,
        name: 'totalSaved',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TotalSavedScreen(),
        ),
      ),
      GoRoute(
        path: inviteMember,
        name: 'inviteMember',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const InviteMemberScreen(),
        ),
      ),
      GoRoute(
        path: changePassword,
        name: 'changePassword',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ChangePasswordScreen(),
        ),
      ),
      GoRoute(
        path: language,
        name: 'language',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LanguageScreen(),
        ),
      ),
      GoRoute(
        path: faq,
        name: 'faq',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const FaqScreen(),
        ),
      ),
      GoRoute(
        path: aboutUs,
        name: 'aboutUs',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AboutUsScreen(),
        ),
      ),
      GoRoute(
        path: privacyPolicy,
        name: 'privacyPolicy',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PrivacyPolicyScreen(),
        ),
      ),
      GoRoute(
        path: termsConditions,
        name: 'termsConditions',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TermsConditionsScreen(),
        ),
      ),
      GoRoute(
        path: notifications,
        name: 'notifications',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const NotificationsScreen(),
        ),
      ),
      GoRoute(
        path: favorite,
        name: 'favorite',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const FavoriteScreens(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: bookingPayment,
        name: 'bookingPayment',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const BookingPaymentScreen(),
        ),
      ),
      GoRoute(
        path: profile,
        name: 'profile',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      ),

      // Subscription
      GoRoute(
        path: subscription,
        name: 'subscription',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SubscriptionScreen(),
        ),
      ),
    ],
  );
}

// Provider for Riverpod
final routerProvider = Provider<GoRouter>((ref) => AppRoutes.router);