// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
// import 'package:ghanim_law_app/core/widget/custom_button.dart';
// import 'package:ghanim_law_app/core/widget/custom_snackbar_widget.dart';
// import 'package:ghanim_law_app/features/auth/login/pre/view/widget/login_erorr_widget.dart';
// import 'package:ghanim_law_app/features/order_details/pre/view_model/cubit/my_order_details_cubit.dart';
// import 'package:ghanim_law_app/features/payment/pre/view/widget/payment_details_view.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../../core/constants/app_router.dart';
// import '../../../../../core/enum/enum.dart';
// import '../../../../../core/get_it/service_locator.dart';
// import '../../../../order_form/pre/view_model/cubit/add_order_cubit.dart';
// import '../../../data/model/invoice_model.dart';

// class PaymentExecuteSucsessAndUploadOrderWidget extends StatelessWidget {
//   const PaymentExecuteSucsessAndUploadOrderWidget(
//       {super.key, required this.paymentMyFatorahModel, required this.state});

//   final PaymentMyFatorahModel paymentMyFatorahModel;
//   final AddOrderState state;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AddOrderCubit, AddOrderState>(
//       listener: (context, state) async {
//         if (state.paymentSendState == PaymentState.executePaymentSuccess) {
//           GoRouter.of(context).go(AppRouter.kHomeView);
//         }
//       },
//       bloc: getIt<AddOrderCubit>(),
//       builder: (context, addOrderState) {
//         return 
//       },
//     );
//   }
// }
