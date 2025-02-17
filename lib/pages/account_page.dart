import 'package:TTTMedicine/controllers/account_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../services/auth_service.dart';
import '../widgets/clip_wawe.dart';

class AccountPage extends StatefulWidget {
  static const String id = 'account_page';

  const AccountPage({super.key,});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AccountController>(
        builder: (_){
          return Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height:200,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    color: AppColors.appActiveColor,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: CachedNetworkImage(
                                    height: 70,
                                    width: 70,
                                    imageUrl: AuthService.currentUser().photoURL!,
                                    placeholder: (context, url) => const Image(
                                      image: AssetImage(
                                          "assets/images/user_icon.jpg"),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) => const Image(
                                      image: AssetImage(
                                          "assets/images/user_icon.jpg"),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${AuthService.currentUser().displayName}",style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),),
                            Text("${AuthService.currentUser().email}",style: const TextStyle(
                              fontSize: 18,
                            ),),
                          ],
                        ),
                      ),
                      Expanded(
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: Colors.deepPurpleAccent[50],
                                  elevation: 5,
                                  child: ListTile(
                                    leading:  Icon(Icons.local_post_office_outlined,
                                        color: AppColors.appActiveColor),
                                    title: const Text("Send message",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      // Navigator.of(context).push(MyPopupRoute(
                                      //   child: QRGenerateFromUserId(userId: box.userId.toString()),));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: Colors.deepPurpleAccent[50],
                                  elevation: 5,
                                  child: ListTile(
                                    leading:  Icon(Icons.leaderboard_outlined,
                                        color: AppColors.appActiveColor),
                                    title: const Text("Progress",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      // Navigator.of(context).push(MyPopupRoute(
                                      //   child: QRGenerateFromUserId(userId: box.userId.toString()),));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: Colors.deepPurpleAccent[50],
                                  elevation: 5,
                                  child: ListTile(
                                    leading:  Icon(Icons.chat_outlined,
                                        color: AppColors.appActiveColor),
                                    title: const Text("AI chat",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      controller.goToChatPage();
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: Colors.deepPurpleAccent[50],
                                  elevation: 5,
                                  child: ListTile(
                                    leading:  Icon(Icons.settings,
                                        color:AppColors.appActiveColor),
                                    title: const Text("Settings",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      // Navigator.of(context).push(MyPopupRoute(
                                      //   child: QRGenerateFromUserId(userId: box.userId.toString()),));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: Colors.deepPurpleAccent[50],
                                  elevation: 5,
                                  child: ListTile(
                                    leading:  Icon(Icons.logout_outlined,
                                        color:AppColors.appActiveColor),
                                    title: const Text("Log out",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    onTap: () {
                                      controller.logOutDialog(context);
                                    },
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 5),
                                    margin: const EdgeInsets.only(top: 5),
                                    child: Text("Version: 1.0.0+1",style: TextStyle(
                                      color: AppColors.black05,
                                      fontSize: 11,
                                    ),),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,)
                    ],
                  ),
                ),

              )
            ],
          );
        },
      )
    );
  }
}
