import 'package:flutter/material.dart';

class Myclassss extends StatelessWidget {
  const Myclassss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: mylivedata(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            print("============${snapshot.connectionState.toString()}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            // if (snapshot.connectionState == ConnectionState.active) {
            //   return Text(
            //     "${snapshot.data!}",
            //     style: TextStyle(fontSize: 50),
            //   );
            // }
            return Text(
              "${snapshot.data!}",
              style: TextStyle(fontSize: 50),
            );

          },
        ),
      ),
    );
  }

  Stream<String> mylivedata() async* {
    bool timealwalyrunning = true;

    while (timealwalyrunning) {
      DateTime time = DateTime.now();

      await Future.delayed(Duration(seconds: 1));
      yield "${time.hour}::${time.minute}::${time.second}";
    }
  }
}
