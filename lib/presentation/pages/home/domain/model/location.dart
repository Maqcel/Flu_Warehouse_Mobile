import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({
    required this.id,
    this.rackNumber,
    this.shelfNumber,
    this.firstName,
    this.lastName,
  });

  final String id;
  final String? rackNumber;
  final String? shelfNumber;
  final String? firstName;
  final String? lastName;

  @override
  String toString() => shelfNumber != null && rackNumber != null
      ? 'At $shelfNumber/$rackNumber'
      : 'At $firstName $lastName';

  @override
  List<Object?> get props => [
        id,
        rackNumber,
        shelfNumber,
        firstName,
        lastName,
      ];
}
