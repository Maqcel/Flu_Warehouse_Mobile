import 'package:dio/dio.dart';
import 'package:flu_warehouse_mobile/app/networking/networking_endpoints.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/change_product_project_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/get_product_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/success_response_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/take_product_by_user_request_dto.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/data/model/transfer_product_location_request_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'scanner_service_api_data_source.g.dart';

@injectable
@RestApi()
abstract class ScannerServiceApiDataSource {
  @factoryMethod
  factory ScannerServiceApiDataSource(Dio dio) = _ScannerServiceApiDataSource;

  @GET(NetworkingEndpoints.getProduct)
  Future<GetProductResponseDto> getProductData(@Path() String productId);

  @POST(NetworkingEndpoints.changeProductLocation)
  Future<SuccessResponseDto> changeProductLocation(
    @Body() TransferProductLocationRequestDto requestDto,
  );

  @POST(NetworkingEndpoints.changeProductProject)
  Future<SuccessResponseDto> changeProductProject(
    @Body() ChangeProductProjectRequestDto requestDto,
  );

  @POST(NetworkingEndpoints.takeProductFromShelf)
  Future<SuccessResponseDto> takeProductFromShelf(
    @Body() TakeProductByUserRequestDto requestDto,
  );
}
