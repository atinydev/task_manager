import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


import 'task_view_controller.dart';
import 'current_task_controller.dart';
import 'date_controller.dart';
import 'validation_controller.dart';

class TaskCreateEditScreen extends HookConsumerWidget {
  const TaskCreateEditScreen({
    Key? key,
  }) : super(key: key);

  static const name = 'Name';
  static const path = 'path';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(currentTaskProvider);
    final date = ref.watch(dateProvider);
    final titleController = useTextEditingController(
      text: task?.title,
    );
    final descriptionController = useTextEditingController(
      text: task?.description,
    );
    final commentsController = useTextEditingController(
      text: task?.comments,
    );
    final tagsController = useTextEditingController(
      text: task?.tags?.toJoinByComma(),
    );

    void clearControllersData() {
      titleController.clear();
      descriptionController.clear();
      commentsController.clear();
      tagsController.clear();
      ref.read(dateProvider.notifier).clear();
      ref.read(currentTaskProvider.notifier).clear();
    }

    Future<bool> saveDataAndReturn() async {
      {
        if (task != null) {
          if (ValidatorController.formKey.currentState!.validate()) {
            ref.read(taskViewController).update(
                  id: task.id!,
                  isComplete: task.isComplete,
                  title: titleController.text,
                  description: descriptionController.text,
                  comments: commentsController.text,
                  tags: tagsController.text,
                  date: date,
                );
            clearControllersData();
            return true;
          } else {
            return false;
          }
        }
        if (titleController.text.isEmpty) {
          clearControllersData();
          return true;
        }
        ref.read(taskViewController).create(
              title: titleController.text,
              description: descriptionController.text,
              comments: commentsController.text,
              tags: tagsController.text,
              date: date,
            );
        clearControllersData();
        return true;
      }
    }

    return WillPopScope(
      onWillPop: saveDataAndReturn,
      child: Scaffold(
        appBar: AppBar(
          title: (task?.title == null) ? const Text("New task") : null,
          actions: [
            IconButton(
              onPressed: () {
                if (task != null) {
                  context.pop();
                  ref.read(taskViewController).remove(target: task);
                }
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: ValidatorController.formKey,
              child: Column(
                children: [
                  _TitleField(
                    textController: titleController,
                  ),
                  _DescriptionField(
                    textController: descriptionController,
                  ),
                  _DateField(
                    date: date,
                  ),
                  _CommentsField(
                    textController: commentsController,
                  ),
                  _TagsField(
                    textController: tagsController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends HookConsumerWidget {
  const _TitleField({
    required this.textController,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      validator: ValidatorController.checkStringNull,
      controller: textController,
      cursorColor: Theme.of(context).colorScheme.primary,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      decoration: const InputDecoration(
        hintText: 'Enter a title',
        hintStyle: TextStyle(fontSize: 20),
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}

class _DescriptionField extends StatelessWidget {
  const _DescriptionField({
    required this.textController,
    Key? key,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.description),
        Expanded(
          child: TextFormField(
            controller: textController,
            cursorColor: Theme.of(context).colorScheme.primary,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
        ),
      ],
    );
  }
}

class _DateField extends ConsumerWidget {
  const _DateField({
    Key? key,
    this.date,
  }) : super(key: key);

  final DateTime? date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final newDate = await showDatePicker(
          context: context,
          initialDate: date ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 50),
        );
        FocusScope.of(context).unfocus();
        ref.read(dateProvider.notifier).updateState(newDate);
      },
      child: Row(
        children: [
          const Icon(Icons.date_range),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 12,
              ),
              child: Text(
                (date == null) ? 'Add date' : date!.toDateFormat(),
                style: TextStyle(
                  fontSize: 16,
                  color: (date == null)
                      ? const Color(0x99ffffff)
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentsField extends StatelessWidget {
  const _CommentsField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.comment),
        Expanded(
          child: TextFormField(
            controller: textController,
            cursorColor: Theme.of(context).colorScheme.primary,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.sentences,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Comments',
            ),
          ),
        ),
      ],
    );
  }
}

class _TagsField extends StatelessWidget {
  const _TagsField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.tag),
        Expanded(
          child: TextFormField(
            validator: ValidatorController.checkTags,
            controller: textController,
            textCapitalization: TextCapitalization.words,
            cursorColor: Theme.of(context).colorScheme.primary,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
              hintText: 'Tags',
            ),
          ),
        ),
      ],
    );
  }
}
