(BarcodeCapture capture) {
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            widget.onScanned(barcodes.first.rawValue!);
            scannerController.stop();