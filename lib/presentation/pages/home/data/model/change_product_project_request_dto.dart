import 'package:json_annotation/json_annotation.dart';

part 'change_product_project_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class ChangeProductProjectRequestDto {
  ChangeProductProjectRequestDto({
    required this.productID,
    required this.projectID,
  });

  final String productID;
  final String projectID;

  Map<String, dynamic> toJson() => _$ChangeProductProjectRequestDtoToJson(this);
}
