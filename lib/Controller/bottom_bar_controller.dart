import 'package:get/get.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Screens/Home/home_screen.dart';
import 'package:watchit/View/Screens/Search/search_movie_screen.dart';
import 'package:watchit/View/Screens/WatchList/watch_list_screen.dart';

class BottomBarController extends GetxController {
  int index = 0;

  updateIndex(int selectedIndex) {
    index = selectedIndex;
    update();
  }

  List<Map> bottomBarScreen = [
    {'Image': AppAssets.home, 'Label': AppString.home, 'Screen': const HomeScreen()},
    {'Image': AppAssets.search, 'Label': AppString.search, 'Screen': const SearchMovieScreen()},
    {'Image': AppAssets.save, 'Label': AppString.watchList, 'Screen': const WatchListScreen()},
  ];
}
