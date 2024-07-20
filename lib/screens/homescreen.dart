import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/core/test_styles.dart';
import 'package:todo/core/widgets/vertical_spacer.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/screens/add_new_todo.dart';
import 'package:todo/themes.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(todoDataProvider);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: '''T O D O   ''',
                        style: boldText(
                            fontSize: 22, fontColor: AppTheme.whiteColor)),
                    TextSpan(
                        text: '''L I S T''',
                        style: boldText(
                            fontSize: 22, fontColor: AppTheme.blueColor))
                  ]),
                ),
              ),
              user.when(
                  data: (data) => Expanded(
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final date = data[index].time;
                            return data.isEmpty
                                ? Center(
                                    child: Text(
                                      "hello",
                                      style: normalWhiteText(),
                                    ),
                                  )
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 12.0),
                                    width: double.infinity,
                                    // height:75,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: AppTheme.whiteColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle_outline,
                                                color: AppTheme.greenColor,
                                                size: 22),
                                            const HorizontalSpacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${data[index].title[0].toUpperCase()}${data[index].title.substring(1).toLowerCase()}",
                                                  style: boldText(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.64,
                                                  child: Text(
                                                    data[index].description,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    style: normalBlackText(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const HorizontalSpacer(),
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return AddNewTodo(
                                                      id: data[index]
                                                          .id
                                                          .toString(),
                                                      title: data[index].title,
                                                      description: data[index]
                                                          .description,
                                                    );
                                                  }));
                                                },
                                                child: const Text("Edit"),
                                              ),
                                              Text(
                                                  "${date!.substring(8, 10)}-${date.substring(5, 7)}-${date.substring(0, 4)}")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                  error: (error, s) => Text(error.toString()),
                  loading: () => const CircularProgressIndicator())
            ],
          ),
          Positioned(
            top: 5,
            left: 0,
            child: Column(
              children: [
                IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      size: 30,
                    ),
                    onPressed: () {
                      // print(ref.read(todoControllerStateProvider));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddNewTodo(),
                        ),
                      );
                      return ref.refresh(todoDataProvider);
                    }),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
