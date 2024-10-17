import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/get_it/service_locator.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view/widgets/my_order_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/my_orders/pre/view_model/cubit/my_order_cubit.dart';
import '../../../../../../../core/required_login_screen.dart';
import '../../../../../../../core/shared_preferences/cache_helper.dart';
import '../../../../../../../core/widget/custom_erorr_page_widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const MyOrderViewBody();
  }
}

class MyOrderViewBody extends StatelessWidget {
  const MyOrderViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrderCubit, MyOrderState>(
        bloc: getIt<MyOrderCubit>()..fetchOrdersData(),
        listener: (context, state) {
          if (state.myOrdersState == RequestState.erorr) {
            if (state.erorrStatusCode != null && state.erorrStatusCode == 401) {
              CacheHelper.clearData(key: 'uId');
              checkUserMethod();
            } else {
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
              return state.myOrderModel!.data!.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.library_books,
                            size: 75,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "No Orders Yet ...".tr(context),
                            style: Styles.textStyle20,
                          )
                        ],
                      ),
                    )
                  : Center(
                      child: ListView.builder(
                        itemCount: state.myOrderModel!.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: OrdersWidget(
                              index: index,
                              orders: state.myOrderModel!.data![index],
                            ),
                          );
                        },
                      ),
                    );
            case RequestState.erorr:
              if (state.erorrStatusCode == 401) {
                return const RequiredLoginScreen();
              } else {
                return CustomErorrPageWidget(
                  onTap: () {
                    context.read<MyOrderCubit>().fetchOrdersData();
                  },
                  errorMessage: state.erorrMessage,
                );
              }
          }
        });
  }
}
