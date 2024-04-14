import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/core/utils/extensions.dart';
import 'package:todo/app/modules/home/controllers/home_controller.dart';

class AddDialog extends StatelessWidget {
  final controller = Get.find<HomeController>();
  AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async => false,
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.editController.clear();
                        controller.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          if (controller.task.value == null) {
                            EasyLoading.showError('Please select task type');
                          } else {
                            var success = controller.updateTask(
                              controller.task.value!,
                              controller.editController.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              controller.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist');
                            }
                            controller.editController.clear();
                          }
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: Text(
                  'New Task',
                  style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: controller.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.0.wp, 5.0.wp, 5.0.wp, 2.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey[400]!),
                ),
              ),
              ...controller.tasks.map((element) => Obx(
                    () => InkWell(
                      onTap: () {
                        controller.changeTask(element);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  IconData(
                                    element.icon,
                                    fontFamily: 'MaterialIcons',
                                  ),
                                  color: HexColor.fromHex(element.color),
                                ),
                                SizedBox(
                                  width: 3.0.wp,
                                ),
                                Text(
                                  element.title,
                                  style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (controller.task.value == element)
                              const Icon(
                                Icons.check,
                                color: Colors.blue,
                              )
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
