import 'package:flutter/material.dart';
import 'package:work_out_app/config/app_colors.dart';
import 'package:work_out_app/data/local/app_database.dart';
import '../../config/di/injection_container.dart';
import '../../utils/helpers/snackbar_helper.dart';
import '../../widgets/custom_input_dialog.dart';

class ManageExerciseTypesPage extends StatefulWidget {
  const ManageExerciseTypesPage({super.key});

  @override
  State<ManageExerciseTypesPage> createState() =>
      _ManageExerciseTypesPageState();
}

class _ManageExerciseTypesPageState extends State<ManageExerciseTypesPage> {
  late final AppDatabase db;
  late final ValueNotifier<List<ExerciseType>> exerciseTypesNotifier;

  @override
  void initState() {
    super.initState();
    db = sl<AppDatabase>();
    exerciseTypesNotifier = ValueNotifier([]);
    _loadExerciseTypes();
  }

  Future<void> _loadExerciseTypes() async {
    final types = await db.getAllExerciseTypes();
    exerciseTypesNotifier.value = types;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Exercise Types')),
      body: ValueListenableBuilder<List<ExerciseType>>(
        valueListenable: exerciseTypesNotifier,
        builder: (context, types, _) {
          if (types.isEmpty) {
            return const Center(child: Text('No exercise types found.'));
          }
          return ListView.builder(
            itemCount: types.length,
            itemBuilder: (_, index) => _buildExerciseTypeTile(types[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddExerciseTypeDialog,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Icons.add, color: AppColors.whiteColor),
        label: Text('Add Exercise',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.whiteColor)),
      ),
    );
  }

  Widget _buildExerciseTypeTile(ExerciseType type) {
    return Card(
      elevation: 4,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).primaryColor.withValues(alpha: 0.15),
          child: const Icon(Icons.fitness_center),
        ),
        title: Text(type.name, style: Theme.of(context).textTheme.titleMedium),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Edit',
              onPressed: () => _showEditExerciseTypeDialog(type),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip:
                  type.isDefault == true ? 'Cannot delete default' : 'Delete',
              onPressed: () => _showDeleteExerciseTypeDialog(type),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExerciseTypeDialog() {
    showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Add Exercise Type',
        hintText: 'Exercise Name',
        confirmText: 'Add',
        onConfirm: (name) async {
          await db.addExerciseType(name, "fitness_center");
          await _loadExerciseTypes();
          if (mounted) {
            Navigator.pop(context);
            SnackbarHelper.showSuccessSnackbar(message: 'Exercise type added!');
          }
        },
      ),
    );
  }

  void _showEditExerciseTypeDialog(ExerciseType type) {
    showDialog(
      context: context,
      builder: (_) => CustomInputDialog(
        title: 'Edit Exercise Type',
        hintText: 'Exercise Name',
        confirmText: 'Save',
        initialValue: type.name,
        onConfirm: (newName) async {
          await db.updateExerciseType(type.id, newName, type.icon);
          await _loadExerciseTypes();
          if (mounted) {
            Navigator.pop(context);
            SnackbarHelper.showSuccessSnackbar(
                message: 'Exercise type updated!');
          }
        },
      ),
    );
  }

  void _showDeleteExerciseTypeDialog(ExerciseType type) {
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
                await db.deleteExerciseType(type.id);
                await _loadExerciseTypes();

                if (mounted) {
                  Navigator.of(context).pop();
                  SnackbarHelper.showSuccessSnackbar(
                      message: 'Deleted "${type.name}"');
                }
              } catch (_) {
                if (mounted) {
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
