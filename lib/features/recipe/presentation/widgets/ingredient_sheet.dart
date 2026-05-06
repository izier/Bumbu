import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../app/theme/tokens/app_spacing.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/ingredient.dart';
import 'unit_label.dart';

class IngredientSheet extends StatefulWidget {
  final AppLocalizations t;
  final List<String> unitOptions;
  final Ingredient? ingredient;

  const IngredientSheet({
    super.key,
    required this.t,
    required this.unitOptions,
    this.ingredient,
  });

  @override
  State<IngredientSheet> createState() => _IngredientSheetState();
}

class _IngredientSheetState extends State<IngredientSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  var _unit = 'g';

  @override
  void initState() {
    super.initState();
    final ingredient = widget.ingredient;
    if (ingredient == null) return;
    _name.text = ingredient.name;
    _quantity.text = ingredient.quantity.toString();
    _unit = ingredient.unit;
  }

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final name = _name.text.trim();
    final quantityText = _quantity.text.trim().replaceAll(',', '.');
    final quantity = double.parse(quantityText);
    final displayName = [quantityText, _unit, name].join(' ');

    Navigator.of(context).pop(
      Ingredient(
        id:
            widget.ingredient?.id ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        displayName: displayName,
        quantity: quantity,
        unit: _unit,
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
              widget.ingredient == null ? t.addIngredient : t.editIngredient,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.base),
            TextFormField(
              controller: _name,
              autofocus: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: t.ingredientName),
              validator: (value) => value == null || value.trim().isEmpty
                  ? t.errorEmptyIngredientName
                  : null,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _quantity,
              textInputAction: TextInputAction.next,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
              ],
              decoration: InputDecoration(labelText: t.quantity),
              validator: (value) {
                final parsed = double.tryParse(
                  (value ?? '').trim().replaceAll(',', '.'),
                );
                return parsed == null || parsed <= 0
                    ? t.errorInvalidQuantity
                    : null;
              },
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _unit,
              decoration: InputDecoration(labelText: t.unit),
              dropdownColor: Theme.of(context).colorScheme.surface,
              items: [
                for (final unit in widget.unitOptions)
                  DropdownMenuItem(
                    value: unit,
                    child: Text(unitLabel(t, unit)),
                  ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() => _unit = value);
              },
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
                    child: Text(
                      widget.ingredient == null
                          ? t.addIngredient
                          : t.saveIngredient,
                    ),
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
