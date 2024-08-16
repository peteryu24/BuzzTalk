// import 'package:alarm_app/src/model/topic_model.dart';
// import 'package:alarm_app/src/service/topic_service.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class TopicFilterView extends StatefulWidget {
//   final int? selectedTopicId;

//   const TopicFilterView({super.key, this.selectedTopicId});

//   @override
//   State<TopicFilterView> createState() => _TopicFilterViewState();
// }

// class _TopicFilterViewState extends State<TopicFilterView> {
//   List<int> selectedTopicIds = [];

//   // 토픽 클릭 시 호출되는 메서드
//   void _onTopicTap(int topicId) {
//     setState(() {
//       if (selectedTopicIds.contains(topicId)) {
//         // 이미 선택된 토픽이면 선택 해제
//         selectedTopicIds.remove(topicId);
//       } else {
//         // 선택되지 않은 토픽이면 선택
//         selectedTopicIds.add(topicId);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('주제별 필터'),
//         leading: IconButton(
//           onPressed: () {
//             // 다시 홈 화면으로 이동
//           },
//           icon: const Icon(
//             Icons.close,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               //토픽 누른 것에 대해서만 홈 화면에 나오게 한다
//               print('Selected Topic IDs: $selectedTopicIds');
//             },
//             icon: const Icon(
//               Icons.check,
//             ),
//           ),
//         ],
//       ),
//       body: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 10,
//               left: 20,
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   width: 80,
//                   height: 80,
//                   child: const Center(
//                     child: Text(
//                       '토픽1',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 54,
//                   left: 65,
//                   child: Container(
//                       width: 15,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           '0',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       )),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 10,
//               left: 20,
//             ),
//             child: Stack(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   width: 80,
//                   height: 80,
//                   child: const Center(
//                     child: Text(
//                       '토픽2',
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 54,
//                   left: 65,
//                   child: Container(
//                       width: 15,
//                       height: 25,
//                       decoration: BoxDecoration(
//                         color: Colors.grey,
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           '1',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       )),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class TopicFilterView extends StatefulWidget {
  final int? selectedTopicId;

  const TopicFilterView({super.key, this.selectedTopicId});

  @override
  State<TopicFilterView> createState() => _TopicFilterViewState();
}

class _TopicFilterViewState extends State<TopicFilterView> {
  // 선택된 토픽 ID를 저장하는 리스트
  List<int> selectedTopicIds = [];

  // 토픽 클릭 시 호출되는 메서드
  void _onTopicTap(int topicId) {
    setState(() {
      if (selectedTopicIds.contains(topicId)) {
        // 이미 선택된 토픽이면 선택 해제
        selectedTopicIds.remove(topicId);
      } else {
        // 선택되지 않은 토픽이면 선택
        selectedTopicIds.add(topicId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('주제별 필터'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.close,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // 선택된 토픽에 대해 작업 수행
              print('선택 topic id: $selectedTopicIds');
            },
            icon: const Icon(
              Icons.check,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            child: GestureDetector(
              onTap: () => _onTopicTap(1), // 토픽 1 선택 시 ID 1 전달
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: selectedTopicIds.contains(1) // 선택된 상태 확인
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                    width: 80,
                    height: 80,
                    child: const Center(
                      child: Text(
                        '토픽1', //topicName
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
                      child: const Center(
                        child: Text(
                          '0', //토픽의 개수
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
            ),
            child: GestureDetector(
              onTap: () => _onTopicTap(2), // 토픽 2 선택 시 ID 2 전달
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      color: selectedTopicIds.contains(2) // 선택된 상태 확인
                          ? Colors.purple
                          : Colors.transparent,
                    ),
                    width: 80,
                    height: 80,
                    child: const Center(
                      child: Text(
                        '토픽2', //topicName
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
                      child: const Center(
                        child: Text(
                          '1', //토픽의 개수
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
