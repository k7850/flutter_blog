import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 데이터

class PostListPageModel {
  List<Post> posts;
  PostListPageModel({required this.posts});
}

// 2. 창고
class PostListPageViewModel extends StateNotifier<PostListPageModel?> {
  Ref ref;

  // StateNotifier<PostListModel?> 에서 PostListModel은 상태의 타입
  PostListPageViewModel(this.ref, super._state); // 상태가 바뀌면 자동으로 그려짐

  // notify 구독자들에게 알려줌
  Future<void> notifyInit() async {
    Logger().d("notifyInit");

    // jwt 가져오기
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListPageModel(posts: responseDTO.data);
  }
}

// 3. 창고 관리자 (View가 빌드되기 직전에 생성됨)
final postListPageProvider = StateNotifierProvider<PostListPageViewModel, PostListPageModel?>((ref) {
  Logger().d("창고관리자 실행됨");
  return PostListPageViewModel(ref, null)..notifyInit();
});
