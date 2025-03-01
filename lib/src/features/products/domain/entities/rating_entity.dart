import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final double rate;
  final int count;

  RatingEntity({
    required this.rate,
    required this.count,
  });

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
