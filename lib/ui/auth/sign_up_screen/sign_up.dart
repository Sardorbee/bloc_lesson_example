import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/firebase_sign_in_cubit.dart';
import 'package:bloc_lesson_example/ui/app_level/app.dart';
import 'package:bloc_lesson_example/ui/auth/sign_in_screen/sign_in.dart';
import 'package:bloc_lesson_example/ui/utils/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseSignInCubit x = context.read<FirebaseSignInCubit>();

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 240, 240),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              fontFamily: 'Fjalla',
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.032,
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.019),
                              color: Colors.black12,
                            ),
                            child: TextFormField(
                              controller: emailController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon:
                                      Icon(Icons.person_outline_outlined),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    fontFamily: 'Fjalla',
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.019),
                              color: Colors.black12,
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              // obscureText: passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {},
                                  ),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Fjalla',
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.height * 0.019),
                              color: Colors.black12,
                            ),
                            child: TextFormField(
                              controller: repeatpasswordController,
                              // obscureText: y.obscureText1,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.visibility),
                                    onPressed: () {
                                      // x.obs2();
                                    },
                                  ),
                                  labelText: "Repeat Password",
                                  labelStyle: const TextStyle(
                                    fontFamily: 'Fjalla',
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.065,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Colors.cyan,
                                ),
                              ),
                              onPressed: () async {
                                if (passwordController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text ==
                                        repeatpasswordController.text) {
                                  await x.signUpUser(context,
                                      email: emailController.text,
                                      password: repeatpasswordController.text);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('You should fill all fields'),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              child: const Center(
                                child: Text('Register'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const SignInPage())),
                                    (route) => false),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                      color: Colors.cyan,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<FirebaseSignInCubit, FirebaseSignInState>(
              builder: (context, state) {
                return Visibility(
                    visible: state is FirebaseSignInLoading,
                    child: const LoadingPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
