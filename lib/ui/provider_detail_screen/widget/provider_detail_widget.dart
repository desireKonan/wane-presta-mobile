import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/provider_detail_screen/controller/provider_detail_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class ProviderDetailAppBarView extends StatelessWidget {
  const ProviderDetailAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<ProviderDetailController>(
          id: Constant.idGetProviderInfo,
          builder: (logic) {
            return logic.isLoading
                ? Shimmers.providerImageShimmer()
                : Container(
                    height: Get.height * 0.35,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.divider.withOpacity(0.5),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${logic.getProviderInfoModel?.providerInfo?.profileImage ?? ""}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(40);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(40);
                      },
                    ),
                  );
          },
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 15, top: 15),
            child: Image.asset(AppAsset.icArrowRight),
          ).paddingOnly(top: 20),
        ),
      ],
    );
  }
}

/// =================== Bottom Bar =================== ///
class ProviderDetailBottomView extends StatelessWidget {
  const ProviderDetailBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            offset: const Offset(
              3.0,
              3.0,
            ),
            blurRadius: 8.0,
          ), //BoxShadow
        ],
      ),
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  logic.onBookNowClick();
                },
                child: PrimaryAppButton(
                  width: Get.width * 0.76,
                  text: "${EnumLocale.txtBookNow.name.tr} $currency ${logic.servicePrice ?? 0.0}",
                  textStyle: AppFontStyle.fontStyleW900(
                    fontSize: 17,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
              ),
              PrimaryAppButton(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.personalChat,
                    arguments: [
                      logic.getProviderInfoModel?.providerInfo?.id,
                      "",
                      logic.getProviderInfoModel?.providerInfo?.name,
                      logic.getProviderInfoModel?.providerInfo?.profileImage,
                      logic.serviceName,
                    ],
                  );
                },
                width: Get.width * 0.14,
                borderRadius: 11,
                widget: Image.asset(AppAsset.icMessage, height: 25),
                color: AppColors.message,
              ),
            ],
          );
        },
      ),
    );
  }
}

/// =================== Information =================== ///
class ProviderDetailInfoView extends StatelessWidget {
  const ProviderDetailInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderDetailController>(
      id: Constant.idGetProviderInfo,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.providerDesShimmer()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        logic.getProviderInfoModel?.providerInfo?.name ?? "",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 20,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      logic.getProviderInfoModel?.providerInfo?.isFavorite == true
                          ? Image.asset(AppAsset.icSavedFilled, height: 23)
                          : Image.asset(AppAsset.icSavedOutline, height: 23)
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: logic.color ?? AppColors.transparent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                      child: Text(
                        logic.serviceName ?? "",
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 13,
                          fontColor: logic.textColor ?? AppColors.transparent,
                        ),
                      ),
                    ),
                  ).paddingOnly(right: 10).paddingOnly(left: 15, top: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icExperience),
                            ),
                            RichText(
                              text: TextSpan(
                                text: logic.getProviderInfoModel?.providerInfo?.experience.toString() ?? "",
                                style: AppFontStyle.fontStyleW800(
                                  fontSize: 15,
                                  fontColor: AppColors.mainTitleText,
                                ),
                                children: [
                                  TextSpan(
                                    text: EnumLocale.txtYear.name.tr,
                                    style: AppFontStyle.fontStyleW600(
                                      fontSize: 11,
                                      fontColor: AppColors.mainTitleText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              EnumLocale.txtExperiences.name.tr,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icHappy),
                            ),
                            Text(
                              logic.getProviderInfoModel?.providerInfo?.totalCustomers.toString() ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              EnumLocale.txtHappyPatients.name.tr,
                              overflow: TextOverflow.ellipsis,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icRating),
                            ),
                            Text(
                              logic.getProviderInfoModel?.providerInfo?.avgRating?.toStringAsFixed(1) ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              EnumLocale.txtRatings.name.tr,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: AppColors.primaryAppColor1,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Image.asset(AppAsset.icReview),
                            ),
                            Text(
                              logic.getProviderInfoModel?.providerInfo?.reviewCount.toString() ?? "",
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.mainTitleText,
                              ),
                            ),
                            Text(
                              EnumLocale.txtReviews.name.tr,
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.categoryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15, right: 15, top: 12),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: AppColors.divider,
                      ),
                    ),
                  ).paddingOnly(top: 10),
                ],
              );
      },
    );
  }
}

/// =================== Tab Bar =================== ///
class ProviderDetailTabView extends StatelessWidget {
  const ProviderDetailTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProviderDetailTabBarView(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: AppColors.divider,
            ),
          ),
        ).paddingOnly(bottom: 10),
        const ProviderDetailTabBarItemView(),
      ],
    );
  }
}

