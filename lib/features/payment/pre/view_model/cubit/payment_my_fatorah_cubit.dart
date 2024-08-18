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
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
}
