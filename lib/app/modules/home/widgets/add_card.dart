import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/data/models/task.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';
import 'package:todo/app/widgets/icons.dart';

class AddCard extends StatelessWidget {
  final controller = Get.find<HomeController>();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2.0,
      height: squareWidth / 2.0,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              onPopInvoked: (didPop) {
                controller.editController.clear();
                controller.changeChipIndex(0);
              },
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: controller.editController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                    child: Wrap(
                      spacing: 2.0.wp,
                      children: icons
                          .map((e) => Obx(() {
                                final index = icons.indexOf(e);

                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  label: e,
                                  showCheckmark: false,
                                  shape: const CircleBorder(side: BorderSide(color: Colors.white)),
                                  labelStyle: TextStyle(color: e.color!),
                                  selected: controller.chipIndex.value == index,
                                  onSelected: (selected) {
                                    controller.chipIndex.value = selected ? index : 0;
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      maximumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        int icon = icons[controller.chipIndex.value].icon!.codePoint;
                        String color = icons[controller.chipIndex.value].color!.toHex();
                        var task = Task(
                          title: controller.editController.text,
                          icon: icon,
                          color: color,
                        );
                        Get.back();
                        controller.addTask(task) ? EasyLoading.showSuccess('Create Success') : EasyLoading.showError('Duplicate Task');
                        controller.editController.clear();
                        controller.changeChipIndex(0);
                      }
                    },
                    child: const Text('Confirm'),
                  ),
                ],
              ),
            ),
          );
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
