
import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchState {

  var searchList = <String>[].obs;
  var isEditingSearch = false.obs;
  TextEditingController searchController = TextEditingController();
  RefreshController controller = RefreshController();

  Rx<Map<String, Video>> searchResultMap = Rx<Map<String, Video>>({});

  Rx<List<Video>> searchResultList = Rx<List<Video>>([]);

  RxBool isLoading = false.obs;

  SearchState() {

  }
}
