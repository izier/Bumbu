import '../../domain/entities/step.dart';

class StepModel extends Step {
  const StepModel({
    required super.index,
    required super.instruction,
    super.duration,
  });

  factory StepModel.fromMap(Map<String, dynamic> map) {
    final index = map['index'];
    final duration = map['duration'];

    return StepModel(
      index: index is num ? index.toInt() : 0,
      instruction: map['instruction'] ?? '',
      duration: duration is num
          ? duration.toInt()
          : int.tryParse(duration?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {'index': index, 'instruction': instruction, 'duration': duration};
  }
}
