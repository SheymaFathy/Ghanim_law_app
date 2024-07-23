import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/service_icon_build_item_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../../core/constants/app_router.dart';
import '../../../data/model/home_model/prices.dart';

class CustomServiceContainer extends StatelessWidget {
  final PriceModel priceModel;

  const CustomServiceContainer({
    super.key,
    required this.priceModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kOrderForm);
      },
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[200]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ServiceIconBuildItem(
              serviceName: priceModel.serviceName,
            ),
            Text(
              priceModel.serviceName.tr(context),
            ),
            Text(priceModel.formattedPrice),
          ],
        ),
      ),
    );
  }
}
