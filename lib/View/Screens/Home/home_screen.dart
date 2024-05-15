import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchit/Controller/bottom_bar_controller.dart';
import 'package:watchit/Controller/home_controller.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Constant/font_utils.dart';
import 'package:watchit/View/Screens/Home/movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
      child: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.07,
                      ),
                      child: Text(
                        AppString.homeText1,
                        style: FontUtils.h20(fontWeight: FWT.semiBold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        bottomBarController.updateIndex(1);
                      },
                      child: Container(
                        height: height * 0.06,
                        width: width,
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        margin: EdgeInsets.only(top: height * 0.03, bottom: height * 0.04),
                        decoration: BoxDecoration(
                          color: textFieldColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppString.search, style: FontUtils.h18(fontColor: appGrey)),
                            Image.asset(
                              AppAssets.search,
                              height: height * 0.03,
                            )
                          ],
                        ),
                      ),
                    ),
                    controller.movieList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.emptyWatchList,
                                  height: height * 0.1,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.007),
                                  child: SizedBox(
                                    width: width * 0.5,
                                    child: Text(
                                      AppString.noWatchList,
                                      style: FontUtils.h16(fontWeight: FWT.semiBold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
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
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width,
                                height: height * 0.33,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: height * 0.28,
                                            child: ListView.builder(
                                              itemCount: 5,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) => Container(
                                                height: height * 0.28,
                                                width: width * 0.38,
                                                margin: EdgeInsets.only(right: width * 0.03),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                    image: NetworkImage(controller.movieList[index].posterPath ?? ''),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                            itemCount: 5,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) => Padding(
                                              padding: EdgeInsets.only(
                                                  top: index == 0 ? height * 0.23 : height * 0.21, right: width * 0.25),
                                              child: Image.asset(
                                                controller.countImage[index],
                                                width: width * 0.16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Column(
                                children: [
                                  Text(
                                    AppString.popularMovies,
                                    style: FontUtils.h18(fontWeight: FWT.semiBold),
                                    textAlign: TextAlign.start,
                                  ),
                                  Container(
                                    height: height * 0.007,
                                    width: width * 0.37,
                                    color: textFieldColor,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(bottom: height * 0.02),
                                scrollDirection: Axis.vertical,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.movieList.length,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: width * 0.03,
                                    mainAxisSpacing: height * 0.015,
                                    mainAxisExtent: height * 0.2),
                                itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => MovieDetailsScreen(movie: controller.movieList[index]));
                                  },
                                  child: Container(
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      // color: Colors.red,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          controller.movieList[index].posterPath ?? '',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
      ),
    );
  }
}
