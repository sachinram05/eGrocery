import 'package:egrocery/constants/authConstant.dart';
import 'package:egrocery/providers/authProvider.dart';
import 'package:egrocery/screens/homeScreen.dart';
import 'package:egrocery/widgets/inputWithLabel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final authFormKey = GlobalKey<FormState>();
  var isloginMode = true;
  var enteredName = '';
  var enteredMobile = '';
  var enteredPassword = '';
  var enteredEmail = '';
  bool isLoading = false;

  void authFormHandler() async {
    try {
      if (authFormKey.currentState!.validate()) {
        authFormKey.currentState!.save();
        setState(() {
          isLoading = true;
        });

        if (isloginMode) {
          await ref.read(authProvider.notifier).loginUser({
            'email': enteredEmail,
            'password': enteredPassword,
          });
        } else {
          await ref.read(authProvider.notifier).registerUser({
            'name': enteredName,
            'email': enteredEmail,
            'mobile': enteredMobile,
            'password': enteredPassword,
          });
        }

        final authState = ref.read(authProvider);

        if (authState is LoadingAuthState) {
          setState(() {
            isLoading = authState.isLoading;
          });
        }
        if (authState is LoadedAuthState) {
          setState(() {
            isLoading = authState.isLoading;
          });
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(authState.message)));

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
        if (authState is ErrorAuthState) {
          setState(() {
            isLoading = authState.isLoading;
          });

          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(authState.message)));
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SafeArea(
            child: Container(
                width: double.infinity,
               height: double.infinity,
               alignment: Alignment.center,
            
                  child: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                width: MediaQuery.of(context).size.width * 0.74,
                                child: Text(
                                  isloginMode
                                      ? "Welcome Back to our grocery shop"
                                      : "Welcome to our grocery shop",
                                  style: Theme.of(context).textTheme.titleMedium,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Card(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 40),
                                    child: Form(
                                      key: authFormKey,
                                      child: Column(
                                        children: [
                                          if (!isloginMode)
                                            InputWithLabel(
                                                labelName: "Name",
                                                textFormField: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText: 'Enter name'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        value.trim().length < 3) {
                                                      return "Please enter at least 3 characters.";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (newValue) {
                                                    setState(() {
                                                      enteredName = newValue!;
                                                    });
                                                  },
                                                )),
                                          const SizedBox(height: 10),
                                          InputWithLabel(
                                              labelName: "Email",
                                              textFormField: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Enter email'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                autocorrect: false,
                                                textCapitalization:
                                                    TextCapitalization.none,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty ||
                                                      !value.contains('@')) {
                                                    return 'Please enter valid email address';
                                                  }
                                                  return null;
                                                },
                                                onSaved: (newValue) {
                                                  setState(() {
                                                    enteredEmail = newValue!;
                                                  });
                                                },
                                              )),
                                          const SizedBox(height: 10),
                                          if (!isloginMode)
                                            InputWithLabel(
                                                labelName: "Phone Number",
                                                textFormField: TextFormField(
                                                  decoration: const InputDecoration(
                                                      labelText:
                                                          'Enter phone number'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headlineMedium,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty ||
                                                        value.trim().length != 10) {
                                                      return "Please enter valid Mobile number.";
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (newValue) {
                                                    setState(() {
                                                      enteredMobile = newValue!;
                                                    });
                                                  },
                                                )),
                                          const SizedBox(height: 10),
                                          InputWithLabel(
                                              labelName: "Password",
                                              textFormField: TextFormField(
                                                decoration: const InputDecoration(
                                                    labelText: 'Enter password',
                                                    suffixIcon:
                                                        Icon(Icons.remove_red_eye)),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                                obscureText: true,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty ||
                                                      value.trim().length < 6) {
                                                    return "Please enter at least 6 characters.";
                                                  }
                                                  return null;
                                                },
                                                onSaved: (newValue) {
                                                  setState(() {
                                                    enteredPassword = newValue!;
                                                  });
                                                },
                                              )),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                isloginMode ? "Log In" : "Sign Up",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                              isLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator())
                                                  : ElevatedButton(
                                                      onPressed: authFormHandler,
                                                      child: const Icon(
                                                        Icons.arrow_forward,
                                                        size: 28,
                                                      ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(isloginMode
                                                    ? "Don't have Account ?"
                                                    : "Already have Account ?"),
                                                TextButton(
                                                    onPressed: () {
                                                      authFormKey.currentState!
                                                          .reset();
                                                      setState(() {
                                                        enteredName = '';
                                                        enteredMobile = '';
                                                        enteredPassword = '';
                                                        enteredEmail = '';
                                                        isloginMode = !isloginMode;
                                                      });
                                                    },
                                                    child: Text(isloginMode
                                                        ? "Sign up"
                                                        : "Log in"))
                                              ])
                                        ],
                                      ),
                                    )))
                          ],
                        ),
                      ))),
            ));
  }
}
