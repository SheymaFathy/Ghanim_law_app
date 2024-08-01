import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';

import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/custom_service_container.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';

import '../../../../../../../core/widget/custom_erorr_page._widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "our_services".tr(context)),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          print("errrr".tr(context) == "");
          switch (state.homeDataState) {
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            case RequestState.sucess:
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.homeModel!.priceModel!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CustomServiceContainer(
                      priceModel: state.homeModel!.priceModel![index],
                    ),
                  );
                },
              );
            case RequestState.erorr:
              return CustomErorrPageWidget(
                onTap: () {
                  context.read<HomeCubit>().getHomeData();
                },
                errorMessage: state.errorMessage,
              );
          }
        },
      ),
    );
  }
}
