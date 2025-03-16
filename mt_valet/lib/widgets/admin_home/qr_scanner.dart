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
    detectionSpeed: DetectionSpeed.normal,
    formats: const [BarcodeFormat.qrCode],
    facing: CameraFacing.back,
  );

  @override
  void initState() {
    super.initState();
    if (widget.isScanning) {
      scannerController.start();
    } else {
      scannerController.pause();
    }
  }

  @override
  void didUpdateWidget(covariant QRScannerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScanning) {
      scannerController.start();
    } else {
      scannerController.pause();
    }
  }

  @override
  void dispose() {
    scannerController.stop(); // Only stop when leaving screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.33,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blueAccent, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: MobileScanner(
          controller: scannerController,
          onDetect: (BarcodeCapture capture) {
            final List<Barcode> barcodes = capture.barcodes;
            if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
              widget.onScanned(barcodes.first.rawValue!);
              scannerController.pause(); // Pause after first scan
            }
          },
        ),
      ),
    );
  }
}