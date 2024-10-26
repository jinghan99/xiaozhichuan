import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'gobang_state.dart';

class GoBangLogic extends GetxController {
  final GoBangState state = GoBangState();

  @override
  void onInit() {
    super.onInit();
  }
  // withdrawChessPiece
  void withdrawChessPiece(){
    if(state.offs.isEmpty){
       EasyLoading.showToast('没有棋子可以悔棋了');
       return;
    }
    //黑棋先
    if(state.offs.length % 2 == 1){
      state.offs.removeLast();
      state.boffs.removeLast();
    }else{
      state.offs.removeLast();
      state.woffs.removeLast();
    }
  }


  @override
  void onClose() {
    super.onClose();
  }
}
