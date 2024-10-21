import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/constants/app_router.dart';
import '../../../data/model/my_order_model/datum.dart';

class OrdersWidget extends StatelessWidget {
  final Datum orders;
  final int index;
  const OrdersWidget({super.key, required this.orders, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          GoRouter.of(context)
              .push(AppRouter.korderdetails, extra: {"id": orders.id});
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                orders.type!.label!,
              ),
              const Spacer(),
              Text(
                orders.status!.label!,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (orders.paid!.price != 0)
                        ? Colors.green[700]
                        : orders.status!.code == 'completed'
                            ? Colors.green[700]
                            : orders.status!.code == 'in_progress'
                                ? Colors.blue
                                : orders.status!.code == 'rejected'
                                    ? Colors.red
                                    : null),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
