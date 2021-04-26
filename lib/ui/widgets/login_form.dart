import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:crudnex/blocs/login/login_events.dart';
import 'package:crudnex/blocs/login/login_bloc.dart';
import 'package:crudnex/blocs/login/login_states.dart';
import 'package:crudnex/ui/widgets/loading_widget.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    Key? key,
  }) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final LoginBloc loginBloc = Modular.get<LoginBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loginBloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (
          context,
          state,
        ) {
          if (state is LoginFailure) {
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${state.error}'),
                  backgroundColor: Theme.of(context).errorColor,
                ),
              );
              _passwordController.text = "";
            });
          }
          return Container(
            child: Form(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 150, 16, 30),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Email de usuario',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'Senha',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: Text(
                          "Esqueci minha senha",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        onPressed: () {
                          print('se fodeu nao implementei ainda');
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              _onButtonPressed();
                            },
                            child: Text(
                              "Entrar",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: state is LoginLoading ? LoadingWidget() : null,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onButtonPressed() {
    loginBloc.add(
      LoginButtonPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }
}
