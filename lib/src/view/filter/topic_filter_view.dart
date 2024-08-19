import 'package:alarm_app/src/repository/topic_repository.dart';
import 'package:alarm_app/src/view/filter/topic_filter_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicFilterView extends StatelessWidget {
  const TopicFilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TopicFilterViewModel(
        topicRepository: context.read<TopicRepository>(),
      )..loadTopics(), //객체를 생성한 후, LoadTopics() 메서드 호출
      child:
          Consumer<TopicFilterViewModel>(builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('주제별 필터'),
            leading: IconButton(
              onPressed: () {
                //필터 창 닫기
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context, viewModel.selectedTopicIds);
                  //  selectedTopicIds에 들어가 있는 요소들만 홈 화면에 나오게 한디
                  print('선택 topic id: ${viewModel.selectedTopicIds}');
                },
                icon: const Icon(
                  Icons.check,
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //한 열에 얼마나 널을 것인지
                  childAspectRatio: 1, //child 가로 세로 비율
                  crossAxisSpacing: 10, //열 간의 간격
                  mainAxisSpacing: 10, //행 간의 간격
                ),
                itemCount: viewModel.topics.length,
                itemBuilder: (context, index) {
                  final topic = viewModel.topics[index];
                  final isSelected =
                      viewModel.selectedTopicIds.contains(topic.topicId);
                  final topicRoomCount =
                      viewModel.topicRoomCounts[topic.topicId] ?? 0;

                  return GestureDetector(
                    onTap: () => viewModel
                        .onTopicTap(topic.topicId), // 토픽 1 선택 시 ID 1 전달
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            color: isSelected // 선택된 상태 확인
                                ? Colors.purple
                                : Colors.transparent,
                          ),
                          width: 80,
                          height: 80,
                          child: Center(
                            child: Text(
                              topic.topicName, //topicName
                            ),
                          ),
                        ),
                        Positioned(
                          top: 54,
                          left: 65,
                          child: Container(
                            width: 15,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '$topicRoomCount', //토픽의 개수
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
