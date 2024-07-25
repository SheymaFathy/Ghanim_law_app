import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/widgets/my_order_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import '../../../../../../../core/required_login_screen.dart';
import '../../../../../../../core/widget/app_bar.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, "my-order".tr(context)),
        body: checkUserMethod()
            ? const MyOrderViewBody()
            : const RequiredLoginScreen());
  }
}

class MyOrderViewBody extends StatelessWidget {
  const MyOrderViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<MyOrderCubit>()..fetchOrdersData(),
      child: BlocBuilder<MyOrderCubit, MyOrderState>(
        builder: (context, state) {
          switch (state.myOrdersState) {
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            case RequestState.sucess:
              return Center(
                child: ListView.builder(
                  itemCount: state.myOrderModel!.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: OrdersWidget(
                        index: index,
                        orders: state.myOrderModel!.data![index],
                      ),
                    );
                  },
                ),
              );
            case RequestState.erorr:
              return Center(child: Text(state.erorrMessage));
          }
        },
      ),
    );
  }
}
