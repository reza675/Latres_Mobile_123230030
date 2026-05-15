import 'package:get/get.dart';
import '../view/profile_page.dart';
import '../view/detail_page.dart';
import '../view/favorite_page.dart';
import '../view/home_page.dart';
import '../view/login_page.dart';
import 'app_routes.dart';

class AppPages {
	static final List<GetPage<dynamic>> pages = [
		GetPage(
			name: AppRoutes.login,
			page: () => const LoginpageView(),
		),
		GetPage(
			name: AppRoutes.home,
			page: () => const HomePageView(),
		),
		GetPage(
			name: AppRoutes.detail,
			page: () => const DetailPageView(),
		),
		GetPage(
			name: AppRoutes.favorite,
			page: () => const FavoritePageView(),
		),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePageView(),
    ),
	];
}
