import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import '../../../../../core/constants/styles.dart';
import '../../view_model/cubit/my_order_details_cubit.dart';

class MyOrderPersonDetailsWidget extends StatelessWidget {
  const MyOrderPersonDetailsWidget({
    super.key,
    required this.state,
  });

  final MyOrderDetailsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(state.myOrderDetailsModel!.data!.type!.label!,
              style: Styles.textStyle18),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Text("status".tr(context), style: Styles.textStyle14),
          trailing: Text(state.myOrderDetailsModel!.data!.status!.label!,
              style: Styles.textStyle14.copyWith(
                  color: state.myOrderDetailsModel!.data!.status!.code == 'new'
                      ? Colors.blue
                      : state.myOrderDetailsModel!.data!.status!.code ==
                              'completed'
                          ? const Color(0xff28a745)
                          : state.myOrderDetailsModel!.data!.status!.code ==
                                  'in_progress'
                              ? const Color(0xff6f42c1)
                              : state.myOrderDetailsModel!.data!.status!.code ==
                                      'rejected'
                                  ? const Color(0xffdc3545)
                                  : null)),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Text("name".tr(context), style: Styles.textStyle14),
          trailing: Text(state.myOrderDetailsModel!.data!.name!,
              style: Styles.textStyle14),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: Text("email".tr(context), style: Styles.textStyle14),
          trailing: Text(state.myOrderDetailsModel!.data!.email!,
              style: Styles.textStyle14),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Text("phone".tr(context), style: Styles.textStyle14),
          trailing: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(state.myOrderDetailsModel!.data!.phone!,
                textAlign: TextAlign.left, style: Styles.textStyle14),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Text("order_id".tr(context), style: Styles.textStyle14),
          trailing: Text(state.myOrderDetailsModel!.data!.id.toString(),
              style: Styles.textStyle14),
        ),
        const SizedBox(
          height: 10,
        ),
        if (state.myOrderDetailsModel!.data!.invoiceId != null)
          ListTile(
            leading:
                Text("Invoice Number".tr(context), style: Styles.textStyle14),
            trailing: Text(
                state.myOrderDetailsModel!.data!.invoiceId.toString(),
                style: Styles.textStyle14),
          ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
