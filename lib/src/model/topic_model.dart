class TopicModel {
  final int topicId;
  final String topicName;

  TopicModel({
    required this.topicId,
    required this.topicName,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      topicId: json['topicId'] ?? 0,
      topicName: json['topicName'] ?? 'Unknown',
    );
  }
}
