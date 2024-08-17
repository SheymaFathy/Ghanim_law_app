import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../main_pages/pre/pages/settings/pre/view_model/cubit/setting_cubit.dart';
import '../../data/model/invoice_model.dart';
import '../view_model/cubit/payment_my_fatorah_cubit.dart';

class PaymentMyFatorahScreen extends StatelessWidget {
  const PaymentMyFatorahScreen(
      {super.key, required this.paymentMyFatorahModel});
  final PaymentMyFatorahModel paymentMyFatorahModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFatoorah Pay'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => PaymentMyFatorahCubit(paymentMyFatorahModel),
        child: BlocConsumer<PaymentMyFatorahCubit, PaymentMyFatorahState>(
          listener: (context, state) {
            if (state.paymentState == PaymentState.requestloading) {
              EasyLoading.show();
            }
          },
          builder: (context, state) {
            final paymentMyFatorahCubit = context.read<PaymentMyFatorahCubit>();

            return Padding(
              padding: const EdgeInsets.all(5),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const PaymentMethodsList(),
                            if (state.isSelectedPayment != -1)
                              BTN(
                                  title: "Send Payment",
                                  onPressed: paymentMyFatorahCubit.sendPayment),
                            BTN(
                                title: "Get Payment Status",
                                onPressed:
                                    paymentMyFatorahCubit.getPaymentStatus),
                          ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic);
  }
}

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentMyFatorahCubit = context.watch<PaymentMyFatorahCubit>();

    return Column(
      children: [
        const Text("Select payment method",
            style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)),
        SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: paymentMyFatorahCubit.state.paymentMethods.length,
            itemBuilder: (BuildContext ctxt, int index) {
              final int id = paymentMyFatorahCubit
                  .state.paymentMethods[index].paymentMethodId!;
              return PaymentMethodsItem(ctxt: ctxt, index: index);
              if (id == 2 || id == 7 || id == 9 || id == 20) {
                return PaymentMethodsItem(ctxt: ctxt, index: index);
              } else {
                return Container();
              }
            },
          ),
        ),
        if (paymentMyFatorahCubit.state.isSelectedPayment != -1)
          Builder(builder: (context) {
            final selectedPaymentValues = paymentMyFatorahCubit.state
                .paymentMethods[paymentMyFatorahCubit.state.isSelectedPayment];
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${"تكلفة خدمة الدفع :"}${selectedPaymentValues.serviceCharge.toString()} ${selectedPaymentValues.paymentCurrencyIso}"),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      "${"اجمالي الدفع :"}${selectedPaymentValues.totalAmount.toString()} ${selectedPaymentValues.paymentCurrencyIso}"),
                ],
              ),
            );
          })
      ],
    );
  }
}

class PaymentMethodsItem extends StatelessWidget {
  const PaymentMethodsItem(
      {super.key, required this.ctxt, required this.index});
  final BuildContext ctxt;
  final int index;
  @override
  Widget build(BuildContext context) {
    final paymentMyFatorahCubit = context.watch<PaymentMyFatorahCubit>();
    final settingCubit = context.read<SettingCubit>();
    return InkWell(
      onTap: () {
        paymentMyFatorahCubit.setPaymentMethodSelected(
          index,
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: paymentMyFatorahCubit.state.isSelectedPayment == index
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.2)),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: <Widget>[
              Image.network(
                paymentMyFatorahCubit.state.paymentMethods[index].imageUrl!,
                height: 35.0,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                settingCubit.state.locale.languageCode == "en"
                    ? paymentMyFatorahCubit
                            .state.paymentMethods[index].paymentMethodEn ??
                        ""
                    : paymentMyFatorahCubit
                            .state.paymentMethods[index].paymentMethodAr ??
                        "",
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class BTN extends StatelessWidget {
  const BTN({Key? key, required this.title, required this.onPressed})
      : super(key: key);
  final String title;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity, // <-- match_parent
        child: CustomElvatedButton(title: title, onPressed: onPressed));
  }
}

class CustomElvatedButton extends StatelessWidget {
  const CustomElvatedButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor:
            WidgetStateProperty.all<Color>(const Color(0xff0495ca)),
        shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.red, width: 1.0),
              );
            } else {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.white, width: 1.0),
              );
            }
          },
        ),
      ),
      child: (title.isNotEmpty)
          ? Text(title,
              style:
                  const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic))
          : const Icon(Icons.refresh),
      onPressed: () async {
        await onPressed();
      },
    );
  }
}
