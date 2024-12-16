import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/bottom_sheet/payment_bottom_sheet.dart';
import 'package:handy/custom/dialog/payment_confirm_dialog.dart';
import 'package:handy/custom/progress_indicator/progress_dialog.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/confirm_booking_screen/controller/confirm_booking_controller.dart';
import 'package:handy/ui/history_screen/controller/history_screen_controller.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:handy/utils/font_style.dart';
import 'package:get/get.dart';
import 'package:handy/utils/global_variables.dart';

/// =================== App Bar =================== ///
class ConfirmBookingAppBarView extends StatelessWidget {
  const ConfirmBookingAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtConfirmBooking.name.tr,
      showLeadingIcon: true,
    );
  }
}

/// =================== Bottom View =================== ///
class ConfirmBookingBottomView extends StatelessWidget {
  const ConfirmBookingBottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.11,
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
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: GetBuilder<ConfirmBookingController>(
        builder: (logic) {
          return Column(
            children: [
              Row(
                children: [
                  PrimaryAppButton(
                    onTap: () {
                      final walletAmountString = Constant.storage.read("walletAmount");
                      final double walletAmount = double.tryParse(walletAmountString ?? "0") ?? 0;
                      final num finalAmountBooking = logic.finalAmountBooking ?? 0;

                      if (walletAmount < finalAmountBooking) {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return const PaymentBottomSheet(isRecharge: false);
                          },
                        );
                      } else {
                        Get.dialog(
                          barrierColor: AppColors.black.withOpacity(0.8),
                          GetBuilder<ConfirmBookingController>(
                            id: Constant.idCreateBookingByCustomer,
                            builder: (logic) {
                              return ProgressDialog(
                                inAsyncCall: logic.isLoading,
                                child: Dialog(
                                  backgroundColor: AppColors.transparent,
                                  shadowColor: Colors.transparent,
                                  surfaceTintColor: Colors.transparent,
                                  elevation: 0,
                                  child: const PaymentConfirmDialog(),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                    height: Get.height * 0.062,
                    width: Get.width * 0.93,
                    text: EnumLocale.txtPayNow.name.tr,
                    textStyle: AppFontStyle.fontStyleW800(
                      fontSize: 17,
                      fontColor: AppColors.primaryAppColor1,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "* Current Available Balance : ",
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.fontStyleW400(
                      fontSize: 11,
                      fontColor: AppColors.degreeText,
                    ),
                  ).paddingOnly(right: 5),
                  GetBuilder<HistoryScreenController>(
                    id: Constant.idGetWalletHistory,
                    builder: (logic) {
                      return Text(
                        "$currency ${Constant.storage.read("walletAmount")}",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: AppColors.title,
                        ),
                      );
                    },
                  ),
                ],
              ).paddingOnly(top: 5, right: 7),
            ],
          );
        },
      ),
    );
  }
}

/// =================== Information =================== ///
class ConfirmBookingInfoView extends StatelessWidget {
  const ConfirmBookingInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: GetBuilder<ConfirmBookingController>(
        builder: (logic) {
          return Row(
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
                    imageUrl: "${ApiConstant.BASE_URL}${logic.profileImage}",
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
                      logic.name ?? "",
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
                        logic.services ?? "",
                        style: AppFontStyle.fontStyleW600(
                          fontSize: 12,
                          fontColor: logic.textColor ?? AppColors.primaryAppColor1,
                        ),
                      ),
                    ),
                    Text(
                      "$currency ${logic.price}",
                      style: AppFontStyle.fontStyleW800(
                        fontSize: 18,
                        fontColor: AppColors.primaryAppColor1,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.icStarFilled, height: 14),
                        Text(
                          "  ${logic.avgRating}",
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
          ).paddingAll(12);
        },
      ),
    );
  }
}

/// =================== Appointment Schedule =================== ///
class ConfirmBookingAppointmentView extends StatelessWidget {
  const ConfirmBookingAppointmentView({super.key});

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
      child: Column(
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
          GetBuilder<ConfirmBookingController>(
            builder: (logic) {
              return Row(
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
                        logic.formattedDate ?? "",
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
                        logic.selectedSlotsList ?? "",
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
                ],
              ).paddingOnly(top: 12.5, bottom: 12.5, right: 15, left: 15);
            },
          ),
        ],
      ),
    ).paddingOnly(left: 15, right: 15, bottom: 12);
  }
}

/// =================== Payment Amount =================== ///
class ConfirmBookingPaymentView extends StatelessWidget {
  const ConfirmBookingPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmBookingController>(
      id: Constant.idAddCouponAmount,
      builder: (logic) {
        List amount = [
          EnumLocale.txtConsultingFees.name.tr,
          "${EnumLocale.txtTaxCharges.name.tr} ${(logic.taxRate)}%",
          EnumLocale.txtDiscount.name.tr,
        ];

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
                            "$currency ${(logic.priceList[index]).toString()}",
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
                      "$currency ${logic.finalAmountBooking}",
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

/// =================== Apply Coupon =================== ///
class ConfirmBookingCouponView extends StatelessWidget {
  const ConfirmBookingCouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ConfirmBookingController>(
      builder: (logic) {
        return InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.applyCoupon,
              arguments: [
                logic.finalAmount,
              ],
            )?.then((value) {
              logic.update([Constant.idAddCouponAmount]);
            });
          },
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          child: Container(
            height: 47,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.paymentDes1,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAsset.icCoupon,
                  height: 25,
                  width: 25,
                ).paddingOnly(left: 12, right: 15),
                Text(
                  EnumLocale.txtApplyNow.name.tr,
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 15,
                    fontColor: AppColors.primaryAppColor1,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  AppAsset.icArrowLeft,
                  height: 20,
                  color: AppColors.primaryAppColor1,
                ).paddingOnly(right: 10)
              ],
            ),
          ).paddingAll(15),
        );
      },
    );
  }
}