class ProviderDetailTabBarView extends StatelessWidget {
  const ProviderDetailTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(text: EnumLocale.txtAboutMe.name.tr),
      Tab(text: EnumLocale.txtServiceDetails.name.tr),
      Tab(text: EnumLocale.txtContactDetails.name.tr),
      Tab(text: EnumLocale.txtWorkReviews.name.tr),
      Tab(text: EnumLocale.txtWorkExperiences.name.tr),
      Tab(text: EnumLocale.txtImages.name.tr),
    ];

    return GetBuilder<ProviderDetailController>(
      builder: (logic) {
        return TabBar(
          controller: logic.tabController,
          tabs: tabs,
          labelStyle: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.white,
          ),
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          indicatorPadding: const EdgeInsets.all(8),
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.appButton),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.white,
          unselectedLabelStyle: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.tabUnselectText,
          ),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
        );
      },
    );
  }
}

class ProviderDetailTabBarItemView extends StatelessWidget {
  const ProviderDetailTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<ProviderDetailController>(
        builder: (logic) {
          return TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: logic.tabController,
            children: const [
              DetailScreen(),
              ServiceDetailsScreen(),
              ContactDetailsScreen(),
              WorkReviewScreen(),
              WorkExperienceScreen(),
              ImagesScreen(),
            ],
          );
        },
      ),
    );
  }
}

/// =================== Tab Bar Items =================== ///

/// Details
class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return logic.isLoading
              ? Shimmers.providerAboutShimmer()
              : logic.getProviderInfoModel?.providerInfo?.yourSelf?.isEmpty == true
                  ? NoDataFound(
                      image: AppAsset.icNoDataAppointment,
                      imageHeight: 140,
                      text: EnumLocale.noDataFound.name.tr,
                      padding: const EdgeInsets.only(top: 7),
                    ).paddingOnly(bottom: Get.height * 0.45)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAsset.icAboutMe,
                              height: 25,
                              width: 25,
                            ).paddingOnly(right: 8),
                            Text(
                              EnumLocale.txtAboutMe.name.tr,
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.appButton,
                              ),
                            )
                          ],
                        ).paddingOnly(left: 15),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                          child: Text(
                            logic.getProviderInfoModel?.providerInfo?.yourSelf ?? "",
                            style: AppFontStyle.fontStyleW500(
                              fontSize: 13,
                              fontColor: AppColors.appText,
                            ),
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}

/// Service Details
class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return logic.isLoading
              ? Shimmers.providerServiceShimmer()
              : logic.getProviderInfoModel?.providerInfo?.serviceSummary?.isEmpty == true
                  ? NoDataFound(
                      image: AppAsset.icNoDataAppointment,
                      imageHeight: 140,
                      text: EnumLocale.noDataFound.name.tr,
                      padding: const EdgeInsets.only(top: 7),
                    ).paddingOnly(bottom: Get.height * 0.45)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAsset.icServices,
                              height: 25,
                              width: 25,
                            ).paddingOnly(right: 8),
                            Text(
                              EnumLocale.txtServiceDetails.name.tr,
                              style: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.appButton,
                              ),
                            )
                          ],
                        ).paddingOnly(left: 15),
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                          child: Text(
                            logic.getProviderInfoModel?.providerInfo?.serviceSummary ?? "",
                            style: AppFontStyle.fontStyleW500(
                              fontSize: 13,
                              fontColor: AppColors.appText,
                            ),
                          ),
                        )
                      ],
                    );
        },
      ),
    );
  }
}

/// Contact Details
class ContactDetailsScreen extends StatelessWidget {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return logic.getProviderInfoModel?.providerInfo?.serviceSummary?.isEmpty == true
              ? NoDataFound(
                  image: AppAsset.icNoDataAppointment,
                  imageHeight: 140,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 7),
                ).paddingOnly(bottom: Get.height * 0.45)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppAsset.icContactDetails,
                          height: 25,
                          width: 25,
                        ).paddingOnly(right: 8),
                        Text(
                          EnumLocale.txtContactDetails.name.tr,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.appButton,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 15),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: AppColors.back,
                      child: Row(
                        children: [
                          Image.asset(
                            AppAsset.icCall,
                            height: 25,
                            width: 25,
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(right: 11),
                          Text(
                            logic.getProviderInfoModel?.providerInfo?.mobileNumber ?? "",
                            style: AppFontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.appText,
                            ),
                          )
                        ],
                      ),
                    ).paddingOnly(top: 25),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      color: AppColors.back,
                      child: Row(
                        children: [
                          Image.asset(
                            AppAsset.icLocationFilled,
                            height: 25,
                            width: 25,
                          ).paddingOnly(right: 11),
                          Text(
                            logic.getProviderInfoModel?.providerInfo?.country ?? "",
                            style: AppFontStyle.fontStyleW700(
                              fontSize: 15,
                              fontColor: AppColors.appText,
                            ),
                          )
                        ],
                      ),
                    ).paddingOnly(top: 20),
                  ],
                );
        },
      ),
    );
  }
}

