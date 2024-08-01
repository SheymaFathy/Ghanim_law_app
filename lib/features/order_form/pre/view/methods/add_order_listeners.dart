import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_router.dart';
import '../../../../../core/enum/enum.dart';
import '../../../../../core/get_it/service_locator.dart';
import '../../../../../core/method/handler_errorr_message_text.dart';
import '../../../../../core/widget/custom_snackbar_widget.dart';
import '../../../../main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import '../../view_model/cubit/add_order_cubit.dart';

addorderListeners(context, state) {
  if (!state.validateFileExtensions) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(customSnackBarWidget(
          "this_files_Not_Validate".tr(context), Colors.red));
  }
  if (state.addOrderState == AuthRequestState.loading) {
    EasyLoading.show(
        status: 'loading...'.tr(context), maskType: EasyLoadingMaskType.black);
  } else if (state.addOrderState == AuthRequestState.erorr) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(customSnackBarWidget(
          erorrMessage(state.erorrMessage, context), Colors.red));
  } else if (state.addOrderState == AuthRequestState.sucess) {
    EasyLoading.dismiss();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          customSnackBarWidget("order_sccess".tr(context), Colors.grey[800]!));
    getIt<MyOrderCubit>().fetchOrdersData();
    context.read<AddOrderCubit>().clearFiled();
    GoRouter.of(context).go(AppRouter.kHomeView);
  }
}
