import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String) onScanned;
  final bool isScanning;

  const QRScannerWidget({super.key, required this.onScanned, required this.isScanning});

  @override
  QRScannerWidgetState createState() => QRScannerWidgetState();
}

class QRScannerWidgetState extends State<QRScannerWidget> {
  final MobileScannerController scannerController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    if (widget.isScanning) {
      scannerController.start();  // Start scanning when isScanning is true
    } else {
      scannerController.stop();   // Stop scanning when isScanning is false
    }
  }

  @override
  void didUpdateWidget(covariant QRScannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        scannerController.start();  // Start scanning if isScanning is true
      } else {
        scannerController.stop();   // Stop scanning if isScanning is false
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: MobileScanner(
        controller: scannerController,
        onDetect: (BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            widget.onScanned(barcodes.first.rawValue!);
            scannerController.stop();  // Stop scanning after a barcode is detected
          }
        },
      ),
    );
  }
}
