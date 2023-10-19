import 'package:flutter/material.dart';
import 'package:flutter_blog/data/model/post.dart';
import 'package:flutter_blog/data/provider/param_provider.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_page.dart';
import 'package:flutter_blog/ui/pages/post/detail_page/post_detail_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/post_list_view_model.dart';
import 'package:flutter_blog/ui/pages/post/list_page/wiegets/post_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListBody extends ConsumerWidget {
  const PostListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PostListModel? model = ref.watch(postListProvider); // 지속적 구독 // 실행되는 순간 창고관리자가 시작됨 // state==null로 시작함

    List<Post> posts = [];

    if (model != null) {
      posts = model.posts;
    }

    return ListView.separated(
      // 중간중간에 구분선 넣어주는 빌더, 그냥 InkWell을 컬럼으로 감싸서 밑에 줄 그어줘도 큰 차이없다
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Detail 창고 관리자에게 postId 저장
            // 보통 서버에서 DTO로 주니까 모든 정보를 담아두는 경우가 거의 없고,
            // 글이 최신화가 안 됐을 수도 있으니까 id로 다시 통신해서 글 받아온다.
            ParamStore paramStore = ref.read(paramProvider);
            paramStore.addPostDetailId(posts[index].id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetailPage(),
              ),
            );
          },
          child: PostListItem(posts[index]),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(); // 구분선
      },
    );
  }
}
