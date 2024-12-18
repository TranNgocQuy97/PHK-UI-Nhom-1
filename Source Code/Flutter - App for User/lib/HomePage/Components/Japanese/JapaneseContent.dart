import 'dart:ui';
import 'package:flutter/material.dart';
import 'Components/SelectExercise.dart';
import 'Components/SelectLesson.dart';
import 'package:athena/HomePage/Components/FirebaseRealTimeDataBase/FirebaseRealTimeDataBase.dart';

class JapaneseContent extends StatefulWidget {
  @override
  State<JapaneseContent> createState() => _JapaneseContentState();
}

class _JapaneseContentState extends State<JapaneseContent> {
  BoxShadow JapaneseBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 4,
    offset: Offset(1, 1),
  );
  Color ColorSchemeOfJapanese = Color.fromRGBO(20, 52, 106, 1);
  List<String> courseNames = [];

  static void showClass(BuildContext context, List<String> courseNames) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "showClass",
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => SelectLesson(courseNames: courseNames),
    );
  }

  static void showExercise(BuildContext context) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "showExercise",
      context: context,
      transitionDuration: Duration(milliseconds: 200),
      transitionBuilder: (_, animation, __, child) {
        Tween<Offset> tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, _, __) => SelectExercise(),
    );
  }

  void loadCourseNames() async {
    List<String> names = await FireBaseRealTimeDataBase.fetchCourseNames('languages/2/courses');
    if (mounted) {
      setState(() {
        courseNames = names;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCourseNames();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 90, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discover",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      "Japanese",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                height: 180,
                width: screenWidth,
                decoration: BoxDecoration(
                  boxShadow: [JapaneseBoxShadow],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    "assets/backgrounds/HomePage/Japan/Japan.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 190,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    2,
                    (indexR) => InkWell(
                      onTap: () {
                        if (indexR == 0) {
                          showClass(context, courseNames);
                        } else if (indexR == 1) {
                          showExercise(context);
                        }
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          boxShadow: [JapaneseBoxShadow],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: Image.asset(
                            indexR == 0
                                ? "assets/icons/video-lesson.png"
                                : "assets/icons/homework.png",
                            fit: BoxFit.contain,
                            width: 40, // Kích thước của biểu tượng
                            height: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}