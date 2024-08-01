import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';

import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/order_details/pre/view_model/cubit/my_order_details_cubit.dart';

import '../../../../core/get_it/service_locator.dart';

import '../../../../core/widget/custom_erorr_page._widget.dart';
import 'widgets/my_order_details_view_body.dart';

class MyOrderDetails extends StatelessWidget {
  const MyOrderDetails({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "order_details".tr(context)),
      body: BlocProvider.value(
        value: getIt<MyOrderDetailsCubit>()..fetchOrderDetailsById(id),
        child: BlocBuilder<MyOrderDetailsCubit, MyOrderDetailsState>(
          builder: (context, state) {
            switch (state.myorderDetailsState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              case RequestState.sucess:
                return MyOrderDetailsViewBody(state: state);
              case RequestState.erorr:
                return CustomErorrPageWidget(
                  onTap: () {
                    context
                        .read<MyOrderDetailsCubit>()
                        .fetchOrderDetailsById(id);
                  },
                  errorMessage: state.erorrMessage,
                );
            }
          },
        ),
      ),
    );
  }
}
