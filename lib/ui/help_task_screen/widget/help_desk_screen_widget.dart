import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/custom/text_field/custom_text_field.dart';
import 'package:handy/custom/title/custom_title.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/help_task_screen/controller/help_desk_screen_controller.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';

class HelpDeskAppBarView extends StatelessWidget {
  const HelpDeskAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: EnumLocale.txtHelpFAQ.name.tr,
      showLeadingIcon: true,
      action: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.helpDeskHistory);
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: Image.asset(AppAsset.icHistory).paddingAll(9),
          ).paddingOnly(right: 12),
        )
      ],
    );
  }
}

class HelpDeskAddDateView extends StatelessWidget {
  const HelpDeskAddDateView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      builder: (logic) {
        return Form(
          key: logic.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: EnumLocale.txtSelectDesk.name.tr,
                method: SizedBox(
                  height: Get.height * 0.04,
                  child: ListView.builder(
                    itemCount: logic.type.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HelpDeskTypeView(index: index);
                    },
                  ),
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtComplainSuggestion.name.tr,
                method: CustomTextField(
                  controller: logic.suggestionController,
                  filled: true,
                  maxLines: 8,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  textInputAction: TextInputAction.newline,
                  hintText: EnumLocale.txtTypeSomething.name.tr,
                  hintTextSize: 14,
                  hintTextColor: AppColors.appButton,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desEnterComplainSuggestion.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20),
              CustomTitle(
                title: EnumLocale.txtContact.name.tr,
                method: CustomTextField(
                  controller: logic.contactController,
                  filled: true,
                  fillColor: AppColors.divider,
                  cursorColor: AppColors.appButton,
                  fontColor: AppColors.appButton,
                  textInputAction: TextInputAction.done,
                  hintText: EnumLocale.desEnterNumberEmail.name.tr,
                  hintTextSize: 14,
                  hintTextColor: AppColors.appButton,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return EnumLocale.desPleaseEnterContact.name.tr;
                    }
                    return null;
                  },
                ),
              ).paddingOnly(bottom: 20)
            ],
          ).paddingOnly(top: 15, left: 15, right: 15),
        );
      },
    );
  }
}

class HelpDeskTypeView extends StatelessWidget {
  final int index;

  const HelpDeskTypeView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idSelectType,
      builder: (logic) {
        return InkWell(
          onTap: () {
            logic.onSelectType(index);
          },
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          child: Row(
            children: [
              Container(
                height: Get.height * 0.035,
                width: Get.height * 0.035,
                decoration: BoxDecoration(
                  color: AppColors.categoryCircle,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: logic.selectedType == index ? AppColors.appButton : AppColors.transparent,
                    width: 1.2,
                  ),
                ),
                child: logic.selectedType == index ? Image.asset(AppAsset.icCheck).paddingAll(7) : const SizedBox(),
              ),
              Text(
                logic.type[index],
                style: AppFontStyle.fontStyleW600(
                  fontSize: 15,
                  fontColor: AppColors.appButton,
                ),
              ).paddingOnly(left: 8)
            ],
          ).paddingOnly(right: 30, left: 5),
        );
      },
    );
  }
}

/// =================== Image View=================== ///
class HelpDeskAddImageview extends StatelessWidget {
  const HelpDeskAddImageview({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idComplainImage,
      builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTitle(
              title: EnumLocale.desAttachYourImageScreenshot.name.tr,
              method: GestureDetector(
                onTap: () {
                  logic.onPickImage();
                },
                child: DottedBorder(
                  color: AppColors.tabUnselectText,
                  dashPattern: const [3.5, 3.5],
                  radius: const Radius.circular(38),
                  strokeWidth: 1,
                  borderType: BorderType.RRect,
                  child: Container(
                    height: 35,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppAsset.icBrowse, height: 20),
                        VerticalDivider(
                          thickness: 1.5,
                          color: AppColors.verticalBorder,
                          endIndent: 10,
                          indent: 10,
                        ).paddingOnly(left: 5, right: 5),
                        Text(
                          EnumLocale.txtBrowse.name.tr,
                          style: AppFontStyle.fontStyleW700(
                            fontSize: 16,
                            fontColor: AppColors.appButton,
                          ),
                        )
                      ],
                    ).paddingOnly(left: 10),
                  ),
                ),
              ),
            ).paddingOnly(left: 15, right: 15),
            logic.selectImageFile != null ? const HelpDeskShowImageView() : const SizedBox(),
          ],
        );
      },
    );
  }
}

class HelpDeskShowImageView extends StatelessWidget {
  const HelpDeskShowImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      id: Constant.idComplainImage,
      builder: (logic) {
        return Container(
          height: Get.height * 0.18,
          width: Get.width * 0.36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: FileImage(
                File(logic.selectImageFile?.path ?? ""),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ).paddingOnly(top: 15, left: 15);
      },
    );
  }
}

/// =================== Help Desk Button =================== ///
class HelpDeskButtonView extends StatelessWidget {
  const HelpDeskButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HelpDeskScreenController>(
      builder: (logic) {
        return PrimaryAppButton(
          onTap: () {
            logic.onSubmitClick(context);
          },
          height: 52,
          width: Get.width,
          text: EnumLocale.txtSubmit.name.tr,
          textStyle: AppFontStyle.fontStyleW800(
            fontSize: 17,
            fontColor: AppColors.primaryAppColor1,
          ),
        ).paddingOnly(left: 12, right: 12, bottom: 10);
      },
    );
  }
}
