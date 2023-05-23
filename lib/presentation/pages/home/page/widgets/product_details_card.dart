import 'package:collection/collection.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/generated/assets/assets.gen.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/product.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_duration.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class ProductDetailsCard extends StatelessWidget with ExtensionMixin {
  const ProductDetailsCard({
    super.key,
    required Product? product,
    required VoidCallback clearScannedProduct,
  })  : _product = product,
        _clearScannedProduct = clearScannedProduct;

  final Product? _product;
  final VoidCallback _clearScannedProduct;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: AppDuration.fast,
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width,
        child: _productCard(context),
      );

  Widget _productCard(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.getColors().primaryWhite,
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_product != null) ...[
              _nameHeader(context),
              SizedBox(height: AppDimensions.xm),
              _productProperties(context),
            ],
          ],
        ),
      );

  Widget _nameHeader(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.getColors().tertiaryGrey,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppRadius.m)),
          boxShadow: [
            BoxShadow(
              color: context.getColors().secondaryBlack25,
              blurRadius: AppDimensions.xxs,
              offset: Offset(0, AppDimensions.xxs),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.ms,
            vertical: AppDimensions.xm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _product?.name ?? '',
                style: AppTypography.header2,
              ),
              Material(
                borderRadius: BorderRadius.circular(AppRadius.m),
                child: InkWell(
                  onTap: _clearScannedProduct,
                  borderRadius: BorderRadius.circular(AppRadius.m),
                  child: Assets.icons.close.svg(),
                ),
              )
            ],
          ),
        ),
      );

  Widget _productProperties(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.ms),
        child: Column(
          children: [
            context.l10n.qrScannerScannedProductIdHeaderText,
            context.l10n.qrScannerScannedProductVendorHeaderText,
            if (_product?.location.shelfNumber != null)
              context.l10n.qrScannerScannedProductLocationCurrentHeaderText
            else
              context.l10n.qrScannerScannedProductTakenByHeaderText,
          ]
              .mapIndexed(
                (index, element) => _propertyHeader(
                  context,
                  element,
                  [
                    _product?.id,
                    _product?.manufacturer,
                    _product?.location.toString(),
                  ][index],
                ),
              )
              .toList(),
        ),
      );

  Widget _propertyHeader(
    BuildContext context,
    String headerText,
    String? value,
  ) =>
      Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.xm),
        child: Row(
          children: [
            Expanded(child: Text(headerText, style: AppTypography.body1)),
            Expanded(child: Text(value ?? '', style: AppTypography.body2)),
          ],
        ),
      );
}
