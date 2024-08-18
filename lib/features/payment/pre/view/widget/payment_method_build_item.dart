import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../../../data/model/invoice_model.dart';
import '../../view_model/cubit/payment_my_fatorah_cubit.dart';

class PaymentMethodsBuildItem extends StatelessWidget {
  const PaymentMethodsBuildItem(
      {super.key, required this.index, required this.paymentMyFatorahModel});
  final PaymentMyFatorahModel paymentMyFatorahModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final paymentMyFatorahCubit = context.read<PaymentMyFatorahCubit>();
    final settingCubit = context.read<SettingCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          paymentMyFatorahCubit.setMethodId(paymentMyFatorahCubit
              .state.paymentMethods[index].paymentMethodId!);
          paymentMyFatorahCubit.sendPayment(paymentMyFatorahModel);
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              children: <Widget>[
                Image.network(
                  paymentMyFatorahCubit.state.paymentMethods[index].imageUrl!,
                  height: 35.0,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  settingCubit.state.locale.languageCode == "en"
                      ? paymentMyFatorahCubit
                              .state.paymentMethods[index].paymentMethodEn ??
                          ""
                      : paymentMyFatorahCubit
                              .state.paymentMethods[index].paymentMethodAr ??
                          "",
                  style: const TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
