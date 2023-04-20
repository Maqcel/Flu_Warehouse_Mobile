import 'package:flu_warehouse_mobile/presentation/common_widgets/common_qr_scanner.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flutter/material.dart';

class HomeScannerView extends StatefulWidget {
  const HomeScannerView({super.key});

  @override
  State<HomeScannerView> createState() => _HomeScannerViewState();
}

class _HomeScannerViewState extends State<HomeScannerView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppDimensions.ms),
            child: Column(
              children: [
                CommonQrScanner(
                  isScannedWithSuccess: true,
                  onDetect: (_) {},
                ),
              ],
            ),
          ),
        ),
      );
}
