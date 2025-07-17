import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/local/app_database.dart';
import 'package:work_out_app/providers/exercise_type_provider.dart';
import '../../utils/helpers/snackbar_helper.dart';
import '../../widgets/custom_input_dialog.dart';

class ManageExerciseTypesPage extends StatelessWidget {
  const ManageExerciseTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExerciseTypeProvider>();
    final types = provider.exerciseTypes;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Exercise Types')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Center(
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Here you can add, rename, or delete your own exercise types.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: types.isEmpty
                ? const Center(child: Text('No exercise types found.'))
                : ListView.builder(
              itemCount: types.length,
              itemBuilder: (_, index) => _buildExerciseTypeTile(context, provider, types[index]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExerciseTypeDialog(context, provider),
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: AppColors.whiteColor),
        label: Text('Add Exercise',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.whiteColor)),
      ),
    );
  }

  Widget _buildExerciseTypeTile(BuildContext context, ExerciseTypeProvider provider, ExerciseType type) {
    return Card(
      elevation: 4,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.15),
          child: const Icon(Icons.fitness_center),
        ),
        title: Text(type.name, style: Theme.of(context).textTheme.titleMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: () => _showEditExerciseTypeDialog(context, provider, type),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: type.isDefault == true ? 'Cannot delete default' : 'Delete',
              onPressed: () => _showDeleteExerciseTypeDialog(context, provider, type),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExerciseTypeDialog(BuildContext context, ExerciseTypeProvider provider) {
    showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Add Exercise Type',
        hintText: 'Exercise Name',
        confirmText: 'Add',
        onConfirm: (name) async {
          await provider.addExerciseType(name, "fitness_center");
          if (context.mounted) {
            Navigator.pop(context);
            SnackbarHelper.showSuccessSnackbar(message: 'Exercise type added!');
          }
        },
      ),
    );
  }

  void _showEditExerciseTypeDialog(
      BuildContext context, ExerciseTypeProvider provider, ExerciseType type) {
    showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Edit Exercise Type',
        hintText: 'Exercise Name',
        confirmText: 'Save',
        initialValue: type.name,
        onConfirm: (newName) async {
          await provider.editExerciseType(type.id, newName, type.icon);
          if (context.mounted) {
            Navigator.pop(context);
            SnackbarHelper.showSuccessSnackbar(message: 'Exercise type updated!');
          }
        },
      ),
    );
  }

  void _showDeleteExerciseTypeDialog(
      BuildContext context, ExerciseTypeProvider provider, ExerciseType type) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Exercise Type'),
        content: Text(
            'Are you sure you want to delete "${type.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              try {
                await provider.deleteExerciseType(type.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                  SnackbarHelper.showSuccessSnackbar(
                      message: 'Deleted "${type.name}"');
                }
              } catch (_) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                  SnackbarHelper.showSuccessSnackbar(
                      message: 'Cannot delete default exercise type');
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}