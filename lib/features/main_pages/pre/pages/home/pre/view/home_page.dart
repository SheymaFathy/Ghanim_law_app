import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/service_build_item_widget.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        myAppBar(context, "our_services".tr(context)),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            switch (state.homeDataState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.sucess:
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.homeModel!.priceModel!.length,
                    itemBuilder: (context, index) {
                      return ServiceBuildItemWidget(
                          priceModel: state.homeModel!.priceModel![index]);
                    },
                  ),
                );
              case RequestState.erorr:
                return Text(state.errorMessage);
            }
          },
        ),
      ],
    );
  }
}
