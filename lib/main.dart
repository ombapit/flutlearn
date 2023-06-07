import 'package:fitflutter/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final Controller c = Get.put(Controller());

    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(
            title: Obx(() => Text("Sample CB from api, Clicks: ${c.count}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(
            child: Column(
          children: <Widget>[
            Obx(
              () => Text("cb: ${c.us}"),
            ),
            Flexible(
              child: Obx(
                () => ListView.builder(
                  itemCount: c.us.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(c.us[index]["name"]),
                      value: c.us[index]["selected"],
                      onChanged: (bool? value) {
                        c.us[index]["selected"] = value;
                        c.us.refresh();
                      },
                    );
                  },
                ),
              ),
            ),
            GetX<Controller>(
              builder: (_) => Flexible(
                child: ListView.builder(
                  itemCount: c.us.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      title: Text(c.us[index]["name"]),
                      value: c.us[index]["selected"],
                      onChanged: (bool? value) {
                        c.us[index]["selected"] = value;
                        c.us.refresh();
                      },
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
                child: Text("Go to Other"),
                onPressed: () => Get.to(() => Other())),
          ],
        )),
        floatingActionButton: FloatingActionButton(
            onPressed: c.increment, child: Icon(Icons.add)));
  }
}

class Other extends StatelessWidget {
  Other({super.key});
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
