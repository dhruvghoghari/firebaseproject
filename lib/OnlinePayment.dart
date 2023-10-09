import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OnlinePayment extends StatefulWidget {

  @override
  State<OnlinePayment> createState() => _OnlinePaymentState();
}
class _OnlinePaymentState extends State<OnlinePayment> {

  TextEditingController _amt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OnlinePayment"),),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _amt,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20.0),
                      right: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              Razorpay razorpay = Razorpay();
              var options = {
                'key': 'rzp_test_Mt9MXl4r8xxXVV',
                'amount': double.parse(_amt.text.toString()) * 100,
                'name': 'App Name',
                'description': 'Package Purchase',
                'retry': {'enabled': true, 'max_count': 1},
                'send_sms_hash': true,
                'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
                'external': {
                  'wallets': ['paytm']
                }
              };
              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
              razorpay.open(options);
            }, child: Text("Pay"))
          ],
        ),
      ),
    );
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    // Redirect to FailPage
   // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    //Thankyou page
    //API
    print(response.paymentId);
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
   // showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }
}
