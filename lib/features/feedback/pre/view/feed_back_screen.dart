import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/feedback/pre/view/widgets/messages%20list.dart';
import 'package:ghanim_law_app/features/feedback/pre/view_model/cubit/feedback_cubit.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../../../../core/get_it/service_locator.dart';
import '../../../../core/method/handler_errorr_message_text.dart';
import '../../../../core/widget/custom_snackbar_widget.dart';

class FeedBackScreen extends StatelessWidget {
  const FeedBackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> staticMessages = List.generate(
      3,
      (index) => index % 2 == 0
          ? {"sender": "user", "message": " المستخدم: السلام عليكم  "}
          : {
              "sender": "admin",
              "message":
                  "رد الادمن : وعليكم السلام ورحمة الله وبركاته كيف حالك ؟"
            },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: myAppBar(context, "feedback".tr(context)),
      body: BlocProvider(
        create: (context) => FeedbackCubit(getIt()),
        child: BlocConsumer<FeedbackCubit, FeedbackState>(
          listener: (context, state) {
            if (state.feedbackRequestState == RequestState.loading) {
              EasyLoading.show(
                status: 'loading...'.tr(context),
                maskType: EasyLoadingMaskType.black,
              );
            } else if (state.feedbackRequestState == RequestState.sucess) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBarWidget(state.feedBackMessage,
                    Theme.of(context).colorScheme.onSurface));
            } else if (state.feedbackRequestState == RequestState.erorr) {
              EasyLoading.dismiss();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(customSnackBarWidget(
                    erorrMessage(state.feedBackMessage, context), Colors.red));
            }
          },
          builder: (context, state) {
            final feedBackCubit = context.read<FeedbackCubit>();
            return Column(
              children: [
                //  messages list
                MessagesList(staticMessages: staticMessages),
                // text input
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: feedBackCubit.feedbackController,
                          decoration: InputDecoration(
                            hintText: "feedback_filed".tr(context),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          // final profileState =
                          //     getIt<ProfileCubit>().state.profileModel!.data!;
                          // final message =
                          //     feedBackCubit.feedbackController.text.trim();

                          // if (message.isNotEmpty) {
                          //   feedBackCubit.sendFeedBackMessage({
                          //     "name": profileState.name!,
                          //     "phone": profileState.phone,
                          //     "email": profileState.email!,
                          //     "message": message,
                          //   });
                          //   feedBackCubit.feedbackController.clear();
                          // }
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
