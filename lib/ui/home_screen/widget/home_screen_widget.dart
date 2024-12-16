import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/bottom_sheet/select_service_bottom_sheet.dart';
import 'package:handy/custom/bottom_sheet/upcoming_appointment_bottom_sheet.dart';
import 'package:handy/custom/title/custom_main_title.dart';
import 'package:handy/custom/view_all_text/view_all.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/home_screen/controller/home_screen_controller.dart';
import 'package:handy/ui/home_screen/model/get_service_model.dart';
import 'package:handy/ui/home_screen/model/get_top_rated_provider_model.dart';
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
import 'package:handy/utils/utils.dart';
import 'package:scroll_page_view/scroll_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// =================== Top View =================== ///
class HomeTopView extends StatelessWidget {
  const HomeTopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryAppColor1,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white,
                ),
                padding: const EdgeInsets.all(0.8),
                child: CachedNetworkImage(
                  imageUrl: "${ApiConstant.BASE_URL}${Constant.storage.read("customerImage")}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Image.asset(AppAsset.icPlaceholderImage).paddingAll(10);
                  },
                  errorWidget: (context, url, error) {
                    return Image.asset(AppAsset.icPlaceholderImage).paddingAll(10);
                  },
                ),
              ).paddingOnly(right: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${EnumLocale.txtHello.name.tr} ${Constant.storage.read("customerName")}',
                    style: AppFontStyle.fontStyleW900(
                      fontSize: 18,
                      fontColor: AppColors.appButton,
                    ),
                  ),
                  Text(
                    EnumLocale.desToday.name.tr,
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 13,
                      fontColor: AppColors.appButton,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.notification);
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(AppAsset.icNotification),
                ),
              ),
            ],
          ).paddingOnly(top: 38, left: 15, right: 15),
          const HomeSearchView(),
        ],
      ),
    );
  }
}

/// =================== Upcoming Appointment =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        return CustomMainTitle(
          title: EnumLocale.txtUpcomingAppointment.name.tr,
          method: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.upcomingAppointment);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryAppColor1,
                borderRadius: BorderRadius.circular(7),
              ),
              child: const ViewAllTitle(),
            ),
          ),
        ).paddingOnly(left: 15, right: 15, top: 15, bottom: 10);
      },
    );
  }
}

