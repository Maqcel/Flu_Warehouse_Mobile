import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.scannerEntry({@Default(false) bool showDialog}) =
      HomeStateScannerEntry;

  const factory HomeState.scanningProduct({
    required bool isReturnMode,
    required EditActionEnum editAction,
  }) = HomeStateScanningProduct;
}
