import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/constants/app_router.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/model/home_model/prices.dart';
import 'package:go_router/go_router.dart';

import 'service_icon_build_item_widget.dart';

class ServiceBuildItemWidget extends StatelessWidget {
  final PriceModel priceModel;

  const ServiceBuildItemWidget({super.key, required this.priceModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: AppColors.backgroundColor,
      child: InkWell(
        onTap: () {GoRouter.of(context).push(AppRouter.kOrderForm);},
        child: ListTile(
          leading: ServiceIconBuildItem(
            serviceName: priceModel.serviceName,
          ),
          title: Text(
            priceModel.serviceName.tr(context),
            style: Styles.textStyle14.copyWith(color: AppColors.primeryColor),
          ),
          trailing: Text(
            priceModel.formattedPrice,
            style: Styles.textStyle14.copyWith(color: AppColors.green),
          ),
        ),
      ),
    );
  }
}
