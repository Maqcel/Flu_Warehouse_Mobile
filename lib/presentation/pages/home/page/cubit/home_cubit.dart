import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/actions_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/edit_action_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.scannerEntry());

  void changeHomeScreen(
    ActionsEnum action, {
    EditActionEnum? editAction,
  }) {
    switch (action) {
      case ActionsEnum.scannedWithSuccess:
        return emit(const HomeState.scannerEntry(showDialog: true));
      case ActionsEnum.scannerEntry:
        return emit(const HomeState.scannerEntry());
      case ActionsEnum.scannerReturn:
        return emit(
          HomeState.scanningProduct(
            isReturnMode: true,
            editAction: editAction ?? EditActionEnum.location,
          ),
        );
      case ActionsEnum.scannerTake:
        return emit(
          HomeState.scanningProduct(
            isReturnMode: false,
            editAction: editAction ?? EditActionEnum.location,
          ),
        );
    }
  }
}
