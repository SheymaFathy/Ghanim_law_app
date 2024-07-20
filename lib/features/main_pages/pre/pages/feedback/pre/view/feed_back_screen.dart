import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/core/widget/custom_button.dart';
import 'package:ghanim_law_app/core/widget/global_textfield.dart';
import 'package:ghanim_law_app/features/auth/widget/logo.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/feedback/pre/view_model/cubit/feedback_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';

import '../../../../../../../core/get_it/service_locator.dart';
import '../../../../../../../core/widget/custom_snackbar_widget.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "feedback".tr(context)),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => FeedbackCubit(getIt()),
          child: Builder(builder: (context) {
            return BlocConsumer<FeedbackCubit, FeedbackState>(
                listener: (context, state) {
              if (state.feedbackRequestState == RequestState.loading) {
                EasyLoading.show(
                    status: 'loading...'.tr(context),
                    maskType: EasyLoadingMaskType.black);
              } else if (state.feedbackRequestState == RequestState.sucess) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(customSnackBarWidget(
                      state.feedBackMessage, Colors.grey[800]!));
              } else if (state.feedbackRequestState == RequestState.erorr) {
                EasyLoading.dismiss();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                      customSnackBarWidget(state.feedBackMessage, Colors.red));
              }
            }, builder: (context, state) {
              final feedBackCubit = context.read<FeedbackCubit>();
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthLogo(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "feedback_title".tr(context),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GlobalTextfield(
                      hinttext: "feedback_filed".tr(context),
                      maxline: 10,
                      mycontroller: feedBackCubit.feedbackController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomBotton(
                        backgroundColor: AppColors.primeryColor,
                        textColor: AppColors.backgroundColor,
                        text: "confirm".tr(context),
                        onPressed: () {
                          final profileState =
                              getIt<ProfileCubit>().state.profileModel!.data!;

                          feedBackCubit.sendFeedBackMessage({
                            "name": profileState.name!,
                            "phone": profileState.phone,
                            "email": profileState.email!,
                            "message": feedBackCubit.feedbackController.text,
                          });
                        })
                  ],
                ),
              );
            });
          }),
        ),
      ),
    );
  }
}
