import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchit/Api/Repository/home_repository.dart';
import 'package:watchit/Model/movie_list_res_model.dart';
import 'package:watchit/Model/response_model.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/show_toast.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<MovieList> movieList = [];
  List<MovieList> searchMovieList = [];
  List<MovieList> watchList = [];
  List countImage = [AppAssets.one, AppAssets.two, AppAssets.three, AppAssets.four, AppAssets.five];

  /// Get Movie Api Integration
  Future<void> getMovieList(BuildContext context) async {
    movieList.clear();
    isLoading = true;
    update();
    ResponseItem result = ResponseItem();
    result = await HomeRepository.categoryList();
    try {
      if (result.data != null) {
        MovieListResponseModel movieListResponseModel = MovieListResponseModel.fromJson(result.data);
        movieListResponseModel.results?.forEach((element) {
          movieList.add(element);
        });
        isLoading = false;
        update();
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    update();
  }

  /// Search Movie Function
  Future searchMovieLists(String value) async {
    searchMovieList = [];
    if (value.isNotEmpty) {
      for (var element in movieList) {
        if (element.title.toString().toLowerCase().contains(value.toLowerCase())) {
          searchMovieList.add(element);
        }
      }
    } else {
      searchMovieList.clear();
    }
    update();
  }

  /// Add To WishList Function
  Future addToWatchList(MovieList movie) async {
    if (movie.isSaved == true) {
      watchList.add(movie);
      showToast('Movie Added To WatchList');
    } else {
      watchList.remove(movie);
      showToast('Movie Removed From WatchList');
    }
    update();
  }
}
