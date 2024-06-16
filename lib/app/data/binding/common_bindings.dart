import 'package:get/get.dart';
import 'package:orphan_care/app/data/controller/common_controller.dart';
import 'package:orphan_care/app/data/controller/donor_controller.dart';
import 'package:orphan_care/app/data/controller/trust_controller.dart';

class CommonBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController(), permanent: true);
    Get.put(TrustController());
    Get.put(DonorController());
  }
}
