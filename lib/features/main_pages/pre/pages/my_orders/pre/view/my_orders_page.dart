import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/widgets/my_order_widget.dart';
import '../../../../../../../core/widget/app_bar.dart';


class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Orders> myorders = [
      Orders(myService: 'legal-consultations'.tr(context),  orderState: 'Under revision' ),
      Orders(myService: 'preparing-and-reviewing-contract'.tr(context), orderState: 'Under revision' ),
      Orders(myService: 'legal-consultations'.tr(context),  orderState: 'Download' ),
    ];
    return Scaffold(
      appBar: myAppBar(context, "my-order".tr(context)),
      body: Center(
        child: Expanded(
          child: ListView.builder(
            itemCount: myorders.length,
            itemBuilder: (context, index) {
              return OrdersWidget(orders: myorders[index]);
            },
          ),
        ),
      ),
    );
  }
}