class MyAppointmentItemView extends StatelessWidget {
  const MyAppointmentItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        return SizedBox(
          height: 190,
          child: logic.isLoading
              ? Shimmers.upcomingAppointmentShimmer()
              : PageView.builder(
                  itemCount: (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5
                      ? 5
                      : logic.getUpcomingAppointmentModel?.data?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  controller: logic.pageController,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return UpcomingAppointmentBottomSheet(
                              profileImage: logic.getUpcomingAppointmentModel?.data?[index].provider?.profileImage ?? "",
                              providerName: logic.getUpcomingAppointmentModel?.data?[index].provider?.name ?? "",
                              serviceName: logic.getUpcomingAppointmentModel?.data?[index].service?.name ?? "",
                              serviceProviderFee:
                                  logic.getUpcomingAppointmentModel?.data?[index].serviceProviderFee.toString() ?? "",
                              rating:
                                  logic.getUpcomingAppointmentModel?.data?[index].provider?.avgRating?.toStringAsFixed(1) ?? "",
                              time: logic.getUpcomingAppointmentModel?.data?[index].time ?? "",
                              date: logic.getUpcomingAppointmentModel?.data?[index].date ?? "",
                              providerId: logic.getUpcomingAppointmentModel?.data?[index].provider?.id ?? "",
                              appointmentUniqueId: logic.getUpcomingAppointmentModel?.data?[index].appointmentId ?? "",
                              appointmentId: logic.getUpcomingAppointmentModel?.data?[index].id ?? "",
                              isViewAll: false,
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 195,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            width: 1.5,
                            color: AppColors.serviceBorder,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.divider.withOpacity(0.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${ApiConstant.BASE_URL}${logic.getUpcomingAppointmentModel?.data?[index].provider?.profileImage ?? ""}",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                      },
                                      errorWidget: (context, url, error) {
                                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: Get.width * 0.02),
                                SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        logic.getUpcomingAppointmentModel?.data?[index].provider?.name ?? "",
                                        style: AppFontStyle.fontStyleW900(
                                          fontSize: 16,
                                          fontColor: AppColors.appButton,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: AppColors.colorList[index % AppColors.colorList.length],
                                        ),
                                        child: Text(
                                          logic.getUpcomingAppointmentModel?.data?[index].service?.name ?? "",
                                          style: AppFontStyle.fontStyleW600(
                                            fontSize: 12,
                                            fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "$currency ${logic.getUpcomingAppointmentModel?.data?[index].serviceProviderFee ?? ""}",
                                        style: AppFontStyle.fontStyleW800(
                                          fontSize: 18,
                                          fontColor: AppColors.primaryAppColor1,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(AppAsset.icStarFilled, height: 14),
                                          Text(
                                            "  ${logic.getUpcomingAppointmentModel?.data?[index].provider?.avgRating?.toStringAsFixed(1) ?? ""}",
                                            style: AppFontStyle.fontStyleW800(
                                              fontSize: 15,
                                              fontColor: AppColors.rating,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.divider,
                                  ),
                                  child: Text(
                                    logic.getUpcomingAppointmentModel?.data?[index].appointmentId ?? "",
                                    style: AppFontStyle.fontStyleW600(
                                      fontSize: 12,
                                      fontColor: AppColors.tabUnselectText,
                                    ),
                                  ),
                                ).paddingOnly(bottom: 3),
                              ],
                            ).paddingOnly(left: 7, right: 7),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.divider,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(18),
                                  bottomRight: Radius.circular(18),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryAppColor1,
                                    ),
                                    child: Image.asset(
                                      AppAsset.icAppointmentFilled,
                                      color: AppColors.white,
                                    ).paddingAll(10),
                                  ).paddingOnly(right: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        logic.getUpcomingAppointmentModel?.data?[index].time ?? "",
                                        style: AppFontStyle.fontStyleW900(
                                          fontSize: 14,
                                          fontColor: AppColors.appButton,
                                        ),
                                      ),
                                      Text(
                                        EnumLocale.txtBookingTiming.name.tr,
                                        style: AppFontStyle.fontStyleW600(
                                          fontSize: 12,
                                          fontColor: AppColors.categoryText,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 36,
                                    width: 2,
                                    color: AppColors.serviceBorder,
                                  ),
                                  const Spacer(),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.primaryAppColor1,
                                    ),
                                    child: Image.asset(AppAsset.icClock).paddingAll(10),
                                  ).paddingOnly(right: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        logic.getUpcomingAppointmentModel?.data?[index].date ?? "",
                                        style: AppFontStyle.fontStyleW900(
                                          fontSize: 14,
                                          fontColor: AppColors.appButton,
                                        ),
                                      ),
                                      Text(
                                        EnumLocale.txtBookingDate.name.tr,
                                        style: AppFontStyle.fontStyleW600(
                                          fontSize: 12,
                                          fontColor: AppColors.categoryText,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ).paddingOnly(top: 10),
                          ],
                        ).paddingOnly(top: 7),
                      ).paddingOnly(left: 12, right: 12, bottom: 10),
                    );
                  },
                ),
        );
      },
    );
  }
}

class MyAppointmentIndicator extends StatelessWidget {
  const MyAppointmentIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetUpcomingAppointment,
      builder: (logic) {
        return logic.isLoading
            ? const SizedBox()
            : Center(
                child: SmoothPageIndicator(
                  controller: logic.pageController,
                  count: (logic.getUpcomingAppointmentModel?.data?.length ?? 0) > 5
                      ? 5
                      : logic.getUpcomingAppointmentModel?.data?.length ?? 0,
                  axisDirection: Axis.horizontal,
                  effect: SwapEffect(
                    spacing: 8,
                    radius: 6,
                    dotWidth: 10,
                    dotHeight: 10,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 1.2,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryAppColor1,
                  ),
                ).paddingOnly(top: 8),
              );
      },
    );
  }
}

