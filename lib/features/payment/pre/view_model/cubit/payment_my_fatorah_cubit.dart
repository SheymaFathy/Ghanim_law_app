import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghanim_law_app/core/enum/enum.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../../data/model/invoice_model.dart';

part 'payment_my_fatorah_state.dart';

class PaymentMyFatorahCubit extends Cubit<PaymentMyFatorahState> {
  PaymentMyFatorahCubit() : super(const PaymentMyFatorahState());
  static int? paymentMethodId;
  initiApi(num price) async {
    if (Config.testAPIKey.isEmpty) {
      emit(state.copyWith(
          response:
              "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token"));
      return;
    }

    await MFSDK.init(Config.testAPIKey, MFCountry.QATAR, MFEnvironment.TEST);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiatePayment(price);
    });
  }

  // Send Payment
  initiatePayment(num price) async {
    emit(state.copyWith(paymentSendState: PaymentState.methodsPaymentLoading));
    var request = MFInitiatePaymentRequest(
        invoiceAmount: price, currencyIso: MFCurrencyISO.QATAR_QAR);

    await MFSDK.initiatePayment(request, MFLanguage.ARABIC).then((value) {
      emit(state.copyWith(
          paymentMethods: value.paymentMethods!,
          paymentSendState: PaymentState.methodsPaymentSuccess));
      log('Initiate Payment Response: ${jsonEncode(value.toJson())}');
    }).catchError((error) {
      log('Initiate Payment Error: ${error.toString()}');
      emit(state.copyWith(
          erorrMessage: error.message,
          response: 'Error initiating payment: ${error.toString()}',
          paymentSendState: PaymentState.paymentErorr));
    });
  }

  // Log function
  log(String message) {
    debugPrint(message);
  }

  // Send Payment
  sendPayment(PaymentMyFatorahModel paymentMyFatorahModel) async {
    emit(state.copyWith(paymentSendState: PaymentState.requestPaymentLoading));
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(paymentMyFatorahModel.price),
        customerName: paymentMyFatorahModel.name,
        customerEmail: paymentMyFatorahModel.email,
        customerMobile: paymentMyFatorahModel.phone,
        notificationOption: MFNotificationOption.EMAIL);
    await MFSDK.sendPayment(request, MFLanguage.ARABIC).then((value) {
      log("Send Payment Response: ${jsonEncode(value.toJson())}");
      emit(
          state.copyWith(paymentSendState: PaymentState.requestPaymentSuccess));
      getPaymentStatus(value.invoiceId.toString());
    }).catchError((error) {
      log('Send Payment Error: ${error.toString()}');
      emit(state.copyWith(
          paymentSendState: PaymentState.paymentErorr,
          erorrMessage: error.toString()));
    });
  }

  // Execute Regular Payment
  executeRegularPayment(PaymentMyFatorahModel paymentMyFatorahModel) async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: paymentMethodId,
        invoiceValue: double.parse(paymentMyFatorahModel.price));
    request.displayCurrencyIso = MFCurrencyISO.QATAR_QAR;

    await MFSDK
        .executePayment(request, MFLanguage.ARABIC, (invoiceId) {})
        .then((value) {
      emit(state.copyWith(
          paymentSendState: PaymentState.executePaymentSuccess,
          executePaymentResponse: value));
      log("Execute Payment Response: ${jsonEncode(value.toJson())}");
    }).catchError((error) {
      emit(state.copyWith(
          paymentSendState: PaymentState.paymentErorr,
          erorrMessage: error.message));
      log('Execute Payment Error: ${error.message}');
    });
  }

  setMethodId(int id) {
    paymentMethodId = id;
  }

  // Payment Enquiry
  getPaymentStatus(String key) async {
    emit(state.copyWith(paymentSendState: PaymentState.statusPaymentLoading));
    MFGetPaymentStatusRequest request =
        MFGetPaymentStatusRequest(key: key, keyType: MFKeyType.INVOICEID);

    await MFSDK.getPaymentStatus(request, MFLanguage.ARABIC).then((value) {
      emit(state.copyWith(
          paymentSendState: PaymentState.statusPaymentSuccess,
          paymentStatusResponse: value));
    }).catchError((error) {
      emit(state.copyWith(
          paymentSendState: PaymentState.paymentErorr,
          erorrMessage: error.toString()));
    });
  }

  // Cancel Token
  // cancelToken() async {
  //   await MFSDK
  //       .cancelToken("Put your token here", MFLanguage.ARABIC)
  //       .then((value) => log(value))
  //       .catchError((error) => {log(error.message)});
  // }

  // Cancel Recurring Payment
  // cancelRecurringPayment() async {
  // await MFSDK
  //     .cancelRecurringPayment("Put RecurringId here", MFLanguage.ARABIC)
  //     .then((value) => log(value))
  //       .catchError((error) => {log(error.message)});
  // }
}

class Config {
  static const String testAPIKey =
      "Y9XRZ4LMV8f12Ngg4F2iGUjMf_wcgbkay1Ap9QH8uXm8eqHGiOX0R7nNrUrQs-MvtSk64Egz0gNVxaDY86PzUNAmSTG124vzT5qiTRj8AMDo0Jq2nXSXioZ-_2HF-I1j_VoBNzS-EjXNmwyw4vP7UkRxFavokhximUIlbMUHcbF0kDhNnraz5gUuneEcJsEMr4Fk3kfdg2QbbUKxVPBY-fuSssdOnHoR175wdbyu0oYsqjCzEgINPekdAVxcq8R1wk1dV6tC1uX9epopCE_B_I0Z338ShkJHmu5z4qsq_Csu_1NaGHTbTu2yHTxx7oEyFdqd6GvglH_2gGVEaJZzTl2_VVUUhhjJC9ef86N4JdCjqHfKfkUUqK1REfZ6t7nTTQUP2TwHRtl8OEKKvxKM7OWr6Q9VqUcHNiD7WC_5MW_ywh2WQ0LmI-ny5gSLMvGZGPilPPCZK2p-gOsbaf-Tnrw2Pl6rHu7yL9Pp3qHy3a3klmBksrJbHfJUUsrkccucOIgXwjH0ged6jQ6mYCIyAbUc6zDpk-q0EmGn-uBJlBDoBfTaEL2nF2T46zUL6FH4LK0pjNXEBWg9iGb6WHbC1mNhZ6KTywBRcHpQoNARI4pp_hm94c9jNo9nNi9dEE_O7G9t6HdXxzhhq27DxSYPco1kDKxOyVOvBE_iSYIE5Yu0zjcU";
}
