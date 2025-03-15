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
  final MobileScannerController scannerController = MobileScannerController(
    torchEnabled: false,  // Ensures iOS compatibility
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );

  @override
  void initState() {
    super.initState();
    if (widget.isScanning) {
      scannerController.start();  // Start scanning when isScanning is true
    } 
  }

  @override
  void didUpdateWidget(covariant QRScannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning != oldWidget.isScanning) {
      if (widget.isScanning) {
        scannerController.start();  // Start scanning when widget is first created
      } else {
        scannerController.pause();  // Pause scanning
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: MobileScanner(
        controller: scannerController,
        onDetect: (BarcodeCapture capture) { //BarcodeCapture is an object containing all barcodes detected in a frame. It has a property called .barcodes, which is a list of barcodes found in the scanned image.
          final List<Barcode> barcodes = capture.barcodes; //extracts the list of detected barcodes from the capture object. If no QR code is found, barcodes will be an empty list.
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) { //gets the first detected barcode. .rawValue is the actual text encoded in the barcode (e.g., a customer ID or URL). If this value is null, the QR code might be unreadable.
            widget.onScanned(barcodes.first.rawValue!);
            scannerController.pause();  // Pause scanning after a barcode is detected
          }
        },
      ),
    );
  }
}