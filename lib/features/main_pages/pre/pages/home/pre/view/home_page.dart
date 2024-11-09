import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';

import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view/widgets/custom_service_container.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';

import '../../../../../../../core/get_it/service_locator.dart';
import '../../../../../../../core/widget/custom_erorr_page_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<HomeCubit>()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch (state.homeDataState) {
            case RequestState.loading:
              return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onSurface),
              );
            case RequestState.sucess:
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.homeModel!.services!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CustomServiceContainer(
                      servicesModel: state.homeModel!.services![index],
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
