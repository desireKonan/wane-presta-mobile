import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/bottom_sheet/select_service_bottom_sheet.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/saved_provider_screen/controller/saved_provider_controller.dart';
import 'package:handy/ui/saved_provider_screen/model/get_all_save_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:handy/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class SavedProviderAppBarView extends StatelessWidget {
  const SavedProviderAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedProviderController>(
      builder: (logic) {
        return CustomAppBar(
          title: EnumLocale.txtSavedService.name.tr,
          showLeadingIcon: logic.isBack == false ? true : false,
        );
      },
    );
  }
}

/// =================== List View =================== ///
class SavedProviderListView extends StatelessWidget {
  const SavedProviderListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedProviderController>(
      id: Constant.idGetAllSaveProvider,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTopRatedProviderShimmer()
            : logic.getAllSaveProviderModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icPlaceholderNoData,
                    imageHeight: 200,
                    text: EnumLocale.noDataFoundSavedService.name.tr,
                  ).paddingOnly(bottom: Get.height * 0.1)
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getAllSaveProviderModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: logic.getAllSaveProviderModel?.data?.length ?? 0,
                        child: SlideAnimation(
                          child: FadeInAnimation(
                            child: SavedProviderListItemView(
                              index: index,
                              favoriteProviderData: logic.getAllSaveProviderModel?.data?[index] ?? FavoriteProviderData(),
                            ),
                          ),
                        ),
                      );
                    },
                  ).paddingOnly(top: 10);
      },
    );
  }
}

class SavedProviderListItemView extends StatelessWidget {
  final int index;
  final FavoriteProviderData favoriteProviderData;

  const SavedProviderListItemView({super.key, required this.index, required this.favoriteProviderData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SavedProviderController>(
        id: Constant.idGetAllSaveProvider,
        builder: (logic) {
          final int serviceIndex =
              favoriteProviderData.services?.isNotEmpty == true ? favoriteProviderData.services!.length - 1 : -1;

          return GestureDetector(
            onTap: () {
              favoriteProviderData.services?.length == 1
                  ? Get.toNamed(
                      AppRoutes.providerDetail,
                      arguments: [
                        AppColors.colorList[index % AppColors.colorList.length],
                        AppColors.textColorList[index % AppColors.textColorList.length],
                        favoriteProviderData.id,
                        favoriteProviderData.services?[serviceIndex].serviceId,
                        favoriteProviderData.services?[serviceIndex].price.toString(),
                        favoriteProviderData.services?[serviceIndex].name,
                      ],
                    )
                  : showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) {
                        return SelectServiceBottomSheet(
                          services: favoriteProviderData.services ?? [],
                          index: index,
                          serviceIndex: serviceIndex,
                          providerId: favoriteProviderData.id ?? "",
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
                        imageUrl: "${ApiConstant.BASE_URL}${favoriteProviderData.profileImage ?? ""}",
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
                          favoriteProviderData.name ?? "",
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
                            favoriteProviderData.services?.map((service) => service.name).join(", ") ?? "",
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
                              "  ${favoriteProviderData.avgRating?.toStringAsFixed(1) ?? ""}",
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
                  GetBuilder<SavedProviderController>(
                    id: Constant.idServiceSaved,
                    builder: (logic) {
                      return GestureDetector(
                        onTap: () {
                          logic.onProviderSaved(
                            customerId: Constant.storage.read("customerId"),
                            providerId: favoriteProviderData.id ?? "",
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
        });
  }
}