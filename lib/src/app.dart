import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:muzey_app/src/features/camera/presentation/camera_screen.dart';
import 'package:muzey_app/src/features/virtual/presentation/virtual_screen.dart';
import 'core/globals.dart';
import 'features/dashboard/presentation/dashboard_screen.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'localization/controller/language_controller.dart';
import 'localization/localization_service.dart';
import 'theme/app_theme.dart';
import 'theme/controller/theme_controller.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localizationService = LocalizationService();
  final _box = GetStorage();

  ThemeMode _initThemeMode() {
    bool? isDarkMode = _box.read<bool>(r'theme');
    isDarkMode ??= false;

    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child)=>GetMaterialApp(
        title: 'Gurlushyk',
        localizationsDelegates: LocalizationService.localizationsDelegate(),
        locale: localizationService.getLocale(),
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: localizationService,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: _initThemeMode(),
        initialRoute: DashboardScreen.route,
        initialBinding: DashboardBinding(),
        getPages: [
          GetPage(
            name: DashboardScreen.route,
            page: () =>  DashboardScreen(),
          ),
          GetPage(
            name: HomeScreen.route,
            page: () => const HomeScreen(),
          ),
          GetPage(
            name: CameraScreen.route,
            page: () =>  CameraScreen(),
          ),
          GetPage(
            name: ProfileScreen.route,
            page: () => const ProfileScreen(),
          ),
          GetPage(
            name: VirtualScreen.route,
            page: () => const VirtualScreen(),
          ),
          // GetPage(
          //   name: InitialScreen.route,
          //   page: () => const InitialScreen(),
          // ),
          // GetPage(
          //   name: SettingsScreen.route,
          //   page: () => const SettingsScreen(),
          // ),
          // GetPage(
          //   name: ProfileSettingsScreen.route,
          //   page: () => const ProfileSettingsScreen(),
          // ),
        ],
      ),
    );
  }
}

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    final apiService = ApiServices.apiService;

    Get.put(ThemeController(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    // Get.put(InitialController(), permanent: true);
    // Get.put(ProfileSettingsController(), permanent: true);
    // Get.put(
    //     AuthController(authRepository: AuthRepository(apiService: apiService)),
    //     permanent: true);

  }
}
