import '../../../../main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../../view_model/cubit/add_order_cubit.dart';

void fillInformationFileds(
    ProfileState profileState, AddOrderCubit addOrderCubit) {
  if (profileState.profileModel != null) {
    if (addOrderCubit.emailController.text.isEmpty) {
      addOrderCubit.emailController.text =
          profileState.profileModel!.data!.email!;
    }
    if (addOrderCubit.nameController.text.isEmpty) {
      addOrderCubit.nameController.text =
          profileState.profileModel!.data!.name!;
    }
    if (addOrderCubit.phoneController.text.isEmpty) {
      addOrderCubit.phoneController.text =
          profileState.profileModel!.data!.phone!;
    }
  }
}
