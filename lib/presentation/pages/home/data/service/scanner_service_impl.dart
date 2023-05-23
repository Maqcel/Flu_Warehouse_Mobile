import 'package:flu_warehouse_mobile/app/networking/handle_api_exceptions.dart';
import 'package:flu_warehouse_mobile/app/networking/result.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/data_source/scanner_service_api_data_source.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/change_product_project_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/success_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/take_product_by_user_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/transfer_product_location_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/service/scanner_service.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ScannerService)
class ScannerServiceImpl implements ScannerService {
  ScannerServiceImpl({
    required ScannerServiceApiDataSource dataSource,
  }) : _dataSource = dataSource;

  final ScannerServiceApiDataSource _dataSource;

  @override
  Future<Result<GetProductResponseDto>> getProductData(String productId) =>
      _dataSource
          .getProductData(productId)
          .then(Result<GetProductResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<GetProductResponseDto>);

  @override
  Future<Result<SuccessResponseDto>> changeProductLocation(
    String productID,
    String locationID,
  ) =>
      _dataSource
          .changeProductLocation(
            TransferProductLocationRequestDto(
              productID: productID,
              locationID: locationID,
            ),
          )
          .then(Result<SuccessResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<SuccessResponseDto>);

  @override
  Future<Result<SuccessResponseDto>> changeProductProject(
    String productID,
    String projectID,
  ) =>
      _dataSource
          .changeProductProject(
            ChangeProductProjectRequestDto(
              productID: productID,
              projectID: projectID,
            ),
          )
          .then(Result<SuccessResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<SuccessResponseDto>);

  @override
  Future<Result<SuccessResponseDto>> takeProductFromShelf(
    String productID,
    String userID,
  ) =>
      _dataSource
          .takeProductFromShelf(
            TakeProductByUserRequestDto(
              productID: productID,
              userID: userID,
            ),
          )
          .then(Result<SuccessResponseDto>.success)
          .catchError(HandleApiExceptions.handleError<SuccessResponseDto>);
}
