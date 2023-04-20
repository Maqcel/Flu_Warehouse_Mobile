import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/actions_enum.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/page/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.scannerEntry());

  void changeHomeScreen(ActionsEnum action) {
    switch (action) {
      case ActionsEnum.scannerEntry:
        return emit(const HomeState.scannerEntry());
      case ActionsEnum.scannerReturn:
        return emit(const HomeState.scanningProduct(isReturnMode: true));
      case ActionsEnum.scannerTake:
        return emit(const HomeState.scanningProduct(isReturnMode: false));
    }
  }
}
