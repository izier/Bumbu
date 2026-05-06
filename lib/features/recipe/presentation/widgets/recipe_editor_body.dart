import 'package:flutter/material.dart' hide Step;

import '../../../../../app/theme/tokens/app_spacing.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../domain/entities/ingredient.dart';
import '../../domain/entities/step.dart';
import 'editor_list_items.dart';
import 'editor_section_header.dart';

class RecipeEditorBody extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descController;
  final int servings;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final bool isSaving;
  final List<String> unitOptions;
  final ValueChanged<int> onServingsChanged;
  final VoidCallback onAddIngredient;
  final VoidCallback onAddStep;
  final ValueChanged<int> onRemoveIngredient;
  final ValueChanged<int> onRemoveStep;
  final ValueChanged<int> onEditIngredient;
  final ValueChanged<int> onEditStep;

  const RecipeEditorBody({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descController,
    required this.servings,
    required this.ingredients,
    required this.steps,
    required this.isSaving,
    required this.unitOptions,
    required this.onServingsChanged,
    required this.onAddIngredient,
    required this.onAddStep,
    required this.onRemoveIngredient,
    required this.onRemoveStep,
    required this.onEditIngredient,
    required this.onEditStep,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenPadding,
          AppSpacing.base,
          AppSpacing.screenPadding,
          AppSpacing.huge,
        ),
        children: [
          EditorSectionHeader(title: t.recipeBasics),
          const SizedBox(height: AppSpacing.base),
          TextFormField(
            controller: titleController,
            autofocus: true,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: t.recipeTitle),
            validator: (value) => value == null || value.trim().isEmpty
                ? t.errorEmptyTitle
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: descController,
            maxLines: 3,
            decoration: InputDecoration(labelText: t.description),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<int>(
            initialValue: servings,
            decoration: InputDecoration(labelText: t.servings),
            dropdownColor: Theme.of(context).colorScheme.surface,
            items: [
              for (var i = 1; i <= 12; i++)
                DropdownMenuItem(value: i, child: Text(i.toString())),
            ],
            onChanged: isSaving
                ? null
                : (value) {
                    if (value == null) return;
                    onServingsChanged(value);
                  },
          ),
          const SizedBox(height: AppSpacing.sectionSpacing),
          EditorSectionHeader(
            title: t.ingredients,
            count: ingredients.length,
            tooltip: t.addIngredient,
            onAdd: isSaving ? null : onAddIngredient,
          ),
          const SizedBox(height: AppSpacing.base),
          ...buildIngredientTiles(
            context: context,
            t: t,
            ingredients: ingredients,
            onRemove: onRemoveIngredient,
            onEdit: onEditIngredient,
          ),
          const SizedBox(height: AppSpacing.sectionSpacing),
          EditorSectionHeader(
            title: t.steps,
            count: steps.length,
            tooltip: t.addStep,
            onAdd: isSaving ? null : onAddStep,
          ),
          const SizedBox(height: AppSpacing.base),
          ...buildStepTiles(
            context: context,
            t: t,
            steps: steps,
            onRemove: onRemoveStep,
            onEdit: onEditStep,
          ),
        ],
      ),
    );
  }
}
