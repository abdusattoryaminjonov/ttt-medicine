import 'package:eslatma/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
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
                        const Image(
                          image: AssetImage('assets/images/app.jpg'),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
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
