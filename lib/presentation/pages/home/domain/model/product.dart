import 'package:equatable/equatable.dart';
import 'package:flu_warehouse_mobile/presentation/pages/home/domain/model/location.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.manufacturer,
    required this.supplier,
    required this.serialNumber,
    required this.location,
  });

  final String id;
  final String name;
  final String category;
  final String manufacturer;
  final String supplier;
  final String serialNumber;
  final Location location;

  @override
  List<Object> get props => [
        id,
        name,
        category,
        manufacturer,
        supplier,
        serialNumber,
        location,
      ];
}
