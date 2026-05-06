class Step {
  final int index;
  final String instruction;
  final int? duration;

  const Step({
    required this.index,
    required this.instruction,
    this.duration,
  });
}
