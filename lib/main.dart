import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:krishnaversee/routes/routes_name.dart';
import 'package:krishnaversee/screens/dailystreak_screen.dart';
import 'package:krishnaversee/screens/home_screen.dart';
import 'package:krishnaversee/services/notification_service.dart';
import 'package:krishnaversee/view/audio/audio_screen.dart';
import 'package:krishnaversee/view/login/forgot_screen.dart';
import 'package:krishnaversee/view/login/login_screen.dart';
import 'package:krishnaversee/view/login/signup_screen.dart';
import 'package:krishnaversee/view/profile/about_us_screen.dart';
import 'package:krishnaversee/view/profile/backup_progress.dart';
import 'package:krishnaversee/view/profile/change_password.dart';
import 'package:krishnaversee/view/profile/clear_cache.dart';
import 'package:krishnaversee/view/profile/data_backup.dart';
import 'package:krishnaversee/view/profile/help_faq_screen.dart';
import 'package:krishnaversee/view/profile/personal_info.dart';
import 'package:krishnaversee/view/profile/privacy_policy.dart';
import 'package:krishnaversee/view/profile/profile_screen.dart';
import 'package:krishnaversee/view/profile/security_privacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
  await Supabase.initialize(
    url: 'https://bzgwwzglirslkfjnqigz.supabase.co',
    publishableKey: 'sb_publishable_owVAtKqYUFyiAjDv-SL94Q_JgPa-Z6W',
  );
  await NotificationService().initialize();
  runApp(const KrishnaVerse());
}

class KrishnaVerse extends StatelessWidget {
  const KrishnaVerse({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Krishnaversee',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splashScreen,
      getPages: [
        GetPage(name: RouteName.loginScreen, page: () => const LoginScreen()),
        GetPage(name: RouteName.signupScreen, page: () => const SignupScreen()),
        GetPage(name: RouteName.forgotPassword, page: () => const ForgotPasswordScreen()),
        GetPage(name: RouteName.homeScreen, page: () => const HomeScreen()),
        GetPage(name: RouteName.splashScreen, page: () => const SplashScreen()),
        GetPage(name: RouteName.audio, page: () => const AudioScreen()),
        GetPage(name: RouteName.profileScreen, page: () => const ProfileScreen()),
        GetPage(name: RouteName.personalInfo, page: () => const PersonalInfo()),
        GetPage(name: RouteName.security, page: () => const SecurityPrivacy()),
        GetPage(name: RouteName.changePassword, page: () => const ChangePassword()),
        GetPage(name: RouteName.privacyPolicy, page: () => const PrivacyPolicy()),
        GetPage(name: RouteName.backup, page: () => const DataBackup()),
        GetPage(name: RouteName.backupProgress, page:() => const BackupProgress()),
        GetPage(name: RouteName.clearCache, page: () => const ClearCache()),
        GetPage(name: RouteName.helpfaq, page:() => const HelpFaqScreen()),
        GetPage(name: RouteName.about, page: () => const AboutUsScreen()),
        GetPage(name: RouteName.dailystreakscreen, page: () => const DailyStreakScreen()),

      ],
    );
  }
}