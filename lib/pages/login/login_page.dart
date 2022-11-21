import 'package:ecommerce/api/api_services.dart';
import 'package:ecommerce/models/login_model.dart';
import 'package:ecommerce/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  APIService apiService = APIService();
  late LoginResponseModel user;

  String login = "";

  String senha = "";

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
          child: Container(
            height: 300,
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
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Login", icon: Icon(Icons.mail)),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            login = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo Obrigatório';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: "Senha", icon: Icon(Icons.lock)),
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextButton(
                            onPressed: () => context.push('/register'),
                            child: const Text(
                              "Não possuo conta",
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
                                    .loginCustomer(login, senha)
                                    .then((value) {
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.setString("user_token", value.token);
                                    print(prefs.getString('user_token'));
                                    context.push('/home');
                                  });
                                });

                                //     .onError(
                                //   (error, stackTrace) {
                                //     print(error);
                                //     return ScaffoldMessenger.of(context)
                                //         .showSnackBar(
                                //       SnackBar(
                                //           content: Text(error.toString()),
                                //           backgroundColor: Colors.deepOrange),
                                //     );
                                //   },
                                // );
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
                            child: const Text("Logar"),
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
