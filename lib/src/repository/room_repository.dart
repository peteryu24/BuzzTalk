import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alarm_app/src/model/room_model.dart';
import 'http_request.dart';

class RoomRepository {
  final Http httpRequest;

  RoomRepository(this.httpRequest);

  //cursorID: data를 몇 개나 불러올건지? limit: 한 번에 가져오는 최대 방의 갯수 제한 설정 //
  Future<List<RoomModel>> getRoomList(
      int? topicId, String? cursorId, int limit) async {
    final response = await httpRequest.post('/room/list', {
      'topicId': topicId,
      'cursorId': cursorId,
      'limit': limit,
    });
    return (response as List).map((json) => RoomModel.fromJson(json)).toList();
  }

  Future<Map<String, dynamic>> createRoom(RoomModel roomModel) async {
    final response = await httpRequest.post('/room/create', roomModel.toJson());
    return response;
  }

  //수정
  Future<List<RoomModel>> getRoomListByIds(List<String> roomIds) async {
    final response = await httpRequest.post('/room/ids', {'roomIds': roomIds});
    return (response as List).map((json) => RoomModel.fromJson(json)).toList();
  }
}
