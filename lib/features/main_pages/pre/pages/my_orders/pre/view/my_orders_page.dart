import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/widgets/my_order_widget.dart';
import '../../../../../../../core/required_login_screen.dart';
import '../../../../../../../core/widget/app_bar.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Orders> myorders = [
      Orders(
          myService: 'legal_advice',
          orderState: 'Under revision'),
      Orders(
          myService: 'contract_review',
          orderState: 'Under revision'),
      Orders(
          myService: 'book_preparation',
          orderState: 'Download'),
    ];
    return Scaffold(
        appBar: myAppBar(context, "my-order".tr(context)),
        body: checkUserMethod()
            ? Center(
                child: ListView.builder(
                  itemCount: myorders.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: OrdersWidget(orders: myorders[index],),
                    );
                  },
                ),
              )
            : const RequiredLoginScreen());
  }
}
