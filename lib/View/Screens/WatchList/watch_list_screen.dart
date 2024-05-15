import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:watchit/Controller/home_controller.dart';
import 'package:watchit/View/Constant/app_assets.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Constant/font_utils.dart';
import 'package:watchit/View/Screens/Home/movie_details_screen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColor,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.07, left: width * 0.04, right: width * 0.04),
        child: GetBuilder<HomeController>(builder: (controller) {
          return Column(
            children: [
              Center(
                child: Text(
                  AppString.watchListTitle,
                  style: FontUtils.h20(fontWeight: FWT.semiBold),
                ),
              ),
              Expanded(
                child: controller.watchList.isEmpty
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
                    : SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: height * 0.05),
                          child: Column(
                            children: List.generate(
                              controller.watchList.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  Get.to(() => MovieDetailsScreen(movie: controller.watchList[index]),
                                      transition: Transition.fadeIn);
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
                                              image: NetworkImage(controller.watchList[index].posterPath ?? ''),
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
                                              controller.watchList[index].title ?? '',
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
                                                      controller.watchList[index].releaseDate.toString())),
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
                                                    controller.watchList[index].overview.toString(),
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
        }),
      ),
    );
  }
}
