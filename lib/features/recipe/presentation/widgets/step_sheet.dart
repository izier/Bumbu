import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;

import '../../../../../app/theme/tokens/app_spacing.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/step.dart';

class StepSheet extends StatefulWidget {
  final AppLocalizations t;
  final int index;
  final Step? step;

  const StepSheet({super.key, required this.t, required this.index, this.step});

  @override
  State<StepSheet> createState() => _StepSheetState();
}

class _StepSheetState extends State<StepSheet> {
  static const _maxDuration = Duration(days: 1);

  final _formKey = GlobalKey<FormState>();
  final _instruction = TextEditingController();
  late final FixedExtentScrollController _dayController;
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;
  late final FixedExtentScrollController _secondController;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    final step = widget.step;
    if (step != null) {
      _instruction.text = step.instruction;
      _duration = Duration(seconds: step.duration ?? 0);
      if (_duration > _maxDuration) _duration = _maxDuration;
    }
    _initPickerControllers();
  }

  void _initPickerControllers() {
    final days = _duration.inDays;
    final hours = _duration.inHours % 24;
    final minutes = _duration.inMinutes % 60;
    final seconds = _duration.inSeconds % 60;
    _dayController = FixedExtentScrollController(initialItem: days);
    _hourController = FixedExtentScrollController(initialItem: hours);
    _minuteController = FixedExtentScrollController(initialItem: minutes);
    _secondController = FixedExtentScrollController(initialItem: seconds);
  }

  @override
  void dispose() {
    _instruction.dispose();
    _dayController.dispose();
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _setDuration({int? days, int? hours, int? minutes, int? seconds}) {
    final currentDays = days ?? _duration.inDays;
    final currentHours = hours ?? _duration.inHours % 24;
    final currentMinutes = minutes ?? _duration.inMinutes % 60;
    final currentSeconds = seconds ?? _duration.inSeconds % 60;
    var next = Duration(
      days: currentDays,
      hours: currentHours,
      minutes: currentMinutes,
      seconds: currentSeconds,
    );

    if (next > _maxDuration) {
      next = _maxDuration;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _dayController.jumpToItem(1);
        _hourController.jumpToItem(0);
        _minuteController.jumpToItem(0);
        _secondController.jumpToItem(0);
      });
    }

    setState(() => _duration = next);
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    Navigator.of(context).pop(
      Step(
        index: widget.index,
        instruction: _instruction.text.trim(),
        duration: _duration.inSeconds == 0 ? null : _duration.inSeconds,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.t;
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.base,
        AppSpacing.screenPadding,
        AppSpacing.screenPadding + viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.step == null ? t.addStep : t.editStep,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.base),
            TextFormField(
              controller: _instruction,
              autofocus: true,
              maxLines: 3,
              decoration: InputDecoration(labelText: t.instruction),
              validator: (value) => value == null || value.trim().isEmpty
                  ? t.errorEmptyInstruction
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              t.durationSeconds,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppSpacing.md),
              ),
              child: SizedBox(
                height: 168,
                child: Row(
                  children: [
                    _TimerColumn(
                      controller: _dayController,
                      itemCount: 2,
                      label: 'd',
                      onSelectedItemChanged: (value) =>
                          _setDuration(days: value),
                    ),
                    _TimerColumn(
                      controller: _hourController,
                      itemCount: 24,
                      label: 'h',
                      onSelectedItemChanged: (value) =>
                          _setDuration(hours: value),
                    ),
                    _TimerColumn(
                      controller: _minuteController,
                      itemCount: 60,
                      label: 'm',
                      onSelectedItemChanged: (value) =>
                          _setDuration(minutes: value),
                    ),
                    _TimerColumn(
                      controller: _secondController,
                      itemCount: 60,
                      label: 's',
                      onSelectedItemChanged: (value) =>
                          _setDuration(seconds: value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(t.cancel),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text(widget.step == null ? t.addStep : t.saveStep),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerColumn extends StatelessWidget {
  final FixedExtentScrollController controller;
  final int itemCount;
  final String label;
  final ValueChanged<int> onSelectedItemChanged;

  const _TimerColumn({
    required this.controller,
    required this.itemCount,
    required this.label,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoPicker.builder(
        scrollController: controller,
        itemExtent: 36,
        magnification: 1.08,
        useMagnifier: true,
        onSelectedItemChanged: onSelectedItemChanged,
        childCount: itemCount,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              '$index $label',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        },
      ),
    );
  }
}
