import 'package:flutter/material.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../data/model/invoice_model.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';
import 'payment_method_build_item.dart';

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList(this.paymentMyFatorahModel, {super.key});
  final PaymentMyFatorahModel paymentMyFatorahModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: getIt<PaymentMyFatorahCubit>().state.paymentMethods.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final int id = getIt<PaymentMyFatorahCubit>()
              .state
              .paymentMethods[index]
              .paymentMethodId!;
          if (id != 7 &&
              id != 11 &&
              id != 32 &&
              id != 25 &&
              id != 9 &&
              id != 20) {
            return PaymentMethodsBuildItem(
                index: index, paymentMyFatorahModel: paymentMyFatorahModel);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
