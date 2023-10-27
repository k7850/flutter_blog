import 'package:flutter/material.dart';
import 'package:flutter_blog/_core/constants/move.dart';
import 'package:flutter_blog/_core/constants/size.dart';
import 'package:flutter_blog/ui/pages/auth/login_page/widgets/login_form.dart';
import 'package:flutter_blog/ui/widgets/custom_elavated_button.dart';
import 'package:flutter_blog/ui/widgets/custom_logo.dart';
import 'package:flutter_blog/ui/widgets/custom_text_button.dart';

class LoginBody extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LoginForm lF = LoginForm(); // 여기서 만들고 (new 생략된거니까) 밑에서 사용

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: xlargeGap),
          const CustomLogo("Blog"),
          const SizedBox(height: largeGap),
          // lF,
          LoginForm(_formKey, username, password),
          CustomElevatedButton(
            text: "로그인",
            funPageRoute: () {
              print("username : ${username.text}");
              print("password : ${password.text}");
              // print("username : ${lF.username.text}");
              // print("password : ${lF.password.text}");
            },
          ),
          CustomTextButton(
            "회원가입 페이지로 이동",
            () {
              Navigator.pushNamed(context, Move.joinPage);
            },
          ),
        ],
      ),
    );
  }
}
