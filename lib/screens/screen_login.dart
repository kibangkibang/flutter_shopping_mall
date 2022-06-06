import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
          child: Column(
        children: [
          EmailInput(),
          PasswordInput(),
          LoginButton(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(thickness: 1),
          ),
          RegisterButton(),
        ],
      )),
    );
  }
}

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (email) {},
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(labelText: '이메일', helperText: ''),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (password) {},
        obscureText: true,
        decoration: InputDecoration(
          labelText: '비밀번호',
          helperText: '',
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        child: Text('로그인'),
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
        ),
      ),
    );
  }
}
class RegisterButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(onPressed: () {
      Navigator.of(context).pushNamed('/register');
    }, child: Text('이메일로 간단하게 회원가입하기',style: TextStyle(
      color: theme.primaryColor
    ),));
  }
}