/// Work Reviews
class WorkReviewScreen extends StatelessWidget {
  const WorkReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        height: 150,
        child: Center(
          child: GetBuilder<ProviderDetailController>(
            id: Constant.idGetProviderInfo,
            builder: (logic) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    logic.getProviderInfoModel?.providerInfo?.avgRating?.toStringAsFixed(1) ?? "",
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 30,
                      fontColor: AppColors.rating,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppAsset.icStarFilled,
                          height: 18,
                          width: 18,
                        ).paddingOnly(right: 10);
                      },
                    ),
                  ),
                  Text(
                    "(${logic.getProviderInfoModel?.providerInfo?.reviewCount ?? ""} ${EnumLocale.txtRatings.name.tr})",
                    style: AppFontStyle.fontStyleW700(
                      fontSize: 14,
                      fontColor: AppColors.tabUnselectText,
                    ),
                  ).paddingOnly(top: 5),
                  logic.getProviderInfoModel?.providerInfo?.reviewCount == 0
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.rating,
                              arguments: [logic.getProviderInfoModel?.providerInfo?.id],
                            );
                          },
                          child: Container(
                            height: 35,
                            width: 170,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryAppColor1,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  EnumLocale.txtViewMoreDetails.name.tr,
                                  style: AppFontStyle.fontStyleW700(
                                    fontSize: 14,
                                    fontColor: AppColors.white,
                                  ),
                                ),
                                Image.asset(
                                  AppAsset.icArrowUp,
                                  height: 20,
                                )
                              ],
                            ).paddingOnly(left: 10, right: 10),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ).paddingOnly(top: 10),
    );
  }
}

/// Work Experience
class WorkExperienceScreen extends StatelessWidget {
  const WorkExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return logic.getProviderInfoModel?.providerInfo?.workHistory?.isEmpty == true
              ? NoDataFound(
                  image: AppAsset.icNoDataAppointment,
                  imageHeight: 140,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 7),
                ).paddingOnly(bottom: Get.height * 0.45)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppAsset.icExperience,
                          height: 25,
                          width: 25,
                          color: AppColors.appButton,
                        ).paddingOnly(right: 8),
                        Text(
                          EnumLocale.txtWorkExperiences.name.tr,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.appButton,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 15),
                    SizedBox(
                      height: Get.height,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: logic.getProviderInfoModel?.providerInfo?.workHistory?.length ?? 0,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                height: Get.height * 0.01,
                                width: Get.height * 0.01,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.appText,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.83,
                                child: Text(
                                  logic.getProviderInfoModel?.providerInfo?.workHistory?[index].trim() ?? "",
                                  style: AppFontStyle.fontStyleW500(
                                    fontSize: 13,
                                    fontColor: AppColors.appText,
                                  ),
                                ),
                              )
                            ],
                          ).paddingOnly(left: 15, right: 15, bottom: 7);
                        },
                      ).paddingOnly(top: 12, bottom: 12),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

/// Images
class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: GetBuilder<ProviderDetailController>(
        id: Constant.idGetProviderInfo,
        builder: (logic) {
          return logic.getProviderInfoModel?.providerInfo?.photoAlbum?.isEmpty == true
              ? NoDataFound(
                  image: AppAsset.icNoDataAppointment,
                  imageHeight: 140,
                  text: EnumLocale.noDataFound.name.tr,
                  padding: const EdgeInsets.only(top: 7),
                ).paddingOnly(bottom: Get.height * 0.45)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          AppAsset.icImage,
                          height: 25,
                          width: 25,
                        ).paddingOnly(right: 8),
                        Text(
                          EnumLocale.txtImages.name.tr,
                          style: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.appButton,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 15),
                    GridView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: logic.getProviderInfoModel?.providerInfo?.photoAlbum?.length ?? 0,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        mainAxisExtent: 120,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.divider.withOpacity(0.5),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl:
                                "${ApiConstant.BASE_URL}${logic.getProviderInfoModel?.providerInfo?.photoAlbum?[index] ?? ""}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return Image.asset(AppAsset.icPlaceholderImage).paddingAll(25);
                            },
                            errorWidget: (context, url, error) {
                              return Image.asset(AppAsset.icPlaceholderImage).paddingAll(25);
                            },
                          ),
                        );
                      },
                    ).paddingAll(12),
                  ],
                );
        },
      ),
    );
  }
}
