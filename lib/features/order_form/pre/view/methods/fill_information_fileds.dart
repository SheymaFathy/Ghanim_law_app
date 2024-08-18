import '../../../../main_pages/pre/pages/profile/pre/view_model/cubit/profile_cubit.dart';
import '../../view_model/cubit/add_order_cubit.dart';

void fillInformationFileds(
    ProfileCubit profileCubit, AddOrderCubit addOrderCubit) {
  if (profileCubit.state.profileModel != null) {
    if (addOrderCubit.emailController.text.isEmpty) {
      addOrderCubit.emailController.text =
          profileCubit.state.profileModel!.data!.email!;
    }
    if (addOrderCubit.nameController.text.isEmpty) {
      addOrderCubit.nameController.text =
          profileCubit.state.profileModel!.data!.name!;
    }
    if (addOrderCubit.phoneController.text.isEmpty) {
      addOrderCubit.phoneController.text =
          profileCubit.state.profileModel!.data!.phone!;
    }
  }
}
