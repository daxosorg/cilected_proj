import 'dart:convert';

import 'package:cilected_proj/models/data_model.dart';
import 'package:cilected_proj/utils/app_snackbar.dart';
import 'package:cilected_proj/utils/constant/api_constants.dart';
import 'package:cilected_proj/utils/constant/string_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataModel dataModel;
  bool isDataFetched = false;

  // Fetch data
  Future fetchData() async {
    String url = ApiConstants.baseUrl + ApiConstants.getPracticalData;
    Dio dio = Dio(BaseOptions(headers: {"Content-Type": "application/json"}));
    var request = {"practical_type": "3"};
    dio.post(url, data: request).then((response) {
      if (response.statusCode == 200) {
        dataModel = DataModel.fromJson(response.data);
        isDataFetched = true;
        setState(() {});
      } else {
        AppSnackbar.showSnackbar(context: context, title: "Error: Something went wrong", bgColor: Colors.red);
        throw Exception('Error: Something went wrong');
      }
    }).onError((DioError errro, stackTrace) {
      AppSnackbar.showSnackbar(context: context, title: errro.message, bgColor: Colors.red);
      debugPrint(errro.message);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text(StringConstants.homeScreenTitle)),
        body: isDataFetched
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: dataModel.data
                        .map((element) => Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    element.images == null
                                        ? const Text('Received null as image url')
                                        : Container(
                                            height: 100,
                                            decoration: BoxDecoration(border: Border.all()),
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              element.images!,
                                              errorBuilder: (context, object, stackTrace) {
                                                return Text('Failed to load image, wrong url');
                                              },
                                            ),
                                          ),
                                    Text('Title: ${element.title}'),
                                    Text('Description: ${element.description}'),
                                  ],
                                ),
                                const SizedBox(height: 50),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
