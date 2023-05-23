import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/generated/assets/assets.gen.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';
import 'package:flu_warehouse_mobile/style/app_dimensions.dart';
import 'package:flu_warehouse_mobile/style/app_duration.dart';
import 'package:flu_warehouse_mobile/style/app_radius.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flutter/material.dart';

class LocationDetailsCard extends StatelessWidget with ExtensionMixin {
  const LocationDetailsCard({
    super.key,
    required String productName,
    required String currentLocation,
    required Location? location,
    required VoidCallback clearScannedLocation,
  })  : _productName = productName,
        _currentLocation = currentLocation,
        _location = location,
        _clearScannedLocation = clearScannedLocation;

  final String _productName;
  final String _currentLocation;
  final Location? _location;
  final VoidCallback _clearScannedLocation;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: AppDuration.fast,
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width,
        child: _locationCard(context),
      );

  Widget _locationCard(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: context.getColors().primaryWhite,
          borderRadius: BorderRadius.circular(AppRadius.m),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _nameHeader(context),
            SizedBox(height: AppDimensions.xm),
            _locationProperties(context),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _productName,
                    style: AppTypography.body2.copyWith(
                      color: context.getColors().primaryGrey,
                    ),
                  ),
                  Text(
                    context.l10n.qrScannerScannedProductEditLocationButtonText,
                    style: AppTypography.header2,
                  ),
                ],
              ),
              Material(
                borderRadius: BorderRadius.circular(AppRadius.m),
                child: InkWell(
                  onTap: _clearScannedLocation,
                  borderRadius: BorderRadius.circular(AppRadius.m),
                  child: Assets.icons.close.svg(),
                ),
              )
            ],
          ),
        ),
      );

  Widget _locationProperties(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.ms),
        child: Column(
          children: [
            Text(
              context.l10n.editLocationCurrentHeaderText,
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.bold,
                color: context.getColors().primaryGrey,
              ),
            ),
            Text(
              _currentLocation,
              style: AppTypography.body1.copyWith(
                color: context.getColors().primaryGrey,
              ),
            ),
            SizedBox(height: AppDimensions.m),
            Text(
              context.l10n.editLocationNewHeaderText,
              style: AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              _location?.id ?? '-',
              style: AppTypography.body1.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppDimensions.m),
          ],
        ),
      );
}
