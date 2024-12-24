import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr()),
        centerTitle: true,
      ),
      body: HomePageBody(),
    );
  }
}
