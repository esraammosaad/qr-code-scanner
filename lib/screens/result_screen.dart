import 'package:barcode_widget/barcode_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {Key? key, required this.qrString, required this.closeScanner})
      : super(key: key);
  final String qrString;
  final Function() closeScanner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            closeScanner();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            BarcodeWidget(
              data: qrString,
              barcode: Barcode.qrCode(),
              color: Colors.black,
              height: 200,
              width: 200,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Scanning Result',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              qrString,
              style: const TextStyle(color: Colors.black, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: () {
                FlutterClipboard.copy(qrString).then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copy To Clipboard')));
                });
              },
              color: Colors.blue,
              child: const Text(
                'Copy',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
