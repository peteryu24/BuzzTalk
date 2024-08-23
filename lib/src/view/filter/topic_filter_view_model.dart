import 'package:alarm_app/src/model/topic_model.dart';
import 'package:alarm_app/src/repository/topic_repository.dart';
import 'package:alarm_app/util/error_pop_util.dart';
import 'package:alarm_app/src/view/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class TopicFilterViewModel extends BaseViewModel {
  final TopicRepository topicRepository;
  final ErrorPopUtils _errorPopUtil = ErrorPopUtils();

  TopicFilterViewModel({required this.topicRepository});

  List<TopicModel> topics = [];
  List<int> selectedTopicIds = [];
  Map<int, int> topicRoomCounts = {};

  Future<void> loadTopics(BuildContext context) async {
    try {
      var topicsResponse = await topicRepository.getTopicList();
      if (topicsResponse is List<TopicModel>) {
        topics = topicsResponse;
      } else {
        _errorPopUtil.showErrorDialog(context, 0);
        return;
      }

      var roomCountsResponse = await topicRepository.getRoomCountByTopic();
      if (roomCountsResponse is Map<int, int>) {
        topicRoomCounts = roomCountsResponse;
      } else {
        _errorPopUtil.showErrorDialog(context, 0);
        return;
      }
    } catch (e) {
      _errorPopUtil.showErrorDialog(context, 20);
      print('Failed to load topics or room counts: $e');
    }
    notifyListeners();
  }

  void onTopicTap(int topicId) {
    if (selectedTopicIds.contains(topicId)) {
      selectedTopicIds.remove(topicId);
    } else {
      selectedTopicIds.add(topicId);
    }
    notifyListeners();
  }
}
