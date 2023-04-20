import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.scannerEntry() = HomeStateScannerEntry;

  const factory HomeState.scanningProduct({
    required bool isReturnMode,
  }) = HomeStateScanningProduct;

  const factory HomeState.localizationEdit({
    required bool isReturnMode,
  }) = HomeStateLocalizationEdit;
}
