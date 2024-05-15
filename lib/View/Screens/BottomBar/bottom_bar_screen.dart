import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watchit/Controller/bottom_bar_controller.dart';
import 'package:watchit/View/Constant/app_strings.dart';
import 'package:watchit/View/Constant/color_utils.dart';
import 'package:watchit/View/Constant/font_utils.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  BottomBarController bottomBarController = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: themeColor,
          // bottomNavigationBar: BottomNavigationBar(
          //   backgroundColor: themeColor,
          //   selectedItemColor: borderColor,
          //   unselectedItemColor: appGrey,
          //   selectedFontSize: height * 0.015,
          //   unselectedFontSize: height * 0.015,
          //   selectedLabelStyle: const TextStyle(color: borderColor),
          //   elevation: 0,
          //   currentIndex: controller.index,
          //   onTap: (value) {
          //     controller.updateIndex(value);
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //         icon: Padding(
          //           padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.01),
          //           child: Image(
          //             image: const AssetImage('assets/images/home.png'),
          //             height: height * 0.027,
          //             color: controller.index == 0 ? borderColor : appGrey,
          //           ),
          //         ),
          //         backgroundColor: themeColor,
          //         label: AppString.home),
          //     BottomNavigationBarItem(
          //         icon: Padding(
          //           padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.01),
          //           child: Image(
          //             image: const AssetImage('assets/images/search.png'),
          //             height: height * 0.027,
          //             color: controller.index == 1 ? borderColor : appGrey,
          //           ),
          //         ),
          //         label: AppString.search),
          //     BottomNavigationBarItem(
          //       icon: Padding(
          //         padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.01),
          //         child: Image(
          //           image: const AssetImage('assets/images/save.png'),
          //           height: height * 0.027,
          //           color: controller.index == 2 ? borderColor : appGrey,
          //         ),
          //       ),
          //       label: AppString.watchList,
          //     ),
          //   ],
          // ),

          bottomNavigationBar: Container(
            height: height * 0.08,
            width: width,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: 1),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                3,
                (index) => GestureDetector(
                  onTap: () {
                    controller.updateIndex(index);
                  },
                  child: Container(
                    color: Colors.transparent,
                    width: width * 0.18,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          controller.bottomBarScreen[index]['Image'],
                          height: height * 0.027,
                          color: controller.index == index ? borderColor : appGrey,
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Text(
                          controller.bottomBarScreen[index]['Label'],
                          style: FontUtils.h12(fontColor: controller.index == index ? borderColor : appGrey),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: controller.bottomBarScreen[controller.index]['Screen'],
        );
      },
    );
  }
}
