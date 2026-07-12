import 'package:equatable/equatable.dart';


class YieldPointModel extends Equatable {
  final String label; // e.g. month abbreviation
  final double valueKg;

  const YieldPointModel({required this.label, required this.valueKg});

  @override
  List<Object?> get props => [label, valueKg];
}
