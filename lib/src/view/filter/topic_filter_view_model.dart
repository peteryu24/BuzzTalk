import 'package:alarm_app/src/model/topic_model.dart';
import 'package:alarm_app/src/repository/topic_repository.dart';
import 'package:alarm_app/src/view/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class TopicFilterViewModel extends BaseViewModel {
  final TopicRepository topicRepository;

  TopicFilterViewModel({required this.topicRepository}) {
    loadTopics;
  }
  List<TopicModel> topics = [];
  List<int> selectedTopicIds = [];
  Map<int, int> topicRoomCounts = {}; //각 주제별 방 개수

  //topic과 방 개수 로드
  Future<void> loadTopics() async {
    try {
      topics = await topicRepository.getTopicList();
      topicRoomCounts = await topicRepository.getRoomCountByTopic();
    } catch (e) {
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
