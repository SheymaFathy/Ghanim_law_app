import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';

import '../../../../core/get_it/service_locator.dart';
import '../../../../core/widget/custom_erorr_page._widget.dart';
import '../../../main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: myAppBar(context, 'terms_and_privcy'.tr(context)),
      body: BlocProvider.value(
          value: getIt<HomeCubit>(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.homeDataState) {
                  case RequestState.loading:
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  case RequestState.sucess:
                    return PrivacyAndTermsViewBody(state: state);
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
          )),
    );
  }
}

class PrivacyAndTermsViewBody extends StatelessWidget {
  const PrivacyAndTermsViewBody({super.key, required this.state});
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UsagePolicyAndPrivacyCustomWidget(
          title: "privacy".tr(context),
          content: state.homeModel!.pages!.privacy!.content!,
        ),
        const SizedBox(height: 15.0),
        UsagePolicyAndPrivacyCustomWidget(
          title: "terms".tr(context),
          content: state.homeModel!.pages!.terms!.content!,
        ),
      ],
    );
  }
}

class UsagePolicyAndPrivacyCustomWidget extends StatelessWidget {
  const UsagePolicyAndPrivacyCustomWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Styles.textStyle18),
        const SizedBox(height: 5.0),
        Divider(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(height: 16.0),
        Text('content'.tr(context), style: Styles.textStyle18),
        const SizedBox(height: 8.0),
        Text(
          content,
          style: Styles.textStyle14,
        ),
      ],
    );
  }
}
