import 'package:json_annotation/json_annotation.dart';

part 'location_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class LocationResponseDto {
  LocationResponseDto({
    required this.id,
    required this.location,
    required this.name,
    required this.lastname,
  });

  factory LocationResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseDtoFromJson(json);

  @JsonKey(name: '_id')
  final String id;

  final String? name;

  final String? lastname;

  final LocationDtoWrapper? location;
}

@JsonSerializable(createToJson: false)
class LocationDtoWrapper {
  LocationDtoWrapper({
    required this.rack,
    required this.shelf,
  });

  factory LocationDtoWrapper.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoWrapperFromJson(json);

  final String rack;

  @JsonKey(name: 'shell')
  final String shelf;
}
