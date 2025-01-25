import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Animatsiya davomiyligi
      vsync: this, // TickerProvider (vsync)ni o'rnatish
    );

    Future.delayed(const Duration(seconds: 3), () {
      _controller.forward(); // Animatsiyani boshlash
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
                              angle: _controller.value * 2 * 3.1416, // 1 aylanish
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
                        Text("Select the language you prefer to continue using the app.",
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
                          image: AssetImage("assets/images/flags/uzb_flag.png"),
                          width: 30,
                          height: 25,
                          fit: BoxFit.cover,
                        )
                    ),
                    title: const Text("O'zbek",
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.black05,
                    ),
                    onTap: () {
                      // Navigator.of(context).push(MyPopupRoute(
                      //   child: QRGenerateFromUserId(userId: box.userId.toString()),));
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 5),
                  color: Colors.deepPurpleAccent[50],
                  elevation: 5,
                  child: ListTile(
                    leading:  ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: const Image(
                          image: AssetImage("assets/images/flags/eng_flag.png"),
                          width: 30,
                          height: 25,
                          fit: BoxFit.cover,
                        )
                    ),
                    title: const Text("English",
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.black05,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
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
