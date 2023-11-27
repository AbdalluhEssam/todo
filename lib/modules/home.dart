import 'package:course_udemy/layout/news_app/news_layout.dart';
import 'package:course_udemy/modules/BMI/bmi_screen.dart';
import 'package:course_udemy/shared/components/components.dart';
import 'package:flutter/material.dart';
import '../shared/cubit/cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubitDark = AppCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                cubitDark.changeDarkModeSheet();
              },
              icon: const Icon(
                Icons.brightness_4_outlined,
                size: 30,
              )),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2),
            children: [
              buildGridContainer(
                "NEWS",
                "assets/images/news.png",
                onTap: () {
                  navigateTo(context, const NewsLayout());
                },
              ),
              buildGridContainer(
                "BMI",
                "assets/images/img.png",
                onTap: () {
                  navigateTo(context, const BmiScreen());
                },
              ),
              buildGridContainer("Logout", "assets/images/logout.png"),
            ],
          )),
    );
  }
}

Widget buildGridContainer(text, image, {void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            image,
            width: 50,
            fit: BoxFit.cover,
            color: Colors.black,
            height: 50,
          ),
          Text(text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    ),
  );
}
