import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/dialog/cancel_appointment_dialog.dart';
import 'package:handy/custom/dialog/review_dialog.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/appointment_screen/controller/appointment_screen_controller.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class AppointmentAppBarView extends StatelessWidget {
  const AppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtMyBooking.name.tr,
      showLeadingIcon: false,
    );
  }
}

/// =================== Tab Bar =================== ///
class AppointmentTabView extends StatelessWidget {
  const AppointmentTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtViewAppointment.name.tr,
          style: AppFontStyle.fontStyleW900(
            fontSize: 16,
            fontColor: AppColors.appButton,
          ),
        ).paddingOnly(top: 15, left: 15),
        const AppointmentTabBarView(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: AppColors.divider,
            ),
          ),
        ).paddingOnly(bottom: 10),
        const AppointmentTabBarItemView(),
      ],
    );
  }
}

class AppointmentTabBarView extends StatelessWidget {
  const AppointmentTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    var tabs = [
      Tab(text: EnumLocale.txtPendingAppointment.name.tr),
      Tab(text: EnumLocale.txtCancelledAppointment.name.tr),
      Tab(text: EnumLocale.txtCompletedAppointment.name.tr),
    ];

    return GetBuilder<AppointmentScreenController>(
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
          indicatorPadding: const EdgeInsets.all(5),
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

class AppointmentTabBarItemView extends StatelessWidget {
  const AppointmentTabBarItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return Expanded(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: logic.tabController,
            children: const [
              PendingAppointment(),
              CancelAppointment(),
              CompleteAppointment(),
            ],
          ),
        );
      },
    );
  }
}

