import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/tokens/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/ingredient.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/step.dart';
import '../providers/recipe_provider.dart';
import '../widgets/ingredient_sheet.dart';
import '../widgets/recipe_editor_body.dart';
import '../widgets/step_sheet.dart';
import '../widgets/unit_label.dart';

class RecipeEditorPage extends ConsumerStatefulWidget {
  final Recipe? recipe;

  const RecipeEditorPage({super.key, this.recipe});

  @override
  ConsumerState<RecipeEditorPage> createState() => _RecipeEditorPageState();
}

class _RecipeEditorPageState extends ConsumerState<RecipeEditorPage> {
  static const _unitOptions = [
    'g',
    'kg',
    'ml',
    'l',
    'pcs',
    'tbsp',
    'tsp',
    'cup',
  ];

  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();

  var _servings = 1;
  List<Ingredient> ingredients = [];
  List<Step> steps = [];

  @override
  void initState() {
    super.initState();
    final r = widget.recipe;
    if (r != null) {
      _title.text = r.title;
      _desc.text = r.description;
      _servings = r.servings;
      ingredients = List.from(r.ingredients);
      steps = normalizedSteps(r.steps);
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _openIngredientSheet(AppLocalizations t, [int? index]) async {
    final ingredient = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => IngredientSheet(
        t: t,
        unitOptions: _unitOptions,
        ingredient: index == null ? null : ingredients[index],
      ),
    );

    if (!mounted || ingredient == null) return;
    setState(() {
      final updated = [...ingredients];
      if (index == null) {
        updated.add(ingredient);
      } else {
        updated[index] = ingredient;
      }
      ingredients = updated;
    });
  }

  Future<void> _openStepSheet(AppLocalizations t, [int? index]) async {
    final step = await showModalBottomSheet<Step>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) => StepSheet(
        t: t,
        index: index ?? steps.length,
        step: index == null ? null : steps[index],
      ),
    );

    if (!mounted || step == null) return;
    setState(() {
      final updated = [...steps];
      if (index == null) {
        updated.add(step);
      } else {
        updated[index] = step;
      }
      steps = normalizedSteps(updated);
    });
  }

  Future<void> _saveRecipe(AppLocalizations t, String authorId) async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) return;

    final validationError = _recipeValidationError(t);
    if (validationError != null) {
      _showSnackBar(validationError);
      return;
    }

    final existing = widget.recipe;
    final existingAuthorId = existing?.authorId;
    final recipe = Recipe(
      id: existing?.id ?? '',
      title: _title.text.trim(),
      description: _desc.text.trim(),
      ingredients: List.unmodifiable(ingredients),
      steps: List.unmodifiable(normalizedSteps(steps)),
      authorId: existingAuthorId != null && existingAuthorId.isNotEmpty
          ? existingAuthorId
          : authorId,
      createdAt: existing?.createdAt ?? DateTime.now(),
      servings: _servings,
      sourceType: existing?.sourceType ?? 'manual',
    );

    final controller = ref.read(recipeControllerProvider.notifier);

    if (existing == null) {
      final id = await controller.create(recipe);
      if (!mounted) return;

      if (id == null) {
        _showSnackBar(t.errorSomethingWentWrong);
        return;
      }

      _showSnackBar(t.recipeSaved);
      context.pushReplacement(RouteNames.recipeDetailPath(id));
      return;
    }

    await controller.update(recipe);
    if (!mounted) return;

    final failed = ref
        .read(recipeControllerProvider)
        .maybeWhen(error: (_, _) => true, orElse: () => false);
    if (failed) {
      _showSnackBar(t.errorSomethingWentWrong);
      return;
    }

    _showSnackBar(t.recipeUpdated);
    context.pop();
  }

  String? _recipeValidationError(AppLocalizations t) {
    if (_title.text.trim().isEmpty) return t.errorEmptyTitle;
    if (ingredients.isEmpty) return t.errorEmptyIngredients;
    if (steps.isEmpty) return t.errorEmptySteps;
    return null;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _removeIngredient(int index) {
    setState(() => ingredients = [...ingredients]..removeAt(index));
  }

  void _removeStep(int index) {
    final updated = [...steps]..removeAt(index);
    setState(() => steps = normalizedSteps(updated));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final user = ref.watch(authStateProvider);
    final isSaving = ref.watch(
      recipeControllerProvider.select((s) => s.isLoading),
    );

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.createRecipe)),
        body: Center(child: Text(t.notAuthenticated)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? t.createRecipe : t.editRecipe),
        actions: [
          TextButton(
            onPressed: isSaving ? null : () => _saveRecipe(t, user.id),
            child: isSaving
                ? const SizedBox.square(
                    dimension: AppSpacing.lg,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(t.saveRecipe),
          ),
        ],
      ),
      body: SafeArea(
        child: RecipeEditorBody(
          formKey: _formKey,
          titleController: _title,
          descController: _desc,
          servings: _servings,
          ingredients: ingredients,
          steps: steps,
          isSaving: isSaving,
          unitOptions: _unitOptions,
          onServingsChanged: (v) => setState(() => _servings = v),
          onAddIngredient: () => _openIngredientSheet(t),
          onAddStep: () => _openStepSheet(t),
          onRemoveIngredient: _removeIngredient,
          onRemoveStep: _removeStep,
          onEditIngredient: (index) => _openIngredientSheet(t, index),
          onEditStep: (index) => _openStepSheet(t, index),
        ),
      ),
    );
  }
}
