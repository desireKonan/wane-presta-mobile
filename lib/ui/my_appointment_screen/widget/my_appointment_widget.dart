import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/dialog/select_date_dialog.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/appointment_screen/model/get_all_appointment_model.dart';
import 'package:handy/ui/my_appointment_screen/controller/my_appointment_controller.dart';
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
class MyAppointmentAppBarView extends StatelessWidget {
  const MyAppointmentAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtBookedService.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Title =================== ///
class MyAppointmentTitleView extends StatelessWidget {
  const MyAppointmentTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          EnumLocale.txtAppointmentDetails.name.tr,
          style: AppFontStyle.fontStyleW800(
            fontSize: 16,
            fontColor: AppColors.appButton,
          ),
        ),
        GetBuilder<MyAppointmentController>(
          id: Constant.idSelectDateRange,
          builder: (logic) {
            return GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    backgroundColor: AppColors.transparent,
                    surfaceTintColor: AppColors.transparent,
                    shadowColor: AppColors.transparent,
                    elevation: 0,
                    child: const SelectDateDialog(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      logic.startDateFormatted == null ? "ALL" : "${logic.startDateFormatted} TO\n${logic.endDateFormatted}",
                      style: AppFontStyle.fontStyleW700(
                        fontSize: 12,
                        fontColor: AppColors.tabUnselectText,
                      ),
                    ).paddingOnly(right: 5),
                    Image.asset(
                      AppAsset.icArrowDown,
                      height: 22,
                      color: AppColors.tabUnselectText,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    ).paddingAll(15);
  }
}

/// =================== List View =================== ///
class MyAppointmentListView extends StatelessWidget {
  const MyAppointmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentController>(
      id: Constant.idGetAllAppointment,
      builder: (logic) {
        return logic.getMyAppointment.isEmpty
            ? logic.isLoading
                ? Shimmers.cancelAppointmentShimmer()
                : NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundAppointment.name.tr,
                    padding: const EdgeInsets.only(top: 7),
                  )
            : RefreshIndicator(
                onRefresh: () => logic.onRefresh(),
                color: AppColors.primaryAppColor1,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: logic.getMyAppointment.length,
                        controller: logic.scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 800),
                            columnCount: logic.getMyAppointment.length,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: MyAppointmentListItemView(
                                  index: index,
                                  getAllAppointmentData: logic.getMyAppointment[index],
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

class MyAppointmentListItemView extends StatelessWidget {
  final int index;
  final GetAllAppointmentData getAllAppointmentData;

  const MyAppointmentListItemView({super.key, required this.index, required this.getAllAppointmentData});

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
            PrimaryAppButton(
              height: 40,
              borderRadius: 8,
              color: getAllAppointmentData.status == 1
                  ? AppColors.divider
                  : getAllAppointmentData.status == 3
                      ? AppColors.completedBox
                      : AppColors.cancellationBox,
              text: getAllAppointmentData.status == 1
                  ? EnumLocale.desThisAppointmentPending.name.tr
                  : getAllAppointmentData.status == 3
                      ? EnumLocale.desThisAppointmentCompleted.name.tr
                      : EnumLocale.desThisAppointmentCancelled.name.tr,
              textStyle: AppFontStyle.fontStyleW800(
                fontSize: 15,
                fontColor: getAllAppointmentData.status == 1
                    ? AppColors.tabUnselectText
                    : getAllAppointmentData.status == 3
                        ? AppColors.primaryAppColor1
                        : AppColors.redBox,
              ),
            ).paddingOnly(left: 7, right: 7, top: 10)
          ],
        ).paddingOnly(top: 7, bottom: 7),
      ).paddingOnly(left: 12, right: 12, bottom: 10),
    );
  }
}
