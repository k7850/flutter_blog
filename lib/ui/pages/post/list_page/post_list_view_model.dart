import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/data/dto/post_request.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/data/repository/post_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

// 1. 창고 데이터

class PostListModel {
  List<Post> posts;
  PostListModel({required this.posts});
}

// 2. 창고
class PostListViewModel extends StateNotifier<PostListModel?> {
  Ref ref;

  final mContext = navigatorKey.currentContext;

  // StateNotifier<PostListModel?> 에서 PostListModel은 상태의 타입
  PostListViewModel(this.ref, super._state); // 상태가 바뀌면 자동으로 그려짐

  // notify 구독자들에게 알려줌
  Future<void> notifyInit() async {
    Logger().d("notifyInit");

    // jwt 가져오기
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await PostRepository().fetchPostList(sessionUser.jwt!);
    state = PostListModel(posts: responseDTO.data);
  }

  Future<void> notifyAdd(PostSaveReqDTO dto) async {
    SessionUser sessionUser = ref.read(sessionProvider);

    ResponseDTO responseDTO = await PostRepository().fetchPost(sessionUser.jwt!, dto);

    if (responseDTO.code == 1) {
      Post newPost = responseDTO.data as Post; // 1. dynamic(Post)

      // ResponseDTO response2DTO = await PostRepository().fetchPostList(sessionUser.jwt!);
      // state = PostListModel(posts: response2DTO.data);

      List<Post> newPosts = [newPost, ...state!.posts]; // 2. 기존 상태에 데이터 추가
      state = PostListModel(posts: newPosts); // 3. 뷰모델(창고) 데이터 갱신 -> watch 구독자 자동으로 리빌드됨
      // 다만 글 작성 하는 중간에 다른 사람이 글을 적었다고 치면 그 글은 안보임

      Navigator.pop(mContext!);
    } else {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text("게시물 작성 실패 : ${responseDTO.msg}")));
    }
  }

//
}

// 3. 창고 관리자 (View가 빌드되기 직전에 생성됨)
final postListProvider = StateNotifierProvider<PostListViewModel, PostListModel?>((ref) {
  Logger().d("창고관리자 실행됨");
  return new PostListViewModel(ref, null)..notifyInit();
});
