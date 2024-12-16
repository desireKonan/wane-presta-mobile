import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/font_style.dart';
import 'package:shimmer/shimmer.dart';

class Shimmers {
  static Shimmer homeBannerShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Container(
        height: Get.height * 0.20,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.red.withOpacity(0.2),
        ),
        child: Image.asset(AppAsset.icPlaceholderImage).paddingAll(40), //placeholder
      ).paddingOnly(left: 15, right: 15),
    );
  }

  static Shimmer homeServiceShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.71,
          crossAxisSpacing: 15,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                width: Get.width * 0.17,
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red.withOpacity(0.3),
                ),
                child: Image.asset(
                  AppAsset.icPlaceholderService, //placeholder
                  height: 40,
                  width: 40,
                ),
              ).paddingOnly(bottom: 6, top: 5),
              SizedBox(
                width: Get.width * 0.15,
                child: Center(
                  child: Container(
                    height: 12,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.red),
                  ),
                ),
              ),
            ],
          );
        },
      ).paddingOnly(top: 15, left: 15, right: 15),
    );
  }

  static Shimmer homeTopRatedProviderShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Colors.red.withOpacity(0.5),
                width: 1.2,
              ),
            ),
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                            height: 110,
                            width: 110,
                            child: Image.asset(
                              AppAsset.icPlaceholderProvider, //placeholder
                              color: Colors.red.withOpacity(0.5),
                            ).paddingAll(10),
                          ),
                        ),
                      ),
                      SizedBox(width: Get.width * 0.02),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 15,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.red.withOpacity(0.5),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.withOpacity(0.5),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 15,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                            Container(
                              height: 15,
                              width: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ).paddingOnly(top: 7, bottom: 7),
                            Container(
                              height: 15,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ).paddingOnly(top: 15),
    );
  }

  static Shimmer selectSlotShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 0.10,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 3, right: 3),
            child: Container(
              height: 30,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.red,
              ),
            ),
          );
        },
      ).paddingAll(5),
    );
  }

  static Shimmer applyCouponShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              height: Get.height * 0.16,
              width: Get.width,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 15,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        height: 15,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 13, bottom: 13, left: 15),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ).paddingOnly(right: 15),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  static Shimmer cancelAppointmentShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Container(
              height: 235,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  width: 1.5,
                  color: Colors.red.withOpacity(0.3),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.125,
                    child: Row(
                      children: [
                        Container(
                          height: Get.height * 0.125,
                          width: Get.width * 0.27,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 16,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red,
                                ),
                              ),
                              Container(
                                width: 120,
                                decoration: BoxDecoration(
                                  color: AppColors.specialistBox,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                  child: Text(
                                    "",
                                    style: AppFontStyle.fontStyleW500(
                                      fontSize: 11.5,
                                      fontColor: AppColors.specialist,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 16,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.specialistBox,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                      child: Text(
                                        "At Clinic",
                                        style: AppFontStyle.fontStyleW500(
                                          fontSize: 11.5,
                                          fontColor: AppColors.tabUnselectText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).paddingOnly(left: 10, top: 5, bottom: 5),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 1.5,
                    color: AppColors.divider,
                  ).paddingOnly(top: 12, bottom: 8),
                  Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.red,
                    ),
                  ).paddingOnly(bottom: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).paddingAll(12),
            ).paddingOnly(left: 12, right: 12, bottom: 18);
          },
        ),
      ),
    );
  }

  static Shimmer helpDeskHistoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: Get.height * 0.085,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(width: 0.8, color: AppColors.divider),
            ),
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    AppAsset.icComplain,
                  ).paddingAll(9),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            height: 15,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 17,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ).paddingOnly(right: 10),
                          Container(
                            height: 17,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ).paddingOnly(top: 10, bottom: 10, left: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Shimmer walletHistoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: SizedBox(
        height: Get.height * 0.8,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              height: Get.height * 0.1,
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(width: 0.8, color: AppColors.divider),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.15),
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                    blurRadius: 1,
                  ), //BoxShadow
                ],
              ),
              padding: const EdgeInsets.only(left: 10, right: 10),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.08,
                    width: Get.width * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 17,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        height: 17,
                        width: 75,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Container(
                        height: 17,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ).paddingOnly(top: 10, bottom: 10, left: 10),
                  const Spacer(),
                  Container(
                    height: 25,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            );
          },
        ).paddingOnly(bottom: 15),
      ),
    );
  }

  static Shimmer getChatThumbListShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        itemCount: 6,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.15,
                      width: Get.width * 0.15,
                      decoration: BoxDecoration(color: AppColors.divider, shape: BoxShape.circle),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                    ).paddingOnly(left: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 13,
                                width: 75,
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                              ),
                              Container(
                                height: 13,
                                width: 45,
                                decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                              ),
                            ],
                          ).paddingOnly(bottom: 2),
                          Container(
                            height: 13,
                            width: 130,
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                          )
                        ],
                      ).paddingOnly(left: 12, right: 13),
                    )
                  ],
                ),
              ),
              Divider(height: 1.2, color: AppColors.border.withOpacity(0.3)).paddingOnly(top: 10, bottom: 10)
            ],
          );
        },
      ).paddingOnly(top: 12),
    );
  }

  static Shimmer getOldChatShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: Get.width / 1.6,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 18),
                        decoration: BoxDecoration(
                          color: AppColors.senderBox,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.08),
                              blurRadius: 2,
                              spreadRadius: 1.5,
                              offset: const Offset(0.3, 0.4),
                            )
                          ],
                        ),
                        child: Text(
                          "                                         ",
                          style: AppFontStyle.fontStyleW500(
                            fontSize: 15,
                            fontColor: AppColors.white,
                          ),
                        ).paddingOnly(bottom: 5),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 8,
                        child: Text(
                          "",
                          style: AppFontStyle.fontStyleW500(
                            fontSize: 11,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 8, right: 15),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 1.6,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 12, right: 30, top: 6, bottom: 18),
                            decoration: BoxDecoration(
                              color: AppColors.receiverBox,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black.withOpacity(0.08),
                                  blurRadius: 2,
                                  spreadRadius: 1.5,
                                  offset: const Offset(0.3, 0.4),
                                )
                              ],
                            ),
                            child: Text(
                              "                                         ",
                              style: AppFontStyle.fontStyleW500(
                                fontSize: 15,
                                fontColor: AppColors.receiveMsg,
                              ),
                            ).paddingOnly(bottom: 5),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 10,
                            child: Text(
                              "",
                              style: AppFontStyle.fontStyleW500(
                                fontSize: 11,
                                fontColor: AppColors.receiveMsgDate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).paddingOnly(bottom: 10, left: 15),
                ],
              )
            ],
          );
        },
      ).paddingOnly(top: 12),
    );
  }

  static Shimmer notificationShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 10,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            width: Get.width,
            margin: const EdgeInsets.only(left: 13, right: 13, top: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColors.title.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 15,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      height: 12,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ).paddingOnly(bottom: 6),
                Container(
                  height: 15,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Shimmer providerImageShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Container(
        height: Get.height * 0.35,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.red.withOpacity(0.2),
        ),
        child: Image.asset(AppAsset.icPlaceholderProvider).paddingAll(30),
      ),
    );
  }

  static Shimmer providerDesShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 18,
                width: 120,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
              ),
              Container(
                height: 18,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Colors.red),
              ),
            ],
          ),
          Container(
            height: 18,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
          ).paddingOnly(top: 7, bottom: 7),
          Container(
            height: 18,
            width: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.height * 0.055,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ).paddingOnly(top: 12, bottom: 5),
                  Container(
                    height: 12,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.height * 0.055,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ).paddingOnly(top: 12, bottom: 5),
                  Container(
                    height: 12,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.height * 0.055,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ).paddingOnly(top: 12, bottom: 5),
                  Container(
                    height: 12,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: Get.height * 0.055,
                    width: Get.height * 0.055,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ).paddingOnly(top: 12, bottom: 5),
                  Container(
                    height: 12,
                    width: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
                  ),
                ],
              ),
            ],
          )
        ],
      ).paddingOnly(top: 10, left: 15, right: 15),
    );
  }

  static Shimmer providerAboutShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Container(
        height: 90,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.red.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 13,
              width: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
            Container(
              height: 13,
              width: 200,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
            Container(
              height: 13,
              width: 220,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
            Container(
              height: 13,
              width: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
          ],
        ).paddingAll(12),
      ).paddingOnly(top: 12, bottom: 12),
    );
  }

  static Shimmer providerServiceShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Container(
        height: Get.height * 0.063,
        decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
        margin: const EdgeInsets.only(bottom: 3),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: [
            Container(
                height: 15,
                width: 15,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
            Container(
              height: 13,
              width: 150,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  static Shimmer providerReviewShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.divider,
                width: 1.3,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 13, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.placeholder,
                      ),
                    ).paddingOnly(right: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 13,
                                width: 80,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.specialistBox,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 7),
                          Container(
                            height: 13,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(bottom: 8),
                Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                ).paddingOnly(bottom: 10)
              ],
            ),
          );
        },
      ).paddingOnly(top: 12, bottom: 12),
    );
  }

  static Shimmer reviewShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 5,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.divider,
                width: 1.3,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 13, left: 15, right: 15),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.placeholder,
                      ),
                    ).paddingOnly(right: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 13,
                                width: 80,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.specialistBox,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                                ),
                              ),
                            ],
                          ).paddingOnly(bottom: 7),
                          Container(
                            height: 13,
                            width: 150,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(bottom: 8),
                Container(
                  height: 12,
                  width: 150,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.red),
                ).paddingOnly(bottom: 10)
              ],
            ),
          );
        },
      ).paddingOnly(top: 12, bottom: 12),
    );
  }

  static Shimmer bookingInfoShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Column(
        children: [
          Container(
            height: 100,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ).paddingOnly(left: 10),
                Expanded(
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ).paddingOnly(left: 10,right: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 120,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: 120,
            width: Get.width,
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ).paddingOnly(left: 10),
                    Expanded(
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ).paddingOnly(left: 10,right: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).paddingAll(12),
    );
  }

  static Shimmer upcomingAppointmentShimmer() {
    return Shimmer.fromColors(
      baseColor: Constant.baseColor,
      highlightColor: Constant.highlightColor,
      period: Constant.period,
      child: Container(
        height: 235,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1.5,
            color: Colors.red.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.125,
              child: Row(
                children: [
                  Container(
                    height: Get.height * 0.125,
                    width: Get.width * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 16,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                        ),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppColors.specialistBox,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            child: Text(
                              "",
                              style: AppFontStyle.fontStyleW500(
                                fontSize: 11.5,
                                fontColor: AppColors.specialist,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 16,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.red,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.specialistBox,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                                child: Text(
                                  "At Clinic",
                                  style: AppFontStyle.fontStyleW500(
                                    fontSize: 11.5,
                                    fontColor: AppColors.tabUnselectText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(left: 10, top: 5, bottom: 5),
                  )
                ],
              ),
            ),
            Container(
              height: 30,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.red,
              ),
            ).paddingOnly(bottom: 8,top: 12),
          ],
        ).paddingAll(12),
      ).paddingOnly(left: 12, right: 12, bottom: 18),
    );
  }
}
