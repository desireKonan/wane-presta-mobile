import 'package:cached_network_image/cached_network_image.dart';
import 'package:handy/custom/app_bar/custom_app_bar.dart';
import 'package:handy/custom/no_data_found/no_data_found.dart';
import 'package:handy/routes/app_routes.dart';
import 'package:handy/ui/category_detail_screen/model/get_service_wise_provider_model.dart';
import 'package:handy/utils/api.dart';
import 'package:handy/utils/app_asset.dart';
import 'package:handy/utils/app_color.dart';
import 'package:handy/utils/constant.dart';
import 'package:handy/utils/enums.dart';
import 'package:handy/utils/font_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:handy/ui/category_detail_screen/controller/category_detail_controller.dart';
import 'package:handy/utils/global_variables.dart';
import 'package:handy/utils/shimmers.dart';

/// =================== App Bar =================== ///
class CategoryDetailAppBarView extends StatelessWidget {
  const CategoryDetailAppBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      builder: (logic) {
        return CustomAppBar(
          title: logic.serviceName ?? "",
          showLeadingIcon: true,
        );
      },
    );
  }
}

/// =================== List View =================== ///
class CategoryDetailListView extends StatelessWidget {
  const CategoryDetailListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      id: Constant.idGetServiceWiseProvider,
      builder: (logic) {
        return logic.isLoading
            ? Shimmers.homeTopRatedProviderShimmer()
            : logic.getServiceWiseProviderModel?.data?.isEmpty == true
                ? NoDataFound(
                    image: AppAsset.icNoDataAppointment,
                    imageHeight: 150,
                    text: EnumLocale.noDataFoundProvider.name.tr,
                    padding: const EdgeInsets.only(top: 10),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: logic.getServiceWiseProviderModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return CategoryDetailListItemView(
                        index: index,
                        getServiceWiseProviderData:
                            logic.getServiceWiseProviderModel?.data?[index] ?? GetServiceWiseProviderData(),
                      );
                    },
                  ).paddingOnly(top: 10);
      },
    );
  }
}

class CategoryDetailListItemView extends StatelessWidget {
  final int index;
  final GetServiceWiseProviderData getServiceWiseProviderData;

  const CategoryDetailListItemView({super.key, required this.index, required this.getServiceWiseProviderData});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      builder: (logic) {
        final int serviceIndex =
            getServiceWiseProviderData.services?.isNotEmpty == true ? getServiceWiseProviderData.services!.length - 1 : -1;

        return GestureDetector(
          onTap: () {
            Get.toNamed(
              AppRoutes.providerDetail,
              arguments: [
                AppColors.colorList[index % AppColors.colorList.length],
                AppColors.textColorList[index % AppColors.textColorList.length],
                getServiceWiseProviderData.id,
                logic.serviceId,
                getServiceWiseProviderData.services?[serviceIndex].price.toString(),
                logic.serviceName,
              ],
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
                      imageUrl: "${ApiConstant.BASE_URL}${getServiceWiseProviderData.profileImage ?? ""}",
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
                        getServiceWiseProviderData.name ?? "",
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
                          logic.serviceName ?? "",
                          style: AppFontStyle.fontStyleW600(
                            fontSize: 12,
                            fontColor: AppColors.textColorList[index % AppColors.textColorList.length],
                          ),
                        ),
                      ),
                      Text(
                        "$currency ${getServiceWiseProviderData.services?[serviceIndex].price ?? ""}",
                        style: AppFontStyle.fontStyleW800(
                          fontSize: 18,
                          fontColor: AppColors.primaryAppColor1,
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(AppAsset.icStarFilled, height: 14),
                          Text(
                            "  ${getServiceWiseProviderData.avgRating?.toStringAsFixed(1)}",
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
                GetBuilder<CategoryDetailController>(
                  id: Constant.idCategoryProviderSaved,
                  builder: (logic) {
                    return GestureDetector(
                      onTap: () {
                        logic.onProviderSaved(
                          customerId: Constant.storage.read("customerId"),
                          providerId: getServiceWiseProviderData.id ?? "",
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
