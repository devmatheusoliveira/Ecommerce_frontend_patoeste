import 'dart:async';

import 'package:ecommerce/api/api_services.dart';
import 'package:ecommerce/models/customer.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  APIService apiService = APIService();
  late CustomerModel user =
      CustomerModel(email: "", first_name: "", last_name: "", password: "");

  String senha = "";

  bool hidePassword = true;
  bool isApiCallProcess = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 500,
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/logo_icone.PNG",
                          height: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Faça seu cadastro",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: "Nome"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            user.first_name = value;
                            print("object");
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: "Sobrenome"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            user.last_name = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                          onChanged: (value) {
                            user.email = value;
                          },
                          validator: (value) {
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value!)) return 'Email invalido';

                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(labelText: "Senha"),
                          onChanged: (value) {
                            senha = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: false,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (senha != value) {
                              return 'Senhas não conhecidem';
                            }
                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: "Confirmar senha"),
                          onChanged: (value) {
                            user.password = value;
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextButton(
                            onPressed: () => context.push('/login'),
                            child: const Text(
                              "Já possuo conta",
                              style: TextStyle(color: AppColors.secondary),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 5,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                apiService
                                    .createCustomer(user)
                                    .then(
                                      (value) => ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Cadastro realizado com sucesso'),
                                            backgroundColor: Colors.green),
                                      ),
                                    )
                                    .onError((error, stackTrace) {
                                  print(error);
                                  return ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                        content: Text(error.toString()),
                                        backgroundColor: Colors.yellow),
                                  );
                                });
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.secondary),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: const Text("Registrar-se"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
