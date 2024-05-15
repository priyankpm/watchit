import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:watchit/Controller/home_controller.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Constant/font_utils.dart';
import 'package:watchit/View/Screens/Home/movie_details_screen.dart';

class SearchMovieScreen extends StatefulWidget {
  const SearchMovieScreen({super.key});

  @override
  State<SearchMovieScreen> createState() => _SearchMovieScreenState();
}

class _SearchMovieScreenState extends State<SearchMovieScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      homeController.searchMovieLists('');
      homeController.searchController.clear();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themeColor,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.07, left: width * 0.04, right: width * 0.04),
        child: GetBuilder<HomeController>(
          builder: (controller) {
            return Column(
              children: [
                Center(
                  child: Text(
                    AppString.search,
                    style: FontUtils.h20(fontWeight: FWT.semiBold),
                  ),
                ),
                SizedBox(
                  height: height * 0.04,
                ),
                TextFormField(
                  controller: controller.searchController,
                  cursorColor: basicFontColor,
                  style: FontUtils.h18(fontWeight: FWT.semiBold),
                  onChanged: (value) {
                    controller.searchMovieLists(value);
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    hintText: AppString.search,
                    hintStyle: FontUtils.h18(fontColor: appGrey),
                    fillColor: textFieldColor,
                    filled: true,
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.05),
                      child: Image.asset(
                        AppAssets.search,
                        height: height * 0.02,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: controller.searchMovieList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.searchNoResult,
                                height: height * 0.1,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  AppString.sorryText,
                                  style: FontUtils.h16(fontWeight: FWT.semiBold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.007,
                              ),
                              SizedBox(
                                width: width * 0.5,
                                child: Text(
                                  AppString.findMovie,
                                  style: FontUtils.h12(fontWeight: FWT.medium, fontColor: lightGreyColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: height * 0.04),
                            child: Column(
                              children: List.generate(
                                controller.searchMovieList.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => MovieDetailsScreen(movie: controller.searchMovieList[index]));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: height * 0.02),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: height * 0.17,
                                          width: width * 0.27,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(controller.searchMovieList[index].posterPath ?? ''),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.03,
                                        ),
                                        SizedBox(
                                          width: width * 0.55,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.searchMovieList[index].title ?? '',
                                                style: FontUtils.h17(fontWeight: FWT.medium),
                                              ),
                                              SizedBox(height: height * 0.01),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.calendar_month,
                                                    size: width * 0.03,
                                                    color: basicFontColor,
                                                  ),
                                                  SizedBox(width: width * 0.01),
                                                  Text(
                                                    DateFormat('dd MMM,yyyy').format(DateTime.parse(
                                                        controller.searchMovieList[index].releaseDate.toString())),
                                                    style: FontUtils.h12(
                                                      fontWeight: FWT.regular,
                                                      fontColor: basicFontColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: height * 0.005),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(top: height * 0.002),
                                                    child: Icon(
                                                      Icons.info_outlined,
                                                      size: width * 0.03,
                                                      color: basicFontColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: width * 0.01),
                                                  SizedBox(
                                                    width: width * 0.45,
                                                    child: Text(
                                                      controller.searchMovieList[index].overview.toString(),
                                                      style: FontUtils.h12(
                                                        fontWeight: FWT.regular,
                                                        fontColor: basicFontColor,
                                                      ),
                                                      maxLines: 3,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
