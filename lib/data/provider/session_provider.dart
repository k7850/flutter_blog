import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/http.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/data/dto/response_dto.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/model/user.dart';
import 'package:flutter_blog/data/repository/user_repository.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고 데이터
class SessionUser {
  // 화면 context에 접근하는 법. 글로벌키
  final mContext = navigatorKey.currentContext;
  User? user;
  String? jwt;
  bool isLogin; // jwt가 있어도 시간 만료됐을수도 있으니까 필요함

  SessionUser({
    this.user,
    this.jwt,
    this.isLogin = false,
  });

  Future<void> join(JoinReqDTO joinReqDTO) async {
    // 1. 통신 코드
    ResponseDTO responseDTO = await new UserRepository().fetchJoin(joinReqDTO);

    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      Navigator.pushNamed(mContext!, Move.loginPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!) //
          .showSnackBar(SnackBar(content: Center(child: Text(responseDTO.msg))));
    }
  }

  Future<void> login(LoginReqDTO loginReqDTO) async {
    // 1. 통신 : Repository 메소드를 호출하여 응답 결과 및 데이터 받음.
    ResponseDTO responseDTO = await new UserRepository().fetchLogin(loginReqDTO);

    // 2. 비지니스 로직
    if (responseDTO.code == 1) {
      // 2-1. 토큰을 휴대폰에 저장
      await secureStorage.write(key: "jwt", value: responseDTO.token);

      // 2-3. 로그인 상태 등록
      this.user = responseDTO.data;
      this.jwt = responseDTO.token;
      this.isLogin = true;

      // 2-4. 페이지 이동
      Navigator.popAndPushNamed(mContext!, Move.postListPage);
    } else {
      // 실패 시 스낵바
      ScaffoldMessenger.of(mContext!) //
          .showSnackBar(SnackBar(content: Center(child: Text(responseDTO.msg))));
    }
  }

  // JWT는 로그아웃 할 때 서버로 요청할 필요가 없음.(어짜피 스테스리스로 서버에 정보가 없으니까)
  Future<void> logout() async {
    this.jwt = null;
    this.isLogin = false;
    this.user = null;

    await secureStorage.delete(key: "jwt");
    // await 없으면 삭제 전에 로그인페이지로 이동돼서 바로 다시 자동로그인 될 수 있음

    // Navigator.popAndPushNamed(context, Move.loginPage);
    Navigator.pushNamedAndRemoveUntil(mContext!, Move.loginPage, (route) => false);
    // 로그아웃이니까 스택 쌓인거 싹 다 없애기
  }

  // Future<void> update() async {}
}

// 2. 창고  //그냥 뷰모델이면 창고 필요없음

// 3. 창고 관리자
final sessionProvider = Provider<SessionUser>((ref) {
  return new SessionUser();
});
