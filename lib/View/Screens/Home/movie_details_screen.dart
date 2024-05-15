import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:watchit/Controller/home_controller.dart';
import 'package:watchit/Model/movie_list_res_model.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Constant/font_utils.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key, required this.movie});
  final MovieList movie;
  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: themeColor,
      body: GetBuilder<HomeController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: width * 0.04).copyWith(top: height * 0.06, bottom: height * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: basicFontColor,
                      size: height * 0.026,
                    ),
                  ),
                  Center(
                    child: Text(
                      AppString.detail,
                      style: FontUtils.h20(fontWeight: FWT.semiBold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.movie.isSaved = !widget.movie.isSaved;
                      controller.update();
                      controller.addToWatchList(widget.movie);
                    },
                    child: Icon(
                      widget.movie.isSaved == true ? Icons.bookmark : Icons.bookmark_border,
                      color: basicFontColor,
                      size: height * 0.03,
                    ),
                  )
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                    image: DecorationImage(image: NetworkImage(widget.movie.backdropPath ?? ''), fit: BoxFit.cover),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: height * 0.2,
                      width: width * 0.31,
                      margin: EdgeInsets.only(top: height * 0.2, left: width * 0.07),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(widget.movie.posterPath ?? ''), fit: BoxFit.fill),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.29, left: width * 0.03),
                      child: SizedBox(
                        width: width * 0.54,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title ?? '',
                              style: FontUtils.h17(fontWeight: FWT.medium),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: basicFontColor,
                                  size: height * 0.015,
                                ),
                                SizedBox(width: width * 0.01),
                                Text(
                                  DateFormat('dd MMM, yyyy')
                                      .format(DateTime.parse(widget.movie.releaseDate.toString())),
                                  style: FontUtils.h12(fontWeight: FWT.regular),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Column(
                children: [
                  Text(
                    AppString.aboutMovie,
                    style: FontUtils.h18(fontWeight: FWT.semiBold),
                    textAlign: TextAlign.start,
                  ),
                  Container(
                    height: height * 0.007,
                    width: width * 0.3,
                    color: textFieldColor,
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.06),
              child: Text(
                widget.movie.overview ?? '',
                style: FontUtils.h15(fontWeight: FWT.medium),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        );
      }),
    );
  }
}
