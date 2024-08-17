import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

import '../../../data/model/invoice_model.dart';

part 'payment_my_fatorah_state.dart';

class PaymentMyFatorahCubit extends Cubit<PaymentMyFatorahState> {
  PaymentMyFatorahCubit(this.paymentMyFatorahModel)
      : super(PaymentMyFatorahState()) {
    initiate();
    mfCardView = MFCardPaymentView(cardViewStyle: cardViewStyle());
    mfApplePayButton = MFApplePayButton(applePayStyle: MFApplePayStyle());
  }

  MFInitiateSessionResponse? session;

  final PaymentMyFatorahModel paymentMyFatorahModel;

  late MFCardPaymentView mfCardView;
  late MFApplePayButton mfApplePayButton;

  initiate() async {
    if (Config.testAPIKey.isEmpty) {
      emit(state.copyWith(
          response:
              "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token"));

      return;
    }

    await MFSDK.init(Config.testAPIKey, MFCountry.QATAR, MFEnvironment.TEST);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initiatePayment();
    });
  }

  // Initiate Payment
  initiatePayment() async {
    var request = MFInitiatePaymentRequest(
        invoiceAmount: double.parse(paymentMyFatorahModel.price),
        currencyIso: MFCurrencyISO.QATAR_QAR);

    await MFSDK.initiatePayment(request, MFLanguage.ARABIC).then((value) {
      emit(state.copyWith(paymentMethods: value.paymentMethods!));

      for (int i = 0; i < state.paymentMethods.length; i++) {
        emit(state.copyWith(isSelectedPayment: -1));
      }
    }).catchError((error) {
      log(error.message);
    });
  }

  log(Object object) {
    var json = const JsonEncoder.withIndent('  ').convert(object);
    emit(state.copyWith(response: json));

    debugPrint(json);
    json;
  }

  // Send Payment
  sendPayment() async {
    //  emit(state.copyWith(paymentState: PaymentState.requestloading));
    var request = MFSendPaymentRequest(
        invoiceValue: double.parse(paymentMyFatorahModel.price),
        customerName: paymentMyFatorahModel.name,
        customerEmail: paymentMyFatorahModel.email,
        customerMobile: paymentMyFatorahModel.phone,
        notificationOption: MFNotificationOption.EMAIL);
    await MFSDK.sendPayment(request, MFLanguage.ARABIC).then((value) {
      state.copyWith(paymentState: PaymentState.requestSuccess);
      executeRegularPayment();
    }).catchError((error) {
      log(error);
      state.copyWith(
          paymentState: PaymentState.requestErorr,
          erorrMessage: error.toString());
    });
  }

  // Execute Regular Payment
  executeRegularPayment() async {
    var request = MFExecutePaymentRequest(
        paymentMethodId: state.isSelectedPayment,
        invoiceValue: double.parse(paymentMyFatorahModel.price));
    request.displayCurrencyIso = MFCurrencyISO.QATAR_QAR;

    await MFSDK.executePayment(request, MFLanguage.ARABIC, (invoiceId) {
      log(invoiceId);
    }).then((value) {
      log("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP${value}");
    }).catchError((error) {
      log(error.message);
    });
  }

  // Payment Enquiry
  getPaymentStatus() async {
    MFGetPaymentStatusRequest request =
        MFGetPaymentStatusRequest(key: '4289602', keyType: MFKeyType.INVOICEID);

    await MFSDK
        .getPaymentStatus(request, MFLanguage.ARABIC)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Token
  cancelToken() async {
    await MFSDK
        .cancelToken("Put your token here", MFLanguage.ARABIC)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  // Cancel Recurring Payment
  cancelRecurringPayment() async {
    await MFSDK
        .cancelRecurringPayment("Put RecurringId here", MFLanguage.ARABIC)
        .then((value) => log(value))
        .catchError((error) => {log(error.message)});
  }

  setPaymentMethodSelected(int index) {
    emit(state.copyWith(isSelectedPayment: index));
  }

  MFCardViewStyle cardViewStyle() {
    MFCardViewStyle cardViewStyle = MFCardViewStyle();
    cardViewStyle.cardHeight = 200;
    cardViewStyle.hideCardIcons = false;
    cardViewStyle.input?.inputMargin = 3;
    cardViewStyle.label?.display = true;
    cardViewStyle.input?.fontFamily = MFFontFamily.Arial;
    cardViewStyle.label?.fontWeight = MFFontWeight.Light;
    return cardViewStyle;
  }

  initiateSession() async {
    MFInitiateSessionRequest initiateSessionRequest =
        MFInitiateSessionRequest();
    await MFSDK
        .initiateSession(initiateSessionRequest, (bin) {
          log(bin);
        })
        .then((value) => {log(value)})
        .catchError((error) => {log(error.message)});
  }
}

class Config {
  static const String testAPIKey =
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
}
