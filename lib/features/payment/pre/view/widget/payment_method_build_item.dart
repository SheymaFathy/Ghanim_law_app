import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/get_it/service_locator.dart';
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
    final settingCubit = context.read<SettingCubit>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: () {
          getIt<PaymentMyFatorahCubit>().setMethodId(
              getIt<PaymentMyFatorahCubit>()
                  .state
                  .paymentMethods[index]
                  .paymentMethodId!);
          getIt<PaymentMyFatorahCubit>().sendPayment(paymentMyFatorahModel);
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
                  getIt<PaymentMyFatorahCubit>()
                      .state
                      .paymentMethods[index]
                      .imageUrl!,
                  height: 35.0,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  settingCubit.state.locale.languageCode == "en"
                      ? getIt<PaymentMyFatorahCubit>()
                              .state
                              .paymentMethods[index]
                              .paymentMethodEn ??
                          ""
                      : getIt<PaymentMyFatorahCubit>()
                              .state
                              .paymentMethods[index]
                              .paymentMethodAr ??
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
