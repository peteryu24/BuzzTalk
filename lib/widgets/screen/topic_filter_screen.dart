import 'package:alarm_app/model/topic_model.dart';
import 'package:alarm_app/service/topic_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopicFilterScreen extends StatefulWidget {
  final int? selectedTopicId;

  const TopicFilterScreen({super.key, this.selectedTopicId});

  @override
  State<TopicFilterScreen> createState() => _TopicFilterScreenState();
}

class _TopicFilterScreenState extends State<TopicFilterScreen> {

}
