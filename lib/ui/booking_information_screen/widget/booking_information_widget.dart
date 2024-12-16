import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/booking_information_screen/controller/booking_information_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== App Bar =================== ///
class BookingInfoAppBarView extends StatelessWidget {
  const BookingInfoAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtBookingInformation.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Doctor Information =================== ///
class BookingInfoDoctorDataView extends StatelessWidget {
  const BookingInfoDoctorDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.providerDetail,
              arguments: [
                logic.color,
                logic.textColor,
                logic.getAppointmentInfoModel?.data?.providerId,
                logic.getAppointmentInfoModel?.data?.serviceId,
                logic.getAppointmentInfoModel?.data?.serviceProviderFee.toString(),
                logic.getAppointmentInfoModel?.data?.serviceName,
              ],
            );
          },
          overlayColor: const WidgetStatePropertyAll(WidgetStateColor.transparent),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  offset: const Offset(
                    0.8,
                    0.8,
                  ),
                  blurRadius: 5.0,
                ),
              ],
              color: AppColors.white,
            ),
            margin: const EdgeInsets.only(bottom: 12),
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
                      imageUrl: "${ApiConstant.BASE_URL}${logic.getAppointmentInfoModel?.data?.providerProfileImage ?? ""}",
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
                        logic.getAppointmentInfoModel?.data?.providerName ?? "",
                        style: AppFontStyle.fontStyleW900(
                          fontSize: 16,
                          fontColor: AppColors.appButton,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: logic.color,
                        ),
                        child: Text(
                          logic.getAppointmentInfoModel?.data?.serviceName ?? "",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: logic.textColor ?? AppColors.primaryAppColor1,
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${logic.getAppointmentInfoModel?.data?.serviceProviderFee ?? ""}",
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${logic.getAppointmentInfoModel?.data?.provideravgRating?.toStringAsFixed(1) ?? ""}",
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
              ],
            ).paddingAll(12),
          ),
        );
      },
    );
  }
}

/// =================== Appointment Information =================== ///
class BookingInfoAppointmentView extends StatelessWidget {
  const BookingInfoAppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryAppColor1,
          width: 0.7,
        ),
      ),
      child: GetBuilder<BookingInformationController>(
        id: Constant.idGetAppointmentInfo,
        builder: (logic) {
          return Column(
            children: [
              Container(
                height: 42,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryAppColor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    EnumLocale.txtServiceBookingSchedule.name.tr,
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              Divider(height: 3, color: AppColors.white),
              Row(
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
                        logic.getAppointmentInfoModel?.data?.time ?? "",
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
                        logic.getAppointmentInfoModel?.data?.date ?? "",
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
              ).paddingOnly(top: 12.5, bottom: 12.5, right: 15, left: 15)
            ],
          );
        },
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== Payment Information =================== ///
class BookingInfoPaymentView extends StatelessWidget {
  const BookingInfoPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    List amount = [
      EnumLocale.txtConsultingFees.name.tr,
      EnumLocale.txtTaxCharges.name.tr,
      EnumLocale.txtDiscount.name.tr,
    ];

    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return Container(
          height: logic.priceList.length == 3 ? 230 : 185,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 0.7,
              color: AppColors.primaryAppColor1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 45,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryAppColor1,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    EnumLocale.txtPaymentDescription.name.tr,
                    style: AppFontStyle.fontStyleW800(
                      fontSize: 15,
                      fontColor: AppColors.white,
                    ),
                  ).paddingOnly(left: 15),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: logic.priceList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: index.isOdd ? AppColors.paymentDes1 : AppColors.paymentDes,
                      ),
                      margin: const EdgeInsets.only(bottom: 3),
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            amount[index],
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.fontStyleW600(
                              fontSize: 14,
                              fontColor: AppColors.categoryText,
                            ),
                          ),
                          Text(
                            "$currency ${logic.priceList[index]}",
                            style: AppFontStyle.fontStyleW900(
                              fontSize: 15,
                              fontColor: AppColors.appButton,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ).paddingOnly(top: 3, bottom: 3),
              ),
              Container(
                height: 43,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                  color: AppColors.primaryAppColor1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      EnumLocale.txtTotalPayableAmount.name.tr,
                      style: AppFontStyle.fontStyleW600(
                        fontSize: 14,
                        fontColor: AppColors.white,
                      ),
                    ),
                    Text(
                      "$currency ${logic.finalAmount}",
                      style: AppFontStyle.fontStyleW900(
                        fontSize: 15,
                        fontColor: AppColors.white,
                      ),
                    )
                  ],
                ).paddingOnly(left: 15, right: 15),
              ),
            ],
          ),
        ).paddingOnly(left: 15, right: 15);
      },
    );
  }
}

/// =================== Bottom View =================== ///
class BookingInformationBottomView extends StatelessWidget {
  const BookingInformationBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingInformationController>(
      id: Constant.idGetAppointmentInfo,
      builder: (logic) {
        return PrimaryAppButton(
          color: logic.getAppointmentInfoModel?.data?.status == 1
              ? AppColors.divider
              : logic.getAppointmentInfoModel?.data?.status == 3
                  ? AppColors.completedBox
                  : AppColors.cancellationBox,
          text: logic.getAppointmentInfoModel?.data?.status == 1
              ? EnumLocale.desThisAppointmentPending.name.tr
              : logic.getAppointmentInfoModel?.data?.status == 3
                  ? EnumLocale.desThisAppointmentCompleted.name.tr
                  : EnumLocale.desThisAppointmentCancelled.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 15,
            fontColor: logic.getAppointmentInfoModel?.data?.status == 1
                ? AppColors.tabUnselectText
                : logic.getAppointmentInfoModel?.data?.status == 3
                    ? AppColors.primaryAppColor1
                    : AppColors.redBox,
          ),
        ).paddingAll(15);
      },
    );
  }
}
