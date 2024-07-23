import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/AppLocalizations/app_localizations.dart';
import 'package:ghanim_law_app/core/constants/app_colors.dart';
import 'package:ghanim_law_app/core/constants/image_assets.dart';
import 'package:ghanim_law_app/core/constants/styles.dart';
import 'package:ghanim_law_app/core/widget/app_bar.dart';
import 'package:ghanim_law_app/features/about_us/pre/view/widgets/custom_about_us_container.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "contact_us".tr(context)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // App Logo
                  Image.asset(AppImageAsset.logo),
                  const SizedBox(height: 15),
                  Text('keep_in_touch'.tr(context),style: Styles.textStyle18,textAlign:TextAlign.center),
                  const SizedBox(height: 10),
                   const CustomAboutUsContainer(title: '+97450888700', iconData: Icons.phone,),
                   const CustomAboutUsContainer(title: '+97444888700', iconData: Icons.phone,),
                   const CustomAboutUsContainer(title: 'info@ghanimlawfirm.com', iconData: Icons.email_outlined,),
                   const CustomAboutUsContainer(title: 'support@ghanimlawfirm.com', iconData: Icons.email_outlined,),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.lightGrey),
                      borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // grey shadow with opacity
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey.shade200, // very light grey
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter,
                        ),
                      color: AppColors.backgroundColor
                    ),
                    child: const Text(
                      overflow: TextOverflow.fade,
                        textAlign: TextAlign.justify,
                        'Address: Head OfficeAl Nasr Tower 2, 1st Floor Office Number 103, West Bay Doha, Qatar'),
                  ),
                  const Spacer(),
                  Text('follow_us'.tr(context),style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600),textAlign:TextAlign.center),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon:  const Icon(Icons.facebook),
                        onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                      ),
                      IconButton(
                        icon: const Icon(Icons.facebook),
                        onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                      ),
                      IconButton(
                        icon: const Icon(Icons.snapchat),
                        onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                      ),
                      IconButton(
                        icon: const Icon(Icons.facebook),
                        onPressed: () => launchUrl(Uri.parse('https://twitter.com')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                   Text(
                     textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    'title'.tr(context),
                    style:Styles.textStyle14,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    'Copyright © 2024 Ghanim Law Firm All rights reserved.',
                    style: Styles.textStyle11,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


