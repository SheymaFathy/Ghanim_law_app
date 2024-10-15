import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/features/order_form/pre/view_model/cubit/add_order_cubit.dart';

import '../../../../../core/get_it/service_locator.dart';
import '../../../../main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../../../data/model/invoice_model.dart';

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
          print(getIt<AddOrderCubit>()
              .state
              .paymentMethods[index]
              .paymentMethodId);
          getIt<AddOrderCubit>().setMethodId(getIt<AddOrderCubit>()
              .state
              .paymentMethods[index]
              .paymentMethodId!);
          getIt<AddOrderCubit>().getPaymentStatus(
            paymentMyFatorahModel,
          );
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
                  getIt<AddOrderCubit>().state.paymentMethods[index].imageUrl!,
                  height: 35.0,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  settingCubit.state.locale.languageCode == "en"
                      ? getIt<AddOrderCubit>()
                              .state
                              .paymentMethods[index]
                              .paymentMethodEn ??
                          ""
                      : getIt<AddOrderCubit>()
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
