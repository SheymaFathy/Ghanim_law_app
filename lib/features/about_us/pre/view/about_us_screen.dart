import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/image_assets.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/about_us/pre/view/widgets/custom_about_us_container.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/pre/view_model/cubit/home_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/get_it/service_locator.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: myAppBar(context, "contact_us".tr(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: BlocProvider.value(
          value: getIt<HomeCubit>(),
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final contactUsModel = state.homeModel!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // App Logo
                    Image.asset(AppImageAsset.logo),
                    const SizedBox(height: 15),
                    Text('keep_in_touch'.tr(context),
                        style: Styles.textStyle18, textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    CustomAboutUsContainer(
                      title: contactUsModel.contacts!.phone!,
                      iconData: Icons.phone,
                    ),
                    CustomAboutUsContainer(
                      title: contactUsModel.contacts!.phone2!,
                      iconData: Icons.phone,
                    ),
                    CustomAboutUsContainer(
                      title: contactUsModel.contacts!.email!,
                      iconData: Icons.email_outlined,
                    ),
                    CustomAboutUsContainer(
                      title: contactUsModel.contacts!.email2!,
                      iconData: Icons.email_outlined,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.2),
                      ),
                      child: Text(
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.justify,
                          '${"Address".tr(context)}: ${contactUsModel.contacts!.address!}'),
                    ),
                    //     const Spacer(),
                    Text('follow_us'.tr(context),
                        style: Styles.textStyle16
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const CustomPngImageWidget(
                            imagePath: "assets/images/facebook.png",
                          ),
                          onPressed: () => launchUrl(
                              Uri.parse(contactUsModel.contacts!.facebook!)),
                        ),
                        IconButton(
                          icon: const CustomPngImageWidget(
                            imagePath: "assets/images/twitter.png",
                          ),
                          onPressed: () => launchUrl(
                              Uri.parse(contactUsModel.contacts!.twitter!)),
                        ),
                        IconButton(
                          icon: const CustomPngImageWidget(
                            imagePath: "assets/images/snapchat.png",
                          ),
                          onPressed: () => launchUrl(
                              Uri.parse(contactUsModel.contacts!.snapchat!)),
                        ),
                        IconButton(
                          icon: const CustomPngImageWidget(
                            imagePath: "assets/images/insta.png",
                          ),
                          onPressed: () => launchUrl(
                              Uri.parse(contactUsModel.contacts!.instagram!)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      'title'.tr(context),
                      style: Styles.textStyle14,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      contactUsModel.app!.copyright!,
                      //  style: Styles.textStyle11,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomPngImageWidget extends StatelessWidget {
  const CustomPngImageWidget({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        child: Image.asset(
      imagePath,
      width: 30,
      height: 30,
    ));
  }
}
