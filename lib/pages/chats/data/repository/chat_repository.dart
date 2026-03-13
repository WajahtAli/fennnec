import 'package:fennac_app/core/network/api_helper.dart';
import 'package:fennac_app/app/constants/app_constants.dart';
import 'package:fennac_app/pages/chats/data/models/chat_and_calls_response.dart';

abstract class ChatRepository {
  Future<ChatAndCallsResponse> getChatsAndCalls({int? page, int? limit});
  Future<PokeDetailResponse> getPokeDetail(String pokeId);
  Future<PokeStartChatResponse> startChat(String pokeId);
}

class ChatRepositoryImpl implements ChatRepository {
  final ApiHelper _apiHelper;

  ChatRepositoryImpl(this._apiHelper);

  @override
  Future<ChatAndCallsResponse> getChatsAndCalls({int? page, int? limit}) async {
    final response = await _apiHelper.get(
      AppConstants.getChatAndCalls,
      queryParameters: {
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
      },
    );

    return ChatAndCallsResponse.fromJson(response);
  }

  @override
  Future<PokeDetailResponse> getPokeDetail(String pokeId) async {
    final response = await _apiHelper.get('${AppConstants.pokeDetail}$pokeId');
    return PokeDetailResponse.fromJson(response);
  }

  @override
  Future<PokeStartChatResponse> startChat(String pokeId) async {
    final response = await _apiHelper.post(
      '${AppConstants.pokeDetail}$pokeId${AppConstants.startPokeChat}',
    );
    return PokeStartChatResponse.fromJson(response);
  }
}
