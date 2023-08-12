// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:bsv_app/screen/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepperController extends GetxController {
  bool isLoader = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController eventStartDateController = TextEditingController();
  TextEditingController patentInitialsController = TextEditingController();
  TextEditingController ethnicityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController describeController = TextEditingController();

  TextEditingController dailyDoesController = TextEditingController();
  TextEditingController indicationController = TextEditingController();
  TextEditingController batchNoController = TextEditingController();
  TextEditingController therapyDateController = TextEditingController();
  TextEditingController therapyDateControllerStopDate = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController therapyDurationController = TextEditingController();
  TextEditingController routesAdministrationController =
      TextEditingController();

  TextEditingController relevantHistoryController = TextEditingController();
  TextEditingController dateOfAdministrationController =
      TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController manufacturerDateController = TextEditingController();
  TextEditingController reportDateController = TextEditingController();
  TextEditingController mfrControlController = TextEditingController();
  TextEditingController feedBackController = TextEditingController();

  TextEditingController routesOfAdtOtherController = TextEditingController();

  TextEditingController eventLaterOtherController = TextEditingController();
  final TextEditingController countryValue = TextEditingController();
  final TextEditingController drugValue = TextEditingController();

  String stopDrugValueRadioBtn = '';
  String reIntroValueRadioBtn = '';
  String reportSourceValueRadioBtn = '';
  String reportTypeValueRadioBtn = '';
  String describeReactionValue = '';

  String reportSourceValue = '';
  String reportTypeValue = '';
  String genderRadioBtn = '';
  String genderRadioValue = '';

  String routesOfAdValues = '';
  String resolutionValues = '';
  String countryKeyValue = '';
  String countryValueName = '';
  List suspectDrugsId = [];
  List selectedDrugsItems = [];
  List selectedDrugsItemsName = [];

  List natureEventValue = [];
  String stoppingDrugValue = '';
  String stoppingReIntroValue = '';
  bool isRoutesAdOther = false;

  var dropdownCountryValue;

  var dropdownResoulutionValue;
  var dropdownRoutesofAdValue;

  bool eventLaterOther = false;
  var dropdownEventLater;
  var dropdownEventLaterList = [
    'Complete recovery',
    'Ongoing',
    'Recovering',
    'Recovered with Sequel',
    'Unknown',
    'Death',
    'Other',
  ];

  var itemsGender = [
    {
      'title': 'Male',
    },
    {
      'title': 'Female',
    },
    {
      'title': 'Other',
    }
  ];

  String phone = '';
  String usertype = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String otherUserType = '';
  String token = '';
  bool isLoading = false;
  List<XFile>? userimage;
  bool selectImage = false;
  final picker = ImagePicker();
  String save_status = "0";

  @override
  void onInit() {
    getStoreData();
    super.onInit();
  }

  void getStoreData() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString("phone") ?? '';
    usertype = prefs.getString("user_type") ?? '';
    firstName = prefs.getString("first_name") ?? '';
    lastName = prefs.getString("last_name") ?? '';
    email = prefs.getString("email") ?? '';
    otherUserType = prefs.getString("other_type") ?? '';
    save_status = prefs.getString("save_status") ?? '0';

    if (save_status == "1") {
      dateController.text = prefs.getString("dateController") ?? '';
      eventStartDateController.text =
          prefs.getString("eventStartDateController") ?? '';
      patentInitialsController.text =
          prefs.getString("patentInitialsController") ?? '';
      ageController.text = prefs.getString("ageController") ?? '';
      sexController.text = prefs.getString("sexController") ?? '';
      describeController.text = prefs.getString("describeController") ?? '';
      dailyDoesController.text = prefs.getString("dailyDoesController") ?? '';
      indicationController.text = prefs.getString("indicationController") ?? '';
      therapyDateController.text =
          prefs.getString("therapyDateController") ?? '';
      routesAdministrationController.text =
          prefs.getString("routesAdministrationController") ?? '';
      addressController.text = prefs.getString("addressController") ?? '';
      manufacturerDateController.text =
          prefs.getString("manufacturerDateController") ?? '';
      reportDateController.text = prefs.getString("reportDateController") ?? '';
      mfrControlController.text = prefs.getString("mfrControlController") ?? '';
      batchNoController.text = prefs.getString("batchNoController") ?? '';
      expiryDateController.text = prefs.getString("expiryDateController") ?? '';
      relevantHistoryController.text =
          prefs.getString("relevantHistoryController") ?? '';
      dateOfAdministrationController.text =
          prefs.getString("dateOfAdministrationController") ?? '';
      feedBackController.text = prefs.getString("feedBackController") ?? '';
      ethnicityController.text = prefs.getString("ethnicityController") ?? '';
      therapyDateControllerStopDate.text =
          prefs.getString("therapyDateControllerStopDate") ?? '';
      routesOfAdtOtherController.text =
          prefs.getString("routesOfAdtOtherController") ?? '';
      eventLaterOtherController.text =
          prefs.getString("eventLaterOtherController") ?? '';
    }
    print("Phone:----- ${phone}");
    print("USerType:----- ${usertype}");
  }

  Future formStoreAPI() async {
    print("Start");
    print(natureEventValue.toString());
    print(patentInitialsController.text);
    print(ethnicityController.text);
    print(countryValueName.toString());
    print(dateController.text);
    print(ageController.text);
    print(genderRadioValue.toString());
    print(describeController.text);
    print(eventStartDateController.text);
    print(dropdownEventLater.toString());
    print(eventLaterOtherController.text);
    print(describeReactionValue.toString());

    print(suspectDrugsId.toString());
    print(dailyDoesController.text);
    print(indicationController.text);
    print(batchNoController.text);
    print(expiryDateController.text);
    print(therapyDateController.text);
    print(dropdownRoutesofAdValue.toString());
    print(routesOfAdtOtherController.text);
    print(therapyDurationController.text);
    print(dropdownResoulutionValue.toString());
    print(stoppingDrugValue.toString());
    print(stoppingReIntroValue.toString());

    print(relevantHistoryController.text);
    print(dateOfAdministrationController.text);

    print(addressController.text);
    print(reportTypeValue.toString());

    print(feedBackController.text);

    print(firstName);
    print(lastName);
    print(email);
    print(phone);
    print(usertype.toString());
    print(otherUserType.toString());

    String url = "${baseUrl}form/store";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({"Content-Type": "multipart/form-data"});
    request.fields['nature_of_event'] = natureEventValue.join(',').toString();
    request.fields['patent_initials'] = patentInitialsController.text;
    request.fields['ethnicity'] = ethnicityController.text;
    request.fields['country'] = countryValueName.toString();
    request.fields['date_of_birth'] = dateController.text;
    request.fields['age'] = ageController.text;
    request.fields['sex'] = "1";
    request.fields['describe_reactions'] = describeController.text;
    request.fields['event_start_date'] = eventStartDateController.text;
    request.fields['event_later'] = dropdownEventLater.toString();
    if (eventLaterOtherController.text != "") {
      request.fields['event_later_other'] = eventLaterOtherController.text;
    }
    // request.fields['describe_reactions_options'] =
    //     describeReactionValue.toString();
    request.fields['suspect_drugs'] = suspectDrugsId.join(',').toString();
    // request.fields['suspect_drugs'] = "1";
    request.fields['daily_doses'] = dailyDoesController.text;
    request.fields['indication_for_use'] = indicationController.text;
    request.fields['batch_no'] = batchNoController.text;
    request.fields['expiry_date'] = expiryDateController.text;
    request.fields['therapy_date'] = therapyDateController.text;
    request.fields['therapy_stop_date'] = therapyDateControllerStopDate.text;
    request.fields['routs_of_administration'] = routesOfAdValues.toString();
    if (routesOfAdtOtherController.text != "") {
      request.fields['routs_of_administration_other'] =
          routesOfAdtOtherController.text;
    }
    request.fields['therapy_duration'] = therapyDurationController.text;
    request.fields['resolution_action'] = resolutionValues.toString();
    request.fields['stopping_drug'] = stoppingDrugValue.toString();
    request.fields['re_introduction'] = stoppingReIntroValue.toString();
    request.fields['relevant_history'] = relevantHistoryController.text;
    request.fields['drugs_date_of_administration'] =
        dateOfAdministrationController.text;
    request.fields['name_address_of_manufacturer'] = addressController.text;
    request.fields['report_type'] = reportTypeValue.toString();

    if (userimage != null && userimage!.isNotEmpty) {
      for (var image in userimage!) {
        request.files
            .add(await http.MultipartFile.fromPath('document[]', image.path));
      }
    }

    request.fields['comments'] = feedBackController.text;
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = "test";
    request.fields['email'] = email;
    request.fields['user_type'] = usertype.toString();
    if (otherUserType != "") {
      request.fields['other_type'] = otherUserType.toString();
    }
    request.fields['phone'] = phone.toString();
    // request.fields['step'] = lastIndex.toString();
    print("request fields : ${request.fields}");
    print("request files : ${request.files}");
    var response = await request.send();

    String responseData = await response.stream.transform(utf8.decoder).join();
    print("Response:-- ${responseData}");

    var userData = json.decode(responseData);
    return userData;
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              getImage(true);
              Navigator.pop(context);
            },
            child: const Text(
              'Upload Image',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF282B3D)),
            ),
          ),
          // CupertinoActionSheetAction(
          //   onPressed: () {
          //     getImage(false);
          //   },
          //   child: const Text('Camera',
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w600,
          //           color: Color(0xFF282B3D))),
          // ),
        ],
      ),
    );
  }

  Future getImage(bool status) async {
    final pickedFile = await picker.pickMultiImage();
    if (pickedFile != null) {
      selectImage = true;
      userimage = pickedFile;
      update();
    } else {
      // showMsg(context, msg: 'Please Select Image', color: Colors.red);
    }
  }

  Future suspectDrugApi() async {
    String url = "${baseUrl}drugs";
    var response = await http.get(
      headers: {"Content-Type": "application/json"},
      Uri.parse(url),
    );
    var model = jsonDecode(response.body);
    print("suspectDrugApi drugs :~ $model");
    print(response);
    return model;
  }

  Future optionListApi() async {
    String url = "${baseUrl}options";
    var response = await http.get(
      headers: {"Content-Type": "application/json"},
      Uri.parse(url),
    );
    var model = jsonDecode(response.body);
    print("suspectDrugApi :~ $model");
    print(response);
    return model;
  }
}
