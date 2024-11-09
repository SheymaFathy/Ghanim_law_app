import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/responsive_text/app_style.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/service_icon_build_item_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../../core/constants/app_router.dart';
import '../../../data/model/home_model/home_model.dart';

class CustomServiceContainer extends StatelessWidget {
  final Services servicesModel;

  const CustomServiceContainer({
    super.key,
    required this.servicesModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          GoRouter.of(context).push(AppRouter.kOrderForm, extra: {
            "type": servicesModel.key.toString(),
            "price": servicesModel.price!.price.toString()
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ServiceIconBuildItem(
                serviceName: servicesModel.key!,
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    servicesModel.name!,
                    style: TextStyle(
                        fontSize: getResponsiveFontSize(context, fontSize: 16)),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                servicesModel.price!.formatted.toString()!,
                style: TextStyle(
                    fontSize: getResponsiveFontSize(context, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
