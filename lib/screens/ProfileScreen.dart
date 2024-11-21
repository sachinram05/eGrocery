import 'package:egrocery/screens/AuthScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String mobile = '';
  String email = '';
  bool isloading = false;

  Future<void> getLoggedUserDetails() async {
    setState(() {
      isloading = true;
    });
    final userData = await SharedPreferences.getInstance();
    setState(() {
      name = userData.getString('name') as String;
      mobile = userData.getString('mobile') as String;
      email = userData.getString('email') as String;
    });
    setState(() {
      isloading = false;
    });
  }

  Future<void> logoutUser() async {
    final userData = await SharedPreferences.getInstance();
    await userData.remove('token');
    await userData.remove('token');
    await userData.remove('token');
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const AuthScreen()));
  }

  @override
  void initState() {
    super.initState();
    getLoggedUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width * 0.44,
              height: MediaQuery.of(context).size.height * 0.24,
              child: Image.asset(
                "assets/images/man.png",
                fit: BoxFit.fill,
              )),
            const SizedBox(height: 10),
            Text(name, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Text(mobile,  style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Text(email, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 40),
              TextButton(
                      
                        onPressed: logoutUser,
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: [
              Icon(
                Icons.logout_rounded,
                size: 24,
                color: Colors.red[400]),
                 const Text(' LogOut'),
                         ],) )
           
          ],
        ),
      
    );
  }
}
