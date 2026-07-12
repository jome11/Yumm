import 'package:equatable/equatable.dart';

class ApiaryEfficiencyModel extends Equatable {
  final String name;
  final double yieldKg;
  final double ratio; // 0..1, relative efficiency bar fill

  const ApiaryEfficiencyModel({
    required this.name,
    required this.yieldKg,
    required this.ratio,
  });

  @override
  List<Object?> get props => [name, yieldKg, ratio];
}
