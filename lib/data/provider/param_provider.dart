// 1. 창고 데이터
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestParm {
  int? postDetailId;
  // int? commentId;

  RequestParm({this.postDetailId});
}

// 2. 창고
class ParamStore extends RequestParm {
  final mContext = navigatorKey.currentContext;

  void addPostDetailId(int postId) {
    print("파람프로바이더postId : ${postId}");
    this.postDetailId = postId;
  }

  // void movePostDetail(int postId) {
  //   Navigator.push(mContext!, MaterialPageRoute(builder: (_) => PostDetailPage()));
  // }
}

// 3. 창고 관리자
final paramProvider = Provider<ParamStore>((ref) {
  return new ParamStore();
});
