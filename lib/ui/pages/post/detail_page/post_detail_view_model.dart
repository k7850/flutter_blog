import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 데이터
class PostDetailModel {
  Post post;

  PostDetailModel(this.post);
}

// 2. 창고
class PostDetailViewModel extends StateNotifier<PostDetailModel?> {
  Ref ref;

  PostDetailViewModel(super._state, this.ref);

  Future<void> notifyInit(int id) async {
    Logger().d("notifyInit");
    SessionUser sessionUser = ref.read(sessionProvider);
    ResponseDTO responseDTO = await PostRepository().fetchPost(sessionUser.jwt!, id);

    state = PostDetailModel(responseDTO.data);
  }
}

// 3. 창고 관리자
// family = 창고가 아니라, 창고 관리자에게 데이터 주는 방법

// autoDispose : 안하면 싱글톤이라 똑같은 id만 뜬다
final postDetailProvider = StateNotifierProvider.autoDispose<PostDetailViewModel, PostDetailModel?>((ref) {
  int postId = ref.read(paramProvider).postDetailId!;
  print("뷰모델postId : ${postId}");
  return PostDetailViewModel(null, ref)..notifyInit(postId);
});
