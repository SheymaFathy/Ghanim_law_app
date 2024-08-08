import 'package:flutter/material.dart';

import '../../view_model/cubit/my_order_details_cubit.dart';
import 'my_order_details_transaction_details_widget.dart';
import 'my_order_preson_details_widget.dart';

class MyOrderDetailsViewBody extends StatelessWidget {
  const MyOrderDetailsViewBody({super.key, required this.state});
  final MyOrderDetailsState state;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyOrderPersonDetailsWidget(state: state),
            MyOrdersDetailsTransactionDetailsWidget(state: state)
          ],
        ),
      ),
    );
  }
}
