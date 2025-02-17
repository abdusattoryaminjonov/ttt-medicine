import 'package:TTTMedicine/services/log_service.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../services/auth_service.dart';


class RegisterPage extends StatefulWidget {
  static const String id = 'register_page';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  callGoogleSignIn(context)async{
    var result = await AuthService.signInWithGoogle();
    Navigator.pushReplacementNamed(context, 'home_page');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    Future.delayed(const Duration(seconds: 3), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            color: AppColors.white100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * 3.1416,
                              child: child,
                            );
                          },
                          child: const Image(
                            image: AssetImage('assets/images/app.jpg'),
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("TTT Medicine",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 23
                            )),
                        Text("Ro'yhatdan o'tish! Ba'zi ma'lumotlar uchun ro'yxatdan o'tish kerak!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.appActiveColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),)
                      ],
                    )
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  color: Colors.deepPurpleAccent[50],
                  elevation: 5,
                  child: ListTile(
                    leading:  ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: const Image(
                          image: AssetImage("assets/images/google.png"),
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        )
                    ),
                    title: const Text("Google",
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.black05,
                    ),
                    onTap: () {
                      callGoogleSignIn(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