/// =================== Pending Appointment =================== ///
class PendingAppointment extends StatelessWidget {
  const PendingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getPending.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundPendingAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                color: AppColors.primaryAppColor1,
                onRefresh: () => logic.onPendingRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getPending.length,
                        controller: logic.pendingScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getPending.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: PendingAppointmentListItemView(
                                  index: index,
                                  getAllAppointmentData: logic.getPending[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class PendingAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllAppointmentData;

  const PendingAppointmentListItemView({
    super.key,
    required this.index,
    required this.getAllAppointmentData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.bookingInformation,
          arguments: [
            getAllAppointmentData.id,
            AppColors.colorList[index % AppColors.colorList.length],
            AppColors.textColorList[index % AppColors.textColorList.length],
          ],
        );
      },
      child: Container(
        height: getAllAppointmentData.status == 2 ? 215 : 235,
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
                      imageUrl: "${ApiConstant.BASE_URL}${getAllAppointmentData.providerProfileImage ?? ""}",
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
                        getAllAppointmentData.providerName ?? "",
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
                          getAllAppointmentData.serviceName ?? "",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllAppointmentData.serviceProviderFee}",
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getAllAppointmentData.provideravgRating?.toStringAsFixed(1)}",
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
                    getAllAppointmentData.appointmentId ?? "",
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.tabUnselectText,
                    ),
                  ),
                ).paddingOnly(bottom: 3),
              ],
            ).paddingOnly(left: 7, right: 7),
            Container(
              color: AppColors.divider,
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
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
                        getAllAppointmentData.time ?? "",
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
                        getAllAppointmentData.date ?? "",
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
            ).paddingOnly(top: 12),
            const Spacer(),
            getAllAppointmentData.status == 2
                ? Row(
                    children: [
                      Container(
                        height: 9,
                        width: 9,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.appText),
                      ).paddingOnly(right: 5),
                      Text(
                        EnumLocale.txtWorkingProgress.name.tr,
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 13,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 15)
                : Row(
                    children: [
                      Expanded(
                        child: PrimaryAppButton(
                          onTap: () {
                            Get.dialog(
                              barrierColor: AppColors.black.withOpacity(0.8),
                              GetBuilder<AppointmentScreenController>(
                                id: Constant.idCancelAppointment,
                                builder: (logic) {
                                  return ProgressDialog(
                                    inAsyncCall: logic.isLoading2,
                                    child: Dialog(
                                      backgroundColor: AppColors.transparent,
                                      shadowColor: Colors.transparent,
                                      surfaceTintColor: Colors.transparent,
                                      elevation: 0,
                                      child: CancelAppointmentDialog(
                                        appointmentId: getAllAppointmentData.id ?? "",
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          height: 40,
                          borderRadius: 8,
                          color: AppColors.redBox,
                          text: EnumLocale.txtCancelAppointment.name.tr,
                          textStyle: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GetBuilder<AppointmentScreenController>(
                        id: Constant.idGetAllAppointment,
                        builder: (logic) {
                          return Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.schedule,
                                  arguments: [
                                    getAllAppointmentData.providerProfileImage,
                                    getAllAppointmentData.providerName,
                                    getAllAppointmentData.serviceName,
                                    getAllAppointmentData.serviceProviderFee,
                                    getAllAppointmentData.provideravgRating,
                                    getAllAppointmentData.date,
                                    getAllAppointmentData.time,
                                    getAllAppointmentData.providerId,
                                    AppColors.colorList[index % AppColors.colorList.length],
                                    AppColors.textColorList[index % AppColors.textColorList.length],
                                    getAllAppointmentData.id,
                                  ],
                                )?.then(
                                  (value) async {
                                    logic.startPending = 1;
                                    logic.getPending = [];

                                    await logic.getAllAppointmentApiCall(
                                      customerId: Constant.storage.read("customerId"),
                                      status: "1",
                                      start: logic.startPending.toString(),
                                      limit: logic.limitPending.toString(),
                                      startDate: 'All',
                                      endDate: 'All',
                                    );
                                  },
                                );
                              },
                              height: 40,
                              borderRadius: 8,
                              color: AppColors.primaryAppColor1,
                              text: EnumLocale.txtReSchedule.name.tr,
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.white,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(left: 7, right: 7, top: 10)
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}

/// =================== Cancel Appointment =================== ///
class CancelAppointment extends StatelessWidget {
  const CancelAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getCancel.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCancelAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCancelRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getCancel.length,
                        controller: logic.cancelScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getCancel.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: CancelAppointmentListItemView(
                                  index: index,
                                  getAllAppointmentData: logic.getCancel[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class CancelAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllAppointmentData;

  const CancelAppointmentListItemView({
    super.key,
    required this.index,
    required this.getAllAppointmentData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.bookingInformation,
              arguments: [
                getAllAppointmentData.id,
                AppColors.colorList[index % AppColors.colorList.length],
                AppColors.textColorList[index % AppColors.textColorList.length],
              ],
            );
          },
          child: Container(
            height: 235,
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
                          imageUrl: "${ApiConstant.BASE_URL}${getAllAppointmentData.providerProfileImage ?? ""}",
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
                            getAllAppointmentData.providerName ?? "",
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
                              getAllAppointmentData.serviceName ?? "",
                              style: AppFontStyle.fontStyleW600(
                                fontSize: 12,
                                fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                              ),
                            ),
                          ),
                          Text(
                            "$currency ${getAllAppointmentData.serviceProviderFee}",
                            style: AppFontStyle.fontStyleW800(
                              fontSize: 18,
                              fontColor: AppColors.primaryAppColor1,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(AppAsset.icStarFilled, height: 14),
                              Text(
                                "  ${getAllAppointmentData.provideravgRating?.toStringAsFixed(1)}",
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
                        getAllAppointmentData.appointmentId ?? "",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: AppColors.tabUnselectText,
                        ),
                      ),
                    ).paddingOnly(bottom: 3),
                  ],
                ).paddingOnly(left: 7, right: 7),
                Container(
                  color: AppColors.divider,
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
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
                            getAllAppointmentData.time ?? "",
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
                            getAllAppointmentData.date ?? "",
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
                ).paddingOnly(top: 12),
                const Spacer(),
                PrimaryAppButton(
                  height: 40,
                  borderRadius: 8,
                  color: AppColors.cancellationBox,
                  text: EnumLocale.desThisAppointmentCancelled.name.tr,
                  textStyle: AppFontStyle.fontStyleW800(
                    fontSize: 15,
                    fontColor: AppColors.redBox,
                  ),
                ).paddingOnly(left: 7, right: 7, top: 10)
              ],
            ).paddingOnly(top: 7, bottom: 7),
          ).paddingOnly(left: 12, right: 12, bottom: 10),
        );
      },
    );
  }
}

/// =================== Complete Appointment =================== ///
class CompleteAppointment extends StatelessWidget {
  const CompleteAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentScreenController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getComplete.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundCompleteAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onCompleteRefresh(),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getComplete.length,
                        controller: logic.completeScrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getComplete.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: CompleteAppointmentListItemView(
                                  index: index,
                                  getAllAppointmentData: logic.getComplete[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    logic.isLoading1
                        ? CircularProgressIndicator(
                            color: AppColors.primaryAppColor1,
                          ).paddingOnly(bottom: 10)
                        : const SizedBox()
                  ],
                ),
              );
      },
    );
  }
}

class CompleteAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllAppointmentData;

  const CompleteAppointmentListItemView({super.key, required this.index, required this.getAllAppointmentData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.bookingInformation,
          arguments: [
            getAllAppointmentData.id,
            AppColors.colorList[index % AppColors.colorList.length],
            AppColors.textColorList[index % AppColors.textColorList.length],
          ],
        );
      },
      child: Container(
        height: 235,
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
                      imageUrl: "${ApiConstant.BASE_URL}${getAllAppointmentData.providerProfileImage ?? ""}",
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
                        getAllAppointmentData.providerName ?? "",
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
                          getAllAppointmentData.serviceName ?? "",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getAllAppointmentData.serviceProviderFee}",
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getAllAppointmentData.provideravgRating?.toStringAsFixed(1)}",
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
                    getAllAppointmentData.appointmentId ?? "",
                    style: AppFontStyle.fontStyleW600(
                      fontSize: 12,
                      fontColor: AppColors.tabUnselectText,
                    ),
                  ),
                ).paddingOnly(bottom: 3),
              ],
            ).paddingOnly(left: 7, right: 7),
            Container(
              color: AppColors.divider,
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
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
                        getAllAppointmentData.time ?? "",
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
                        getAllAppointmentData.date ?? "",
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
            ).paddingOnly(top: 12),
            const Spacer(),
            getAllAppointmentData.isReviewed == true
                ? PrimaryAppButton(
                    height: 40,
                    borderRadius: 8,
                    color: AppColors.completedBox,
                    text: EnumLocale.desThisAppointmentCompleted.name.tr,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ).paddingOnly(left: 7, right: 7, top: 10)
                : Row(
                    children: [
                      Expanded(
                        child: PrimaryAppButton(
                          height: 40,
                          borderRadius: 8,
                          color: AppColors.completedBox,
                          text: EnumLocale.desThisAppointmentCompleted.name.tr,
                          overflow: TextOverflow.ellipsis,
                          textStyle: AppFontStyle.fontStyleW800(
                            fontSize: 15,
                            fontColor: AppColors.primaryAppColor1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GetBuilder<AppointmentScreenController>(
                        builder: (logic) {
                          return Expanded(
                            child: PrimaryAppButton(
                              onTap: () {
                                Get.dialog(
                                  barrierColor: AppColors.black.withOpacity(0.8),
                                  GetBuilder<AppointmentScreenController>(
                                    id: Constant.idPostReview,
                                    builder: (logic) {
                                      return ProgressDialog(
                                        inAsyncCall: logic.isLoading2,
                                        child: Dialog(
                                          backgroundColor: AppColors.transparent,
                                          shadowColor: Colors.transparent,
                                          surfaceTintColor: Colors.transparent,
                                          elevation: 0,
                                          child: ReviewDialog(
                                            customerId: Constant.storage.read("customerId"),
                                            providerId: getAllAppointmentData.providerId ?? "",
                                            appointmentId: getAllAppointmentData.appointmentId ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              height: 40,
                              borderRadius: 8,
                              color: AppColors.ratingBox,
                              text: "Give Review",
                              textStyle: AppFontStyle.fontStyleW800(
                                fontSize: 15,
                                fontColor: AppColors.rating,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(left: 7, right: 7, top: 10)
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}
