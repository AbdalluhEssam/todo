import 'package:course_udemy/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color color = Colors.blue,
        bool isUpperCase = true,
        required String text,
        required void Function()? onPressed}) =>
    Container(
      width: width,
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType keyboardType,
        required String labelText,
        required IconData icon,
        required String? Function(String?)? validator,
        bool isPassShow = false,
        bool readOnly = false,
        Function()? suffixPressed,
        IconData? suffixIcon,
        void Function(String)? onFieldSubmitted,
        void Function()? onTap,
        void Function(String)? onChanged}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassShow,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: suffixPressed,
                )
              : null,
          border: const OutlineInputBorder()),
    );

Widget buildTaskItem({
  required String time,
  required String id,
  required String title,
  required String date,
  required context,
  required void Function()? onPressedDone,
  required void Function()? onPressedArchive,
}) =>
    Dismissible(
      key: Key(id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(children: [
          CircleAvatar(
            radius: 40,
            child: Text(time),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: onPressedDone,
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              )),
          IconButton(
              onPressed: onPressedArchive,
              icon: const Icon(
                Icons.archive,
                color: Colors.black45,
              )),
        ]),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteFromDatabase(id: int.parse(id));
      },
    );

Widget tasksBuilder({required List<Map> tasks}) => tasks.isNotEmpty
    ? ListView.separated(
        itemCount: tasks.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => buildTaskItem(
            id: "${tasks[index]['id']}",
            title: "${tasks[index]['title']}",
            date: "${tasks[index]['date']}",
            time: "${tasks[index]['time']}",
            context: context,
            onPressedDone: () {
              AppCubit.get(context)
                  .updateToDatabase(status: "done", id: tasks[index]['id']);
            },
            onPressedArchive: () {
              AppCubit.get(context)
                  .updateToDatabase(status: "archive", id: tasks[index]['id']);
            }),
        separatorBuilder: (BuildContext context, int index) => Container(
          color: Colors.blue,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 1,
        ),
      )
    : const Center(
        child: Text(
          "No Tasks Yet, Please Add Some Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );

Widget buildArticleItem(article) => Padding(
  padding: const EdgeInsets.all(15.0),
  child:   Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image:  DecorationImage(
                    image:NetworkImage("${article['urlToImage']}"),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                Expanded(
                  child: Text("${article['title']}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis),
                ),
                Text(
                  "${article['publishedAt']}",
                  style: const TextStyle(color: Colors.grey),
                )
              ],
            ),
          ))
        ],
      ),
);
Widget myDivider() => Container(

  color: Colors.grey,
  margin: const EdgeInsets.symmetric(horizontal: 10),
  height: 1,
);
