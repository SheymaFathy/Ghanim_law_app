import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/widgets/my_order_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import '../../../../../../../core/required_login_screen.dart';
import '../../../../../../../core/shared_preferences/cache_helper.dart';
import '../../../../../../../core/widget/custom_erorr_page._widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return checkUserMethod()
        ? const MyOrderViewBody()
        : const RequiredLoginScreen();
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
      child: BlocConsumer<MyOrderCubit, MyOrderState>(
        listener: (context, state) {
          if (state.myOrdersState == RequestState.erorr) {
            if (state.erorrStatusCode != null && state.erorrStatusCode == 401) {
              CacheHelper.clearData(key: 'uId');
              checkUserMethod();
            }
          }
        },
        builder: (context, state) {
          switch (state.myOrdersState) {
            case RequestState.loading:
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onSurface,
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
              return CustomErorrPageWidget(
                onTap: () {
                  context.read<MyOrderCubit>().fetchOrdersData();
                },
                errorMessage: state.erorrMessage,
              );
          }
        },
      ),
    );
  }
}
