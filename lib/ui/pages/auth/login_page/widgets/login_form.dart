import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/_core/utils/validator_util.dart';
import 'package:flutter_blog/data/dto/user_request.dart';
import 'package:flutter_blog/data/provider/session_provider.dart';
import 'package:flutter_blog/ui/widgets/custom_auth_text_form_field.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerWidget {
  // ref 사용하려면 컨슈머위젯으로

  final _formKey;
  final username;
  final password;
  LoginForm(this._formKey, this.username, this.password);

  // final _formKey = GlobalKey<FormState>();
  // final username = TextEditingController();
  // final password = TextEditingController();

  // static final username = TextEditingController();
  // static final password = TextEditingController();
  // 스태이틱 변수는 화면 파괴돼도 항상 남아있어서 메모리 관리에 안좋음
  // 다만 앱은 사용자 1명만 본인기기에서 쓰는거니까 아주 안좋지는 않음

  // LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetRef ref 추가
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomAuthTextFormField(
            text: "Username",
            obscureText: false,
            funValidator: validateUsername(),
            controller: username,
          ),
          const SizedBox(height: mediumGap),
          CustomAuthTextFormField(
            text: "Password",
            obscureText: true,
            funValidator: validatePassword(),
            controller: password,
          ),
          const SizedBox(height: largeGap),
        ],
      ),
    );
  }
}
