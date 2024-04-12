import 'package:get/get.dart';
import 'package:todo/app/data/providers/task/provider.dart';
import 'package:todo/app/data/services/storage/repository.dart';

import 'package:todo/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
