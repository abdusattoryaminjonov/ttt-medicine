import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_colors.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {

  goToCalenderPage(){
    Navigator.of(context).pushReplacementNamed('home_page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueWhite,
      body: GestureDetector(
        onVerticalDragUpdate: (details){
          int sensitivity = 8;
          if(details.delta.dy < -sensitivity){
            goToCalenderPage();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              // color: AppColors.white100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Lottie.asset('assets/lotties/note_animate1.json'),
                          ),
                          // AnimatedBuilder(
                          //   animation: _controller,
                          //   builder: (context, child) {
                          //     return Transform.rotate(
                          //       angle: _controller.value * 2 * 3.1416,
                          //       child: child,
                          //     );
                          //   },
                          //   child: const Image(
                          //     image: AssetImage('assets/images/app.jpg'),
                          //     width: 200,
                          //     height: 200,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          const SizedBox(height: 30),
                          Text("BugDori ichish vaqti!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.appActiveColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),),
                          Text("Bolnol 1 ta tabletka!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),),
                          const SizedBox(height: 30),
                          Container(
                            child: Lottie.asset('assets/lotties/swipe_up.json'),
                          ),
                        ],
                      )
                  ),

                  // Card(
                  //   margin: const EdgeInsets.only(bottom: 15),
                  //   color: Colors.deepPurpleAccent[50],
                  //   elevation: 5,
                  //   child: ListTile(
                  //     leading:  ClipRRect(
                  //         borderRadius: BorderRadius.circular(2),
                  //         child: const Image(
                  //           image: AssetImage("assets/images/google.png"),
                  //           width: 40,
                  //           height: 40,
                  //           fit: BoxFit.cover,
                  //         )
                  //     ),
                  //     title: const Text("Google",
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold)),
                  //     trailing: Icon(
                  //       Icons.arrow_forward_ios,
                  //       size: 16,
                  //       color: AppColors.black05,
                  //     ),
                  //     onTap: () {
                  //       callGoogleSignIn(context);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
