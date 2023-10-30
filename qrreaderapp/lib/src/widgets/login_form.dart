import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/api/my_api-.dart';
import 'package:qrreaderapp/src/utils/responsive.dart';
import 'input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _email = '', _password = '';

  _submit() async {
    final isOk = _formKey.currentState!.validate();
    print("form isOk $isOk");
    if (isOk) {
      MyAPI.instance.login(context, email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Positioned(
      bottom: 10,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: responsive.isTablet ? 380 : 310,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputText(
                keyboardType: TextInputType.emailAddress,
                label: "CORREO ELECTRÓNICO",
                fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                onChanged: (text) {
                  _email = text!;
                },
                validator: (text) {
                  if (!text!.contains("@")) {
                    return "Correo Invalido";
                  }
                  return "";
                },
              ),
              SizedBox(height: responsive.dp(2)),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black12,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: InputText(
                        label: "CONTRASEÑA",
                        obscureText: true,
                        borderEnabled: false,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.2 : 1.4),
                        onChanged: (text) {
                          _password = text!;
                        },
                        validator: (text) {
                          if (text!.trim().isEmpty) {
                            return "Contraseña Invalida";
                          }
                          return "";
                        },
                      ),
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                responsive.dp(responsive.isTablet ? 1.2 : 1.5),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(height: responsive.dp(5)),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  onPressed: _submit,
                  color: Colors.lightBlueAccent,
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: responsive.dp(2)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Registrese ahora!!",
                    style: TextStyle(
                      fontSize: responsive.dp(1.5),
                    ),
                  ),
                  MaterialButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: responsive.dp(1.5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'register');
                    },
                  )
                ],
              ),
              SizedBox(height: responsive.dp(10)),
            ],
          ),
        ),
      ),
    );
  }
}
