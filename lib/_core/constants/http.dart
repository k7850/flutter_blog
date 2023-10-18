import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// http 통신
final dio = Dio(
  BaseOptions(
    baseUrl: "http://192.168.0.45:8080", // 내 IP 입력
    contentType: "application/json; charset=utf-8",
  ),
);

// 휴대폰 로컬에 파일로 저장
const secureStorage = FlutterSecureStorage();
// 유효하면 자동 로그인 할 예정
