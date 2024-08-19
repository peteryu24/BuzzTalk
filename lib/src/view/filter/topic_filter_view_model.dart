import 'package:alarm_app/src/model/topic_model.dart';
import 'package:alarm_app/src/repository/topic_repository.dart';
import 'package:flutter/cupertino.dart';

class TopicFilterViewModel with ChangeNotifier {
  final TopicRepository topicRepository;

  TopicFilterViewModel({required this.topicRepository});
  List<TopicModel> topics = [];
  List<int> selectedTopicIds = [];
  Map<int, int> topicRoomCounts = {}; //각 주제별 방 개수

  //topic과 방 개수 로드
  Future<void> loadTopics() async {
    //topic 불러오기
    final topicListData = await topicRepository.getTopicList();
    topics = topicListData.map((data) => TopicModel.fromJson(data)).toList();

    //방 개수 불러오기
    final roomCountData = await topicRepository.getRoomCountByTopic();

    for (var roomData in roomCountData) {
      int topicId = roomData['topicId'];
      int roomCount = roomData['room_count']; // 방의 개수 정보
      topicRoomCounts[topicId] = roomCount;
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
