import 'package:athena/HomePage/Components/HomepageContent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:athena/HomePage/Components/Leaderboard.dart';
import 'package:athena/HomePage/Components/ExerciseHistory.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  List<bool> isPressedMenuComponents = [true, false, false];
  List<String> iconsName = ["HOME", "USER", "LIKE/STAR"];
  List<String> MenuComponentsName = ["Home", "User", "Process"];
  bool isPressedMenu = false;
  Color backgroundColor = Color.fromRGBO(0, 0, 20, 1);

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> salceAnimation;
  @override
  void initState(){
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
    )..addListener(
        (){
          setState(() {

          });
        }
    );
    animation = Tween <double> (begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Curves.fastOutSlowIn,
        )
    );
    salceAnimation = Tween <double> (begin: 1, end: 0.8).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.fastOutSlowIn,
        )
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
        body: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              left: isPressedMenu ? 0 : -240,
                width: 240,
                height: screenHeight,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  height: screenHeight,
                  width: 230,
                  color: backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 40,),
                          ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white
                              ),
                              child: Icon(
                                Icons.perm_identity,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              "User Name",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "Student",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                          height: 500,
                          // color: Colors.green,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 40,
                                        child: Text(
                                          "MENU",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          3,
                                              (index) => Container(
                                            height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 0.7,
                                                      width: 200,
                                                      color: Color.fromRGBO(
                                                          50, 50, 50, 1),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          3,
                                              (index) => Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              AnimatedContainer(
                                                duration:
                                                Duration(milliseconds: 250),
                                                height: 60,
                                                width:
                                                isPressedMenuComponents[index]
                                                    ? 228
                                                    : 0,
                                                decoration: BoxDecoration(
                                                    color: isPressedMenuComponents[
                                                    index]
                                                        ? Color.fromRGBO(96, 139, 193, 1)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                    BorderRadius.circular(10)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: List.generate(
                                          3,
                                              (index) => InkWell(
                                            onTap: () {
                                              setState(() {
                                                isPressedMenuComponents = [
                                                  false,
                                                  false,
                                                  false
                                                ];
                                                isPressedMenuComponents[index] =
                                                !isPressedMenuComponents[index];
                                                print(
                                                    "is press ${MenuComponentsName[index]} ");
                                              });
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  // color: Colors.yellow,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 35,
                                                      height: 59,
                                                      // color: Colors.blueAccent,
                                                      child: Center(
                                                        child: RiveAnimation.asset(
                                                          "assets/riveassets/icons.riv",
                                                          artboard: iconsName[index],
                                                          // onInit: (artboard){
                                                          //   StateMachineController controller =
                                                          //   RiveUtils.getRiveController(
                                                          //     artboard,
                                                          //     stateMachineName: "MENU",
                                                          //   );
                                                          //   controller.findSMI("active") as SMIBool;
                                                          // },
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        SizedBox(
                                                          height: 1,
                                                        ),
                                                        Text(
                                                          MenuComponentsName[index],
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.logout),
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut().then((_) {
                                        Navigator.pushReplacementNamed(context, '/login');
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.leaderboard),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Leaderboard()),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.history),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ExerciseHistory()),
                                      );
                                    },
                                  ),
                                ],
                              )
                            ],
                          )),

                      Container(
                        height: 150,
                      )
                    ],
                  ),
                )
            ),

            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)..rotateY( animation.value - 30 * animation.value * 3.14 /180),
              child: Transform.translate(
                  offset: Offset(animation.value * 205,0),
                child: Transform.scale(
                  scale: salceAnimation.value,
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: screenHeight,
                          width: screenWidth,
                          child: HomepageContent(isRoundedCorners: isPressedMenu,),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(30),
                          //   image: DecorationImage(
                          //     image: AssetImage("assets/backgrounds/wave.png"),
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: screenWidth,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(0),
                                    ),
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  child: Stack(
                                    children: [
                                      AnimatedPositioned(
                                        top: 25,
                                        left: isPressedMenu ? 15 : 80,
                                        duration: Duration(milliseconds: 200),
                                        child: Container(
                                            height: 45,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(200, 200, 200, 0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.home,
                                                size: 30,
                                                color: Color.fromRGBO(70, 92, 146, 1),
                                              ),
                                            ),
                                          ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin:  EdgeInsets.only(top: 25),
                                            height: 45,
                                            width: 65,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(200, 200, 200, 0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                ),
                                              ],
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.doorbell,
                                                size: 30,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ),

            AnimatedPositioned(
              top: isPressedMenu ? 75 : 25,
              left: isPressedMenu ? 180 : 15,
              duration: Duration(milliseconds: 200),
                child:GestureDetector(
                  onTap: (){
                    setState(() {
                      if(isPressedMenu){
                        _animationController.reverse();
                      } else{
                        _animationController.forward();
                      }
                      isPressedMenu = !isPressedMenu;
                    });
                  },
                  child: Container(
                    height: 45,
                    width: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(200, 200, 200, 0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: RiveAnimation.asset(
                      "assets/riveassets/menu_button.riv",
                    ),
                  ),
                ),
            ),
          ],
    ));
  }
}
