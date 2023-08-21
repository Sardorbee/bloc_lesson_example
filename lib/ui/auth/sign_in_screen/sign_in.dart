import 'package:bloc_lesson_example/data/bloc/cubits/firebase_sign_cubit/firebase_sign_in_cubit.dart';
import 'package:bloc_lesson_example/ui/auth/forget_password_page/forget_password.dart';
import 'package:bloc_lesson_example/ui/auth/sign_up_screen/sign_up.dart';
import 'package:bloc_lesson_example/ui/utils/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    // LoginProvider x = context.read<LoginProvider>();
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: const Color.fromARGB(255, 243, 240, 240),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.6,
                        child: stackmethod(context),
                      ),
                      SizedBox(
                        height: h * 0.06,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(w * 0.17),
                            child: Row(
                              children: [
                                const Text("Don't have an account yet? "),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) =>
                                            const SignUpPage()),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Registration',
                                    style: TextStyle(
                                        color: Colors.cyan,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
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
    );
  }

  Stack stackmethod(BuildContext context) {
    final emailcontroller = context.read<FirebaseSignInCubit>().emailController;
    final passwordcontroller = context.read<FirebaseSignInCubit>().passwordController;
    var w = MediaQuery.of(context).size.width;
    FirebaseSignInCubit x = context.watch<FirebaseSignInCubit>();
    var h = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(h * 0.025),
            ),
            width: w * 1,
            height: h * 0.4,
          ),
        ),
        Positioned(
          right: w * 0.35,
          top: h * 0.15,
          child: Text(
            'Welcome Back',
            style: TextStyle(color: Colors.white, fontSize: w * 0.08),
          ),
        ),
        Positioned(
          top: h * 0.22,
          left: w * 0.05,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(h * 0.023),
            ),
            width: w * 0.9,
            height: h * 0.36,
            child: Container(
              padding: EdgeInsets.all(h * 0.02),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailcontroller,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.check_circle_rounded),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  TextFormField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      labelText: ('Password'),
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple.shade600),
                      ),
                      // suffixIcon: IconButton(
                      //   icon: Icon(
                      //       // x.obscureText
                      //       //   ? Icons.visibility_off
                      //       //   :
                      //       Icons.visibility),
                      //   onPressed: () {},
                      // ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.012),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ForgetPasswordPage()))),
                    hoverColor: Colors.blue,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Do not remember the password?',
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: h * 0.045),
                  ),
                  SizedBox(
                    height: h * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(h * 0.01),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.cyan,
                        ),
                      ),
                      onPressed: (() {
                        if (passwordcontroller.text.isNotEmpty &&
                            emailcontroller.text.isNotEmpty) {
                          x.signInUser(context,
                              email: emailcontroller.text,
                              password: passwordcontroller.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('You should fill all fields'),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1)),
                          );
                        }
                      }),
                      child: const Center(
                        child: Text('Sign In'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
