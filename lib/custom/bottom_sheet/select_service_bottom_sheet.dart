import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/utils.dart';

class SelectServiceBottomSheet extends StatelessWidget {
  final List services;
  final int index;
  final int serviceIndex;
  final String providerId;

  const SelectServiceBottomSheet({
    super.key,
    required this.services,
    required this.index,
    required this.serviceIndex,
    required this.providerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<HomeScreenController>(
            builder: (logic) {
              return Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  color: AppColors.primaryAppColor1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      EnumLocale.txtSelectService.name.tr,
                      style: AppFontStyle.fontStyleW800(
                        fontSize: 19,
                        fontColor: AppColors.white,
                      ),
                    ).paddingOnly(left: 20),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.back();

                        logic.selectedService = -1;
                      },
                      child: Image.asset(
                        AppAsset.icClose,
                        height: Get.height * 0.07,
                        width: Get.width * 0.07,
                      ).paddingOnly(right: 15),
                    )
                  ],
                ),
              ).paddingOnly(bottom: 10);
            },
          ),
          GetBuilder<HomeScreenController>(
            id: Constant.idServiceSelected,
            builder: (logic) {
              return Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: services.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, serviceIndex) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: services.length,
                      child: SlideAnimation(
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () {
                              logic.onSelectService(serviceIndex);
                              logic.serviceId = services[serviceIndex].serviceId ?? "";
                              logic.servicePrice = services[serviceIndex].price.toString();
                              logic.serviceName = services[serviceIndex].name;

                              log("Service ID Home Screen :: ${logic.serviceId}");
                              log("Service Price Home Screen :: ${logic.servicePrice}");
                              log("Service Name Home Screen :: ${logic.serviceName}");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.white,
                                border: Border.all(color: AppColors.serviceBorder, width: 1),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.boxShadow.withOpacity(0.1),
                                    blurRadius: 1,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: Get.width * 0.15,
                                    padding: const EdgeInsets.all(13),
                                    margin: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppColors.colorList[serviceIndex % AppColors.colorList.length],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: "${ApiConstant.BASE_URL}${services[serviceIndex].image ?? ""}",
                                      placeholder: (context, url) {
                                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                                      },
                                    ),
                                  ).paddingOnly(bottom: 8, top: 8, left: 8),
                                  Column(
                                    children: [
                                      SizedBox(
                                        width: Get.width * 0.60,
                                        child: Text(
                                          services[serviceIndex].name ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.fontStyleW700(
                                            fontSize: 16,
                                            fontColor: AppColors.appButton,
                                          ),
                                        ),
                                      ).paddingOnly(left: 10),
                                      SizedBox(
                                        width: Get.width * 0.60,
                                        child: Text(
                                          "$currency ${services[serviceIndex].price.toString()}",
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.fontStyleW800(
                                            fontSize: 15,
                                            fontColor: AppColors.primaryAppColor1,
                                          ),
                                        ),
                                      ).paddingOnly(left: 10),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                      color: logic.selectedService == serviceIndex
                                          ? AppColors.colorList[serviceIndex % AppColors.colorList.length]
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: logic.selectedService == serviceIndex
                                            ? AppColors.appButton
                                            : AppColors.tabUnselectText.withOpacity(0.3),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: logic.selectedService == serviceIndex
                                        ? Image.asset(AppAsset.icCheck).paddingAll(7)
                                        : const SizedBox(),
                                  ).paddingOnly(right: 15),
                                ],
                              ),
                            ).paddingOnly(bottom: 10),
                          ),
                        ),
                      ),
                    );
                  },
                ).paddingOnly(left: 11, right: 11, top: 5),
              );
            },
          ),
          Center(
            child: GetBuilder<HomeScreenController>(
              id: Constant.idServiceSelected,
              builder: (logic) {
                return GestureDetector(
                  onTap: () {
                    if (logic.selectedService == -1) {
                      Utils.showToast(Get.context!, EnumLocale.desPleaseSelectService.name.tr);
                    } else {
                      Get.toNamed(
                        AppRoutes.providerDetail,
                        arguments: [
                          AppColors.colorList[index % AppColors.colorList.length],
                          AppColors.textColorList[index % AppColors.textColorList.length],
                          providerId,
                          services[serviceIndex].serviceId,
                          services[serviceIndex].price.toString(),
                          services[serviceIndex].name,
                        ],
                      );
                    }
                  },
                  child: PrimaryAppButton(
                    text: EnumLocale.txtContinue.name.tr,
                    height: 52,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 17,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ).paddingOnly(
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