/// =================== Search =================== ///
class HomeSearchView extends StatelessWidget {
  const HomeSearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.search);
      },
      child: Container(
        height: 47,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.searchBox,
        ),
        child: Row(
          children: [
            Image.asset(AppAsset.icSearch, height: 20).paddingOnly(left: 10, right: 3),
            VerticalDivider(
              endIndent: 13,
              indent: 13,
              thickness: 1.5,
              color: AppColors.appButton,
            ),
            Text(
              EnumLocale.txtFindOurServices.name.tr,
              style: AppFontStyle.fontStyleW600(
                fontSize: 15,
                fontColor: AppColors.appButton,
              ),
            ).paddingOnly(left: 5),
            const Spacer(),
            Image.asset(AppAsset.icCategory, height: 20).paddingOnly(right: 10),
          ],
        ),
      ).paddingOnly(left: 15, right: 15, top: 15, bottom: 10),
    );
  }
}

/// =================== Banner =================== ///
class HomeBannerTitleView extends StatelessWidget {
  const HomeBannerTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: EnumLocale.txtSpecialOffers.name.tr,
      method: const SizedBox(),
    ).paddingOnly(left: 15, bottom: 5, top: 15);
  }
}

class HomeBannerView extends StatelessWidget {
  const HomeBannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetBanner,
      builder: (logic) {
        logic.bannersImages = (logic.getBannerModel?.data?.map((item) => item.image).toList());

        logic.type = (logic.getBannerModel?.data?.map((item) => item.type).toList());

        return logic.getBannerModel?.data?.isEmpty == true
            ? const SizedBox.shrink()
            : logic.isLoading
                ? Shimmers.homeBannerShimmer()
                : Container(
                    height: Get.height * 0.25,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.divider,
                    ),
                    child: ScrollPageView(
                      controller: ScrollPageController(),
                      indicatorColor: AppColors.bannerIndicator,
                      checkedIndicatorColor: AppColors.primaryAppColor1,
                      indicatorAlign: Alignment.bottomCenter,
                      indicatorPadding: const EdgeInsets.all(5),
                      indicatorRadius: 8,
                      children: logic.bannersImages?.asMap().entries.map(
                            (entry) {
                              int index = entry.key;
                              String image = entry.value;

                              return GestureDetector(
                                onTap: () {
                                  if (logic.type!.isNotEmpty && index < logic.type!.length) {
                                    if (logic.type?[index] == 2) {
                                      Utils.launchURL(logic.getBannerModel?.data?[index].url ?? "");
                                    } else if (logic.type?[index] == 1) {
                                      Get.toNamed(
                                        AppRoutes.categoryDetail,
                                        arguments: [
                                          logic.getBannerModel?.data?[index].service?.name,
                                          logic.getBannerModel?.data?[index].service?.id,
                                        ],
                                      );
                                    }
                                  }
                                },
                                child: logic.imageView(image),
                              );
                            },
                          ).toList() ??
                          [],
                    ),
                  ).paddingOnly(left: 12, right: 12);
      },
    );
  }
}

/// =================== Category =================== ///
class HomeCategoryTitleView extends StatelessWidget {
  const HomeCategoryTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: EnumLocale.txtOurServices.name.tr,
      method: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.category);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const ViewAllTitle(),
        ),
      ),
    ).paddingOnly(left: 15, right: 15, top: 15, bottom: 10);
  }
}

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeServiceShimmer()
            : GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: (logic.getServiceModel?.data?.length ?? 0) > 8 ? 8 : (logic.getServiceModel?.data?.length ?? 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.71,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    columnCount: (logic.getServiceModel?.data?.length ?? 0) > 8 ? 8 : (logic.getServiceModel?.data?.length ?? 0),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: HomeCategoryItemView(
                          index: index,
                          getServiceData: logic.getServiceModel?.data?[index] ?? GetServiceData(),
                        ),
                      ),
                    ),
                  );
                },
              ).paddingOnly(left: 11, right: 11, top: 5);
      },
    );
  }
}

class HomeCategoryItemView extends StatelessWidget {
  final int index;
  final GetServiceData getServiceData;

