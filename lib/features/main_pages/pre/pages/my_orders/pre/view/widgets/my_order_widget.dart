import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';

class Orders {
  final String myService;
  final String orderState;

  Orders({
    required this.myService,
    required this.orderState,
  });
}

class OrdersWidget extends StatelessWidget {
  final Orders orders;

  const OrdersWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      color: AppColors.backgroundColor,
      child: InkWell(
        onTap: () {
          //    Go to order form or service details
        },
        child: ListTile(
          title: Text(
            orders.myService,
            style: Styles.textStyle14.copyWith(color: AppColors.primeryColor),
          ),
          trailing: Text(
            orders.orderState,
            style: Styles.textStyle14.copyWith(color: AppColors.green),
          ),
        ),
      ),
    );
  }
}
