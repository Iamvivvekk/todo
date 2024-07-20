import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/core/model/todomodel.dart';
import 'package:todo/core/test_styles.dart';
import 'package:todo/core/widgets/vertical_spacer.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/themes.dart';

class AddNewTodo extends ConsumerStatefulWidget {
  const AddNewTodo({super.key, this.id, this.description, this.title});
  final String? id;
  final String? title;
  final String? description;

  @override
  ConsumerState<AddNewTodo> createState() => _AddNewTodoState();
}

class _AddNewTodoState extends ConsumerState<AddNewTodo> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.title != null && widget.description != null) {
      _titleController.text = widget.title!;
      _descriptionController.text = widget.description!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '''A D D''',
                              style: boldText(
                                  fontSize: 22,
                                  fontColor: AppTheme.whiteColor)),
                          TextSpan(
                              text: '''   N E W   ''',
                              style: boldText(
                                  fontSize: 22, fontColor: AppTheme.blueColor)),
                          TextSpan(
                              text: '''T O D O''',
                              style: boldText(
                                  fontSize: 22,
                                  fontColor: AppTheme.whiteColor)),
                        ]),
                      ),
                      const VerticalSpacer(height: 50),
                      Text(
                        'TITLE',
                        style: mediumBoldText(
                            fontSize: 18, fontColor: AppTheme.whiteColor),
                      ),
                      const VerticalSpacer(),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: textfieldStyle(fontSize: 18),
                        controller: _titleController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          hintText: "TODO TITLE",
                          hintStyle: textFieldHintStyle(),
                          filled: true,
                          fillColor: AppTheme.whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Field cannot be empty';
                          }

                          if (value.length < 3) {
                            return 'Title must have atleast 3 characters';
                          }
                          return null;
                        },
                        maxLines: 1,
                      ),
                      const VerticalSpacer(height: 22),
                      Text(
                        'DESCRIPTION',
                        style: mediumBoldText(
                            fontSize: 18, fontColor: AppTheme.whiteColor),
                      ),
                      const VerticalSpacer(),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        style: textfieldStyle(fontSize: 18),
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          hintText: "TODO DESCRIPTION",
                          hintStyle: textFieldHintStyle(),
                          filled: true,
                          fillColor: AppTheme.whiteColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          if (value.length < 5) {
                            return 'Description must have atleast 5 characters';
                          }
                          return null;
                        },
                        maxLines: 7,
                      ),
                      const VerticalSpacer(height: 22),
                      SizedBox(
                          width: double.infinity,
                          child: (widget.title != null &&
                                  widget.description != null)
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.redColor,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  AppTheme.lightBlackColor,
                                              content: const Text(
                                                  'Are you sure want to delete ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _titleController.clear();
                                                    _descriptionController
                                                        .clear();
                                                    deleteTodo(ref, widget.id!);
                                                    Navigator.of(context).pop();
                                                    return ref.refresh(
                                                        todoDataProvider);
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: Text(
                                    "Delete",
                                    style: mediumBoldText(
                                        fontColor: AppTheme.whiteColor),
                                  ),
                                )
                              : const SizedBox())
                    ],
                  ),
                ),
                Positioned(
                  top: 32,
                  left: 5,
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (widget.title != null &&
                              widget.description != null) {
                            updateTodo(
                              widget.id!,
                              Todomodel(
                                title: _titleController.text,
                                description: _descriptionController.text,
                              ),
                            );
                            Navigator.of(context).pop();
                          } else {
                            submitTodo();
                          }
                        },
                        icon: Icon(
                          Icons.check_circle,
                          size: 35,
                          color: AppTheme.greenColor,
                        ),
                      ),
                      Text(
                        (widget.title != null && widget.description != null)
                            ? "Update"
                            : "Finish",
                        style: boldText(
                            fontColor: AppTheme.greenColor, fontSize: 18),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addTodo() async {
    await ref.read(todoControllerProvider).insertTodo(
          Todomodel(
            title: _titleController.text,
            description: _descriptionController.text,
          ),
        );
  }

  void submitTodo() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      addTodo();
      Navigator.of(context).pop();
      return ref.refresh(todoDataProvider);
    }
  }

  /// Update todo is not working try to solvve this issue

  void updateTodo(String id, Todomodel todo) async {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      print(isValid);
      await ref.read(todoControllerProvider).update(id, todo);
      return ref.invalidate(todoDataProvider);
    }
  }

  Future<void> deleteTodo(WidgetRef ref, String id) async {
    await ref.read(todoControllerProvider).deleteTodo(id);
  }
}
