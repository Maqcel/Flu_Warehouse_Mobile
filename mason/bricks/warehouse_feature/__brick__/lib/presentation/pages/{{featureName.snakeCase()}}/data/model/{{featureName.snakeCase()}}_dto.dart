import 'package:json_annotation/json_annotation.dart';

part '{{featureName.snakeCase()}}_dto.g.dart';

@JsonSerializable(createToJson: false)
class {{featureName.pascalCase()}}Dto {
  {{featureName.pascalCase()}}Dto({
    required this.id,
  });
  
  factory {{featureName.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) => _${{featureName.pascalCase()}}DtoFromJson(json);

  String id;
}
