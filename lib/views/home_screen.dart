import 'package:cilected_proj/models/data_model.dart';
import 'package:cilected_proj/utils/app_snackbar.dart';
import 'package:cilected_proj/utils/constant/api_constants.dart';
import 'package:cilected_proj/utils/constant/string_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'components/item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// [dataModel] will hold fetched data from API
  late DataModel dataModel;

  /// Act as data availability flag, initially it is false
  /// and will be updated in [fetchData] function
  bool isDataFetched = false;

  /// Fetches data and set to [dataModel] then update [isDataFetched] to hold true
  Future fetchData() async {
    String url = ApiConstants.baseUrl + ApiConstants.getPracticalData;
    Dio dio = Dio(BaseOptions(headers: {"Content-Type": "application/json"}));
    var request = {"practical_type": "3"};
    dio.post(url, data: request).then((response) {
      if (response.statusCode == 200) {
        dataModel = DataModel.fromJson(response.data);
        isDataFetched = true;
        setState(() {}); // Updating state once we have data
      } else {
        AppSnackbar.showSnackbar(context: context, title: "Error: Something went wrong", bgColor: Colors.red);
        throw Exception('Error: Something went wrong');
      }
    }).onError((DioError errro, stackTrace) {
      AppSnackbar.showSnackbar(context: context, title: errro.message, bgColor: Colors.red);
      debugPrint(errro.message); // Printing error message
    });
  }

  @override
  void initState() {
    fetchData(); // Fetching data before build
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
                    children: dataModel.data.map((element) => Item(element: element)).toList(),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
