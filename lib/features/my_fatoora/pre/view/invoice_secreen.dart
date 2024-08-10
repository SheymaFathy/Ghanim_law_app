import 'package:flutter/material.dart';
import 'package:ghanim_law_app/features/main_pages/pre/view/main_screen.dart';
import 'package:myfatoorah_pay/myfatoorah_pay.dart';

class InvoiceSecreen extends StatefulWidget {
  @override
  State<InvoiceSecreen> createState() => _InvoiceSecreenState();

  const InvoiceSecreen({super.key});
}

class _InvoiceSecreenState extends State<InvoiceSecreen> {
  String myFatoorahApiTest = 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyFatoorah Pay'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.6,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(2, 4),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                ),
                child: const Text('ادفع الآن', style: TextStyle(color: Colors.white)),
              ),
              onTap: () async {
                var response = await MyFatoorahPay.startPayment(
                  context: context,
                  request: MyfatoorahRequest.test(
                    currencyIso: MFCountry.Qatar,
                    invoiceAmount: 100,
                    language: MFApiLanguage.English,
                    token: myFatoorahApiTest,
                  ),
                );
                debugPrint("isSuccess ${response.isSuccess}, ${response.status}");

                if (response.isSuccess) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("تم الدفع بنجاح"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MainScreen()),
                              );
                            },
                            child: Text("حسناً"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // payment failed ... tell user: try again
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
