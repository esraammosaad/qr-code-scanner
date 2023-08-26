import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:scan_qr_code/screens/result_screen.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({Key? key}) : super(key: key);

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  bool isScanned = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScanner() {
    isScanned = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.yellow,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });

              controller.toggleTorch();
            },
          ),
          IconButton(
            icon: Icon(
              isFrontCamera
                  ? Icons.photo_camera_front_outlined
                  : Icons.camera_alt_outlined,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });

              controller.switchCamera();
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'QR Scanner ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Place The QR Code In The Area',
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Scanning Will Be Started Automatically',
                    style: TextStyle(color: Colors.black.withOpacity(0.9)),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        MobileScanner(
                            controller: controller,
                            onDetect: (capture) {
                              if (!isScanned) {
                                String? qrString;
                                final List barcodes = capture.barcodes;
                                for (final barcode in barcodes) {
                                  qrString = barcode.rawValue;
                                  debugPrint(
                                      'Barcode found! ${barcode.rawValue}');
                                }

                                isScanned = true;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                              qrString: qrString!,
                                              closeScanner: closeScanner,
                                            )));
                              }
                            }),
                        QRScannerOverlay(
                          overlayColor: Colors.white,
                          borderColor: Colors.blue,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