  const HomeCategoryItemView({super.key, required this.index, required this.getServiceData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetService,
      builder: (logic) {
        return SizedBox(
          height: Get.height * 0.15,
          child: GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.categoryDetail,
                arguments: [
                  getServiceData.name,
                  getServiceData.id,
                ],
              );
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
              child: Column(
                children: [
                  Container(
                    width: Get.width * 0.17,
                    padding: const EdgeInsets.all(15),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.colorList[index % AppColors.colorList.length],
                    ),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${getServiceData.image ?? ""}",
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderService).paddingAll(2);
                      },
                    ),
                  ).paddingOnly(bottom: 6, top: 5),
                  SizedBox(
                    width: Get.width * 0.15,
                    child: Center(
                      child: Text(
                        getServiceData.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.fontStyleW700(
                          fontSize: 12,
                          fontColor: AppColors.categoryText,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ).paddingOnly(bottom: 10),
          ),
        );
      },
    );
  }
}

/// =================== Top Rated Worker Title =================== ///
class HomeTopRatedTitleView extends StatelessWidget {
  const HomeTopRatedTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomMainTitle(
      title: EnumLocale.txtTopRatedWorker.name.tr,
      method: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.topRatedWorker);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.primaryAppColor1,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const ViewAllTitle(),
        ),
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 10, top: 10);
  }
}

class HomeTopRatedListView extends StatelessWidget {
  const HomeTopRatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedProvider,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTopRatedProviderShimmer()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: (logic.getTopRatedProviderModel?.data?.length ?? 0) > 5
                    ? 5
                    : (logic.getTopRatedProviderModel?.data?.length ?? 0),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 600),
                    columnCount: (logic.getTopRatedProviderModel?.data?.length ?? 0) > 5
                        ? 5
                        : (logic.getTopRatedProviderModel?.data?.length ?? 0),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: HomeTopRatedListItemView(
                          index: index,
                          getTopRatedProviderData: logic.getTopRatedProviderModel?.data![index] ?? GetTopRatedProviderData(),
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}

class HomeTopRatedListItemView extends StatelessWidget {
  final int index;
  final GetTopRatedProviderData getTopRatedProviderData;

  const HomeTopRatedListItemView({
    super.key,
    required this.index,
    required this.getTopRatedProviderData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      id: Constant.idGetTopRatedProvider,
      builder: (logic) {
        final int serviceIndex =
            getTopRatedProviderData.services?.isNotEmpty == true ? getTopRatedProviderData.services!.length - 1 : -1;

        return GestureDetector(
          onTap: () {
            getTopRatedProviderData.services?.length == 1
                ? Get.toNamed(
                    AppRoutes.providerDetail,
                    arguments: [
                      AppColors.colorList[index % AppColors.colorList.length],
                      AppColors.textColorList[index % AppColors.textColorList.length],
                      getTopRatedProviderData.id,
                      getTopRatedProviderData.services?[serviceIndex].serviceId,
                      getTopRatedProviderData.services?[serviceIndex].price.toString(),
                      getTopRatedProviderData.services?[serviceIndex].name,
                    ],
                  )
                : showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return SelectServiceBottomSheet(
                        services: getTopRatedProviderData.services ?? [],
                        index: index,
                        serviceIndex: serviceIndex,
                        providerId: getTopRatedProviderData.id ?? "",
                      );
                    },
                  );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.divider,
                width: 0.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.boxShadow.withOpacity(0.1),
                  blurRadius: 0.3,
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.divider.withOpacity(0.5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: "${ApiConstant.BASE_URL}${getTopRatedProviderData.profileImage ?? ""}",
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(AppAsset.icPlaceholderProvider).paddingAll(10);
                      },
                    ),
                  ),
                ),
                SizedBox(width: Get.width * 0.02),
                SizedBox(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTopRatedProviderData.name ?? "",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.colorList[index % AppColors.colorList.length],
                        ),
                        child: Text(
                          getTopRatedProviderData.services?.map((service) => service.name).join(", ") ?? "",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getTopRatedProviderData.avgRating?.toStringAsFixed(1)}",
                            style: AppFontStyle.fontStyleW800(
                              fontSize: 15,
                              fontColor: AppColors.rating,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GetBuilder<HomeScreenController>(
                  id: Constant.idServiceSaved,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        logic.onProviderSaved(
                          customerId: Constant.storage.read("customerId"),
                          providerId: getTopRatedProviderData.id ?? "",
                        );
                      },
                      child: logic.isProviderSaved[index] == true
                          ? Image.asset(AppAsset.icSavedFilled, height: 22)
                          : Image.asset(AppAsset.icSavedOutline, height: 22),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
