import 'package:handy/custom/app_button/primary_app_button.dart';
import 'package:handy/ui/search_screen/controller/search_screen_controller.dart';
import 'package:handy/ui/search_screen/widget/search_screen_widget.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// =================== Bottom Sheet =================== ///
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        color: AppColors.white,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterBottomTitleView(),
          FilterBottomCategoryListView(),
          FilterBottomGenderListView(),
          FilterBottomRatingGridView(),
          FilterBottomLocationListView(),
          SizedBox(height: 40),
          FilterBottomButtonView(),
        ],
      ),
    );
  }
}

/// Bottom Sheet Items......

/// =================== Bottom Sheet Title =================== ///
class FilterBottomTitleView extends StatelessWidget {
  const FilterBottomTitleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 52,
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
                EnumLocale.txtApplyFilters.name.tr,
                style: AppFontStyle.fontStyleW800(
                  fontSize: 19,
                  fontColor: AppColors.white,
                ),
              ).paddingOnly(left: 20),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  AppAsset.icClose,
                  height: Get.height * 0.07,
                  width: Get.width * 0.07,
                ).paddingOnly(right: 15),
              )
            ],
          ),
        ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.bottomSheetDivider,
              width: 0.4,
            ),
          ),
        ),
      ],
    );
  }
}

/// =================== Bottom Sheet Select Category =================== ///
class FilterBottomCategoryListView extends StatelessWidget {
  const FilterBottomCategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtSelectCategories.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 10, bottom: 13),
        SizedBox(
          height: Get.height * 0.05,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idSelectCategories,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: logic.getAllService.length,
                itemBuilder: (context, index) {
                  return FilterBottomCategoryListItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomCategoryListItemView extends StatelessWidget {
  final int index;

  const FilterBottomCategoryListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectCategories,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onServiceSelect(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: logic.serviceSelect == index ? AppColors.appButton : AppColors.divider,
            ),
            child: Center(
              child: Text(
                logic.getAllService[index],
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: logic.serviceSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Select Gender =================== ///
class FilterBottomGenderListView extends StatelessWidget {
  const FilterBottomGenderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtGender.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 10, bottom: 13),
        SizedBox(
          height: Get.height * 0.05,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idGenderSelect,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: genderList.length,
                itemBuilder: (context, index) {
                  return FilterBottomGenderListItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomGenderListItemView extends StatelessWidget {
  final int index;

  const FilterBottomGenderListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idGenderSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onGenderSelect(index);
          },
          child: Container(
            width: Get.width * 0.262,
            margin: const EdgeInsets.only(right: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: logic.genderSelect == index ? AppColors.appButton : AppColors.divider,
            ),
            child: Center(
              child: Text(
                genderList[index],
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: logic.genderSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Select Rating =================== ///
class FilterBottomRatingGridView extends StatelessWidget {
  const FilterBottomRatingGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtRatings.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 10),
        SizedBox(
          height: Get.height * 0.12,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idRatingSelect,
            builder: (logic) {
              return GridView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: logic.ratings.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 2.1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return FilterBottomRatingGridItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12),
      ],
    );
  }
}

class FilterBottomRatingGridItemView extends StatelessWidget {
  final int index;

  const FilterBottomRatingGridItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idRatingSelect,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onRatingSelect(index);
          },
          child: Container(
            width: Get.width * 0.262,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: logic.ratingSelect == index ? AppColors.appButton : AppColors.divider,
            ),
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.icStarFilled,
                  height: 15,
                  width: 15,
                  color: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ).paddingOnly(right: 8),
                Text(
                  logic.ratings[index],
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.fontStyleW700(
                    fontSize: 15,
                    fontColor: logic.ratingSelect == index ? AppColors.white : AppColors.tabUnselectText,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Location =================== ///
class FilterBottomLocationListView extends StatelessWidget {
  const FilterBottomLocationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          EnumLocale.txtLocation.name.tr,
          style: AppFontStyle.fontStyleW700(
            fontSize: 15,
            fontColor: AppColors.categoryText,
          ),
        ).paddingOnly(left: 15, top: 15, bottom: 15),
        SizedBox(
          height: Get.height * 0.06,
          child: GetBuilder<SearchScreenController>(
            id: Constant.idSelectLocation,
            builder: (logic) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: logic.locations.length,
                itemBuilder: (context, index) {
                  return FilterBottomLocationListItemView(index: index);
                },
              );
            },
          ),
        ).paddingOnly(left: 12, right: 12)
      ],
    );
  }
}

class FilterBottomLocationListItemView extends StatelessWidget {
  final int index;

  const FilterBottomLocationListItemView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idSelectLocation,
      builder: (logic) {
        return GestureDetector(
          onTap: () {
            logic.onLocationSelect(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            margin: const EdgeInsets.only(right: 13, bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: logic.locationSelect == index ? AppColors.appButton : AppColors.divider,
            ),
            child: Center(
              child: Text(
                logic.locations[index],
                style: AppFontStyle.fontStyleW700(
                  fontSize: 15,
                  fontColor: logic.locationSelect == index ? AppColors.white : AppColors.tabUnselectText,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// =================== Bottom Sheet Button =================== ///
class FilterBottomButtonView extends StatelessWidget {
  const FilterBottomButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchScreenController>(
      id: Constant.idApplyFilter,
      builder: (logic) {
        return Center(
          child: PrimaryAppButton(
            onTap: () {
              logic.genderSelect == -1 && logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
                  ? logic.onBackToFilter()
                  : logic.onApplyFilter();
            },
            text: EnumLocale.txtApplyNow.name.tr,
            color: logic.genderSelect == -1 && logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
                ? AppColors.divider
                : AppColors.appButton,
            textStyle: AppFontStyle.fontStyleW800(
              fontSize: 17,
              fontColor:
                  logic.genderSelect == -1 && logic.serviceSelect == -1 && logic.ratingSelect == -1 && logic.locationSelect == -1
                      ? AppColors.tabUnselectText
                      : AppColors.primaryAppColor1,
            ),
          ).paddingOnly(top: 10, left: 12, right: 12),
        );
      },
    );
  }
}
