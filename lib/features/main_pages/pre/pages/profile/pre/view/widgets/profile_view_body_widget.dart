import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../../../core/constants/app_colors.dart';
import '../../../../../../../../core/constants/app_router.dart';
import '../../../../../../../../core/constants/styles.dart';
import '../../view_model/cubit/profile_cubit.dart';

class ProfileViewBodyWidget extends StatelessWidget {
  const ProfileViewBodyWidget({super.key, required this.state});
  final ProfileState state;
  @override
  Widget build(BuildContext context) {
    final prfileData = state.profileModel!.data;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        CircleAvatar(
          backgroundColor: AppColors.backgroundColor,
          radius: 60,
          backgroundImage: NetworkImage(state.profileModel!.data!.avatar!),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(prfileData!.name!, style: Styles.textStyle18),
            IconButton(
                onPressed: () {
                  GoRouter.of(context).push(AppRouter.kUpdateProfile);
                },
                icon: const Icon(Icons.edit))
          ],
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[200]!, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(Icons.email, color: Colors.blueGrey[900]),
            title: Text(
              prfileData.email!,
              style: TextStyle(color: Colors.blueGrey[900]),
            ),
          ),
        ),

  Container(
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey[200]!, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
          child: ListTile(
            leading: Icon(Icons.phone, color: Colors.blueGrey[900]),
            title: Text(
              prfileData.phone!,
              style: TextStyle(color: Colors.blueGrey[900]),
            ),
          ),
        ),
        //
      ]),
    );
  }
}
