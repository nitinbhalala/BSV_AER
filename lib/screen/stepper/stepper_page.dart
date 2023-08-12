// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:bsv_app/common/colors.dart';
import 'package:bsv_app/common/custtomBtn.dart';
import 'package:bsv_app/common/images.dart';
import 'package:bsv_app/common/normal_text.dart';
import 'package:bsv_app/common/string.dart';
import 'package:bsv_app/common/textField.dart';
import 'package:bsv_app/common/widget.dart';
import 'package:bsv_app/screen/setting/setting_page.dart';
import 'package:bsv_app/screen/stepper/stepper_controller.dart';
import 'package:bsv_app/screen/successful/successful_page.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:status_stepper/status_stepper.dart';

List stoppingDrugList = [];
List reIntroList = [];
List describeReactionList = [];
List natureEventList = [];
List countryList = [];
List reportSourceList = [];
List reportTypeList = [];
List routsOfAdList = [];
List resolutionList = [];
List suspectDrugList = [];
int curIndex = 0;
int lastIndex = -1;

class StepperScreen extends StatefulWidget {
  const StepperScreen({Key? key}) : super(key: key);

  @override
  State<StepperScreen> createState() => _StepperScreenState();
}

class _StepperScreenState extends State<StepperScreen> {
  final GlobalKey<FormState> stepper1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stepper2FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stepper3FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stepper4FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> stepper5FormKey = GlobalKey<FormState>();
  DateTime? selectedTherapyStartDate;

  StepperController stepperController = Get.put(StepperController());

  //bool isisLoading = false;

  @override
  void initState() {
    getLocalData();
    curIndex = 0;
    lastIndex = -1;
    stepperController.onInit();
    print(
        "dropdownRoutesofAdValue : ${stepperController.dropdownRoutesofAdValue}");
    super.initState();
  }

  @override
  void dispose() {
    stepperController.countryValue.dispose();
    // country.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StepperController>(builder: (stepperController) {
      return Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Images.bg), fit: BoxFit.fill)),
          child: SafeArea(
            child: stepperController.isLoader
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: SvgPicture.asset(Images.backArrow),
                                onTap: () {
                                  setState(() {
                                    if (lastIndex >= 0) {
                                      lastIndex--;
                                      curIndex--;
                                    }
                                  });
                                },
                              ),
                              NormalText(
                                (lastIndex == -1)
                                    ? txtReactionInformation
                                    : (lastIndex == 0)
                                        ? txtSuspectDrugsInformation
                                        : (lastIndex == 1)
                                            ? txtConcomitantDrugs
                                            : (lastIndex == 2)
                                                ? txtManufacturerInformation
                                                : (lastIndex == 3)
                                                    ? txtUploadDocument
                                                    : '',
                                fontSize: 13,
                                color: AppColor.black,
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    //    Get.to(const SettingScreen());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingScreen()));
                                  },
                                  child: SvgPicture.asset(Images.setting)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: StatusStepper(
                            connectorCurve: Curves.bounceInOut,
                            itemCurve: Curves.easeOut,
                            activeColor: AppColor.primary,
                            disabledColor: Colors.grey.withOpacity(0.4),
                            animationDuration:
                                const Duration(milliseconds: 500),
                            lastActiveIndex: lastIndex,
                            currentIndex: curIndex,
                            connectorThickness: 1,
                            children: List.generate(
                              5,
                              (index) => InkWell(
                                onTap: () {
                                  updateSteper(index);
                                },
                                child: SizedBox.square(
                                  dimension: 32,
                                  child: Center(child: Text('${index + 1}')),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        (lastIndex == -1)
                            ? Form(
                                key: stepper1FormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                NormalText(txtPatentInitials,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                textField(
                                                  controller: stepperController
                                                      .patentInitialsController,
                                                  hint: 'Patient Details',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  // validator: (val) {
                                                  //   if (val == null || val.isEmpty) {
                                                  //     return 'Please enter your Patent initials';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    NormalText(txtCountry,
                                                        fontSize: 16,
                                                        color: AppColor.black),
                                                    NormalText("*",
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                // DropdownSearch(
                                                //   mode: Mode.MENU,
                                                //   showSelectedItems: true,
                                                //   items: countryList.map((item) {
                                                //     return DropdownMenuItem(
                                                //       value: item.toString(),
                                                //       child: NormalText(
                                                //           item['value'].toString(),
                                                //           fontSize: 15,
                                                //           color: AppColor.purple),
                                                //     );
                                                //   }).toList(),
                                                //   dropdownSearchDecoration:
                                                //       InputDecoration(
                                                //     labelText: "Menu mode",
                                                //     hintText:
                                                //         "country in menu mode",
                                                //   ),
                                                //   // popupItemDisabled:
                                                //   //     isItemDisabled,
                                                //   onChanged: (newValue) {
                                                //     setState(() {
                                                //       stepperController
                                                //               .dropdownCountryValue =
                                                //           newValue!;
                                                //       stepperController
                                                //               .countryKeyValue =
                                                //           stepperController
                                                //                   .dropdownCountryValue[
                                                //               'lable'];
                                                //       stepperController
                                                //               .countryValueName =
                                                //           stepperController
                                                //                   .dropdownCountryValue[
                                                //               'value'];
                                                //       print(
                                                //           "Stepper DropDown:== ${stepperController.dropdownCountryValue}");
                                                //     });
                                                //   },
                                                //   //selectedItem: "",
                                                //   showSearchBox: true,
                                                //   searchFieldProps:
                                                //       TextFieldProps(
                                                //     cursorColor: Colors.blue,
                                                //   ),
                                                // ),
                                                Container(
                                                  height: 44,
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 0),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .lightPurple)),
                                                  child: Center(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton2<
                                                          Object>(
                                                        value: stepperController
                                                            .dropdownCountryValue,
                                                        isExpanded: true,
                                                        underline:
                                                            const SizedBox(),
                                                        isDense: true,
                                                        hint: Text(
                                                          "Select Country",
                                                          style: TextStyle(
                                                              color: AppColor
                                                                  .purple),
                                                        ),
                                                        items: countryList
                                                            .map((item) =>
                                                                DropdownMenuItem(
                                                                  value: item,
                                                                  child: NormalText(
                                                                      item[
                                                                          'value'],
                                                                      fontSize:
                                                                          15,
                                                                      color: AppColor
                                                                          .purple),
                                                                ))
                                                            .toList(),
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            stepperController
                                                                    .dropdownCountryValue =
                                                                newValue!;
                                                            stepperController
                                                                    .countryKeyValue =
                                                                stepperController
                                                                        .dropdownCountryValue[
                                                                    'lable'];
                                                            stepperController
                                                                    .countryValueName =
                                                                stepperController
                                                                        .dropdownCountryValue[
                                                                    'value'];
                                                            print(
                                                                "Stepper dropdownCountryValue:== ${stepperController.dropdownCountryValue}");
                                                          });
                                                        },
                                                        dropdownSearchData:
                                                            DropdownSearchData(
                                                          searchController:
                                                              stepperController
                                                                  .countryValue,
                                                          searchInnerWidgetHeight:
                                                              50,
                                                          searchInnerWidget:
                                                              Container(
                                                            height: 50,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 8,
                                                              bottom: 4,
                                                              right: 8,
                                                              left: 8,
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              expands: true,
                                                              maxLines: null,
                                                              controller:
                                                                  stepperController
                                                                      .countryValue,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 8,
                                                                ),
                                                                hintText:
                                                                    'Search for an country...',
                                                                hintStyle:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          searchMatchFn: (item,
                                                              searchValue) {
                                                            return (item.value
                                                                .toString()
                                                                .contains(
                                                                    searchValue
                                                                        .capitalize!));
                                                          },
                                                        ),
                                                        onMenuStateChange:
                                                            (isOpen) {
                                                          if (!isOpen) {
                                                            stepperController
                                                                .countryValue
                                                                .clear();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   height: 44,
                                                //   padding: const EdgeInsets
                                                //           .symmetric(
                                                //       horizontal: 10),
                                                //   decoration: BoxDecoration(
                                                //       color: AppColor.white,
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               8),
                                                //       border: Border.all(
                                                //           color: AppColor
                                                //               .lightPurple)),
                                                //   child: Center(
                                                //     child: DropdownButton(
                                                //       value: stepperController
                                                //           .dropdownCountryValue,
                                                //       isExpanded: true,
                                                //       underline:
                                                //           const SizedBox(),
                                                //       isDense: true,
                                                //       icon: const Icon(Icons
                                                //           .keyboard_arrow_down),
                                                //       hint: Text(
                                                //         "Select Country",
                                                //         style: TextStyle(
                                                //             color: AppColor
                                                //                 .purple),
                                                //       ),
                                                //       items: countryList
                                                //           .map((item) {
                                                //         return DropdownMenuItem(
                                                //           value: item,
                                                //           child: NormalText(
                                                //               item['value'],
                                                //               fontSize: 15,
                                                //               color: AppColor
                                                //                   .purple),
                                                //         );
                                                //       }).toList(),
                                                //       onChanged: (newValue) {
                                                //         setState(() {
                                                //           stepperController
                                                //                   .dropdownCountryValue =
                                                //               newValue!;
                                                //           stepperController
                                                //                   .countryKeyValue =
                                                //               stepperController
                                                //                       .dropdownCountryValue[
                                                //                   'lable'];
                                                //           stepperController
                                                //                   .countryValueName =
                                                //               stepperController
                                                //                       .dropdownCountryValue[
                                                //                   'value'];
                                                //           print(
                                                //               "Stepper DropDown:== ${stepperController.dropdownCountryValue}");
                                                //         });
                                                //       },
                                                //     ),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                NormalText(txtEthnicity,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                textField(
                                                  controller: stepperController
                                                      .ethnicityController,
                                                  hint: 'Ethnicity',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  // validator: (val) {
                                                  //   if (val == null || val.isEmpty) {
                                                  //     return 'Please enter your Ethnicity';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtDateOfBirth,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                    ),
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      controller:
                                                          stepperController
                                                              .dateController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        14.0,
                                                                    horizontal:
                                                                        15),
                                                        fillColor:
                                                            AppColor.white,
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        isDense: true,
                                                        hintText: 'dd/mm/yy',
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () async {
                                                            DateTime?
                                                                selectedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1900),
                                                                    lastDate:
                                                                        DateTime
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return Theme(
                                                                        data: Theme.of(context)
                                                                            .copyWith(
                                                                          colorScheme:
                                                                              ColorScheme.light(
                                                                            primary:
                                                                                AppColor.primary.withOpacity(0.1),
                                                                            // header background color
                                                                            onPrimary:
                                                                                Colors.black,
                                                                            // header text color
                                                                            onSurface:
                                                                                Colors.black, // body text color
                                                                          ),
                                                                          textButtonTheme:
                                                                              TextButtonThemeData(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.black, // button text color
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    });
                                                            if (selectedDate !=
                                                                null) {
                                                              String
                                                                  formattedDate =
                                                                  "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                              stepperController
                                                                      .dateController
                                                                      .text =
                                                                  formattedDate;
                                                            }
                                                            print(
                                                                "DateController.text-- ${stepperController.dateController.text}");
                                                          },
                                                          child:
                                                              Transform.scale(
                                                            scale: 0.4,
                                                            child: SvgPicture
                                                                .asset(Images
                                                                    .calender),
                                                          ),
                                                        ),
                                                        errorMaxLines: 2,
                                                        errorStyle:
                                                            const TextStyle(
                                                                height: 0,
                                                                fontSize: 10),
                                                        hintStyle: TextStyle(
                                                          color:
                                                              AppColor.purple,
                                                          fontSize: 15,
                                                          fontFamily: 'Rubik',
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    NormalText(txtAge,
                                                        fontSize: 16,
                                                        color: AppColor.black),
                                                    NormalText("*",
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                                textField(
                                                  controller: stepperController
                                                      .ageController,
                                                  hint: 'Age',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  // validator: (val) {
                                                  //   if (val == null ||
                                                  //       val.isEmpty) {
                                                  //     return 'Please enter your Age';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    NormalText(txtSex,
                                                        fontSize: 16,
                                                        color: AppColor.black),
                                                    NormalText("*",
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: SizedBox(
                                              height: 44,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                controller: ScrollController(),
                                                itemCount: stepperController
                                                    .itemsGender.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                    width: 120,
                                                    child: RadioListTile(
                                                      visualDensity:
                                                          VisualDensity(
                                                              horizontal: -4,
                                                              vertical: -4),
                                                      title: Text(
                                                          stepperController
                                                              .itemsGender[
                                                                  index]
                                                                  ['title']
                                                              .toString()),
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              right: 1),
                                                      activeColor:
                                                          AppColor.primary,
                                                      value: stoppingDrugList[
                                                              index]
                                                          .toString(),
                                                      groupValue:
                                                          stepperController
                                                              .genderRadioBtn,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          stepperController
                                                                  .genderRadioBtn =
                                                              value.toString();
                                                          stepperController
                                                                  .genderRadioValue =
                                                              stepperController
                                                                      .itemsGender[
                                                                  index]['title']!;
                                                          print(
                                                              "stepperController.stopDrugValueRadioBtn:-- ${stepperController.genderRadioValue}");
                                                        });
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: NormalText(txtNatureOfEvent,
                                                fontSize: 16,
                                                color: AppColor.black),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          SizedBox(
                                            height: 180,
                                            child: GridView.builder(
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 0,
                                                  childAspectRatio: 1 / 0.24,
                                                ),
                                                itemCount:
                                                    natureEventList.length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return CheckboxListTile(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 5,
                                                    ),
                                                    visualDensity:
                                                        VisualDensity(
                                                            horizontal: -4,
                                                            vertical: -4),
                                                    dense: true,
                                                    title: Text(
                                                        natureEventList[index]
                                                            ['value']),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    checkboxShape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    value: natureEventList[
                                                                index]
                                                            ['natureEvent'] ??
                                                        false,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        natureEventList[index][
                                                                'natureEvent'] =
                                                            value!;
                                                        // stepperController
                                                        //         .natureEventValue =
                                                        //     natureEventList[
                                                        //         index]['value'];

                                                        if (stepperController
                                                            .natureEventValue
                                                            .contains(
                                                                natureEventList[
                                                                        index][
                                                                    'value'])) {
                                                          stepperController
                                                              .natureEventValue
                                                              .remove(
                                                                  natureEventList[
                                                                          index]
                                                                      [
                                                                      'value']);
                                                        } else {
                                                          stepperController
                                                              .natureEventValue
                                                              .add(
                                                                  natureEventList[
                                                                          index]
                                                                      [
                                                                      'value']);
                                                        }
                                                      });
                                                    },
                                                  );
                                                }),
                                          ),

                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    NormalText(
                                                        txtDescribeReactions,
                                                        fontSize: 16,
                                                        color: AppColor.black),
                                                    NormalText("*",
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                textField(
                                                  controller: stepperController
                                                      .describeController,
                                                  hint:
                                                      'Describe adverse event',
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  maxLines: 8,
                                                  // validator: (val) {
                                                  //   if (val == null ||
                                                  //       val.isEmpty) {
                                                  //     return 'Please enter your Describe reactions';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtEventStartDate,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                    ),
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      controller: stepperController
                                                          .eventStartDateController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        14.0,
                                                                    horizontal:
                                                                        15),
                                                        fillColor:
                                                            AppColor.white,
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        isDense: true,
                                                        hintText:
                                                            'Event Start date',
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () async {
                                                            DateTime?
                                                                selectedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1900),
                                                                    lastDate:
                                                                        DateTime
                                                                            .now(),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return Theme(
                                                                        data: Theme.of(context)
                                                                            .copyWith(
                                                                          colorScheme:
                                                                              ColorScheme.light(
                                                                            primary:
                                                                                AppColor.primary.withOpacity(0.1),
                                                                            // header background color
                                                                            onPrimary:
                                                                                Colors.black,
                                                                            // header text color
                                                                            onSurface:
                                                                                Colors.black, // body text color
                                                                          ),
                                                                          textButtonTheme:
                                                                              TextButtonThemeData(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.black, // button text color
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    });
                                                            if (selectedDate !=
                                                                null) {
                                                              String
                                                                  formattedDate =
                                                                  "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                              stepperController
                                                                      .eventStartDateController
                                                                      .text =
                                                                  formattedDate;
                                                            }
                                                            print(
                                                                "DateController.text-- ${stepperController.eventStartDateController.text}");
                                                          },
                                                          child:
                                                              Transform.scale(
                                                            scale: 0.4,
                                                            child: SvgPicture
                                                                .asset(Images
                                                                    .calender),
                                                          ),
                                                        ),
                                                        errorMaxLines: 2,
                                                        errorStyle:
                                                            const TextStyle(
                                                                height: 0,
                                                                fontSize: 10),
                                                        hintStyle: TextStyle(
                                                          color:
                                                              AppColor.purple,
                                                          fontSize: 15,
                                                          fontFamily: 'Rubik',
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtEventLater,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                  height: 44,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .lightPurple)),
                                                  child: Center(
                                                    child: DropdownButton(
                                                      value: stepperController
                                                          .dropdownEventLater,
                                                      isExpanded: true,
                                                      underline:
                                                          const SizedBox(),
                                                      isDense: true,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      hint: Text(
                                                        "Select Event Later",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .purple),
                                                      ),
                                                      items: stepperController
                                                          .dropdownEventLaterList
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: NormalText(
                                                              items.toString(),
                                                              fontSize: 15,
                                                              color: AppColor
                                                                  .purple),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          stepperController
                                                                  .dropdownEventLater =
                                                              newValue!;
                                                          print(
                                                              "DROP EVENTS:-- ${stepperController.dropdownEventLater}");
                                                          if (stepperController
                                                                  .dropdownEventLater ==
                                                              'Other') {
                                                            setState(() {
                                                              stepperController
                                                                      .eventLaterOther =
                                                                  true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              stepperController
                                                                      .eventLaterOther =
                                                                  false;
                                                            });
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Visibility(
                                                  visible: stepperController
                                                      .eventLaterOther,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 2.h),
                                                    child: TextFormField(
                                                      controller: stepperController
                                                          .eventLaterOtherController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        14.0,
                                                                    horizontal:
                                                                        15),
                                                        fillColor:
                                                            AppColor.white,
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        isDense: true,
                                                        hintText: 'Type here',
                                                        errorMaxLines: 2,
                                                        errorStyle:
                                                            const TextStyle(
                                                                height: 0,
                                                                fontSize: 10),
                                                        hintStyle: TextStyle(
                                                          color:
                                                              AppColor.purple,
                                                          fontSize: 15,
                                                          fontFamily: 'Rubik',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(left: 10),
                                          //   child: NormalText(
                                          //       txtAdverseReactions,
                                          //       fontSize: 16,
                                          //       color: AppColor.black),
                                          // ),
                                          // SizedBox(
                                          //   height: 220,
                                          //   child: ListView.builder(
                                          //       itemCount:
                                          //           describeReactionList.length,
                                          //       shrinkWrap: true,
                                          //       itemBuilder:
                                          //           (BuildContext context,
                                          //               index) {
                                          //         return ListTile(
                                          //           title: CheckboxListTile(
                                          //             title: Text(
                                          //                 describeReactionList[
                                          //                     index]['value']),
                                          //             controlAffinity:
                                          //                 ListTileControlAffinity
                                          //                     .leading,
                                          //             checkboxShape:
                                          //                 RoundedRectangleBorder(
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(3),
                                          //             ),
                                          //             contentPadding:
                                          //                 const EdgeInsets.only(
                                          //                     right: 50),
                                          //             value:
                                          //                 describeReactionList[
                                          //                             index]
                                          //                         ['checked'] ??
                                          //                     false,
                                          //             onChanged: (bool? value) {
                                          //               setState(() {
                                          //                 describeReactionList[
                                          //                             index]
                                          //                         ['checked'] =
                                          //                     value!;
                                          //                 stepperController
                                          //                         .describeReactionValue =
                                          //                     describeReactionList[
                                          //                             index]
                                          //                         ['value'];
                                          //                 print(
                                          //                     "describeReactionList:== ${stepperController.describeReactionValue}");
                                          //               });
                                          //             },
                                          //           ),
                                          //         );
                                          //       }),
                                          // ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : (lastIndex == 0)
                                ? Form(
                                    key: stepper2FormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Row(
                                              children: [
                                                NormalText(txtSuspectDrugs,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                NormalText("*",
                                                    fontSize: 16,
                                                    color: Colors.red),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(left: 5),
                                          //   child: SizedBox(
                                          //     height: 100,
                                          //     child: GridView.builder(
                                          //         shrinkWrap: true,
                                          //         gridDelegate:
                                          //             const SliverGridDelegateWithFixedCrossAxisCount(
                                          //           crossAxisCount: 2,
                                          //           crossAxisSpacing: 0,
                                          //           childAspectRatio: 1 / 0.20,
                                          //         ),
                                          //         itemCount:
                                          //             suspectDrugList.length,
                                          //         physics:
                                          //             NeverScrollableScrollPhysics(),
                                          //         itemBuilder:
                                          //             (context, index) {
                                          //           return CheckboxListTile(
                                          //             contentPadding:
                                          //                 EdgeInsets.only(
                                          //               left: -20,
                                          //             ),
                                          //             checkboxShape:
                                          //                 RoundedRectangleBorder(
                                          //               borderRadius:
                                          //                   BorderRadius
                                          //                       .circular(3),
                                          //             ),
                                          //             visualDensity:
                                          //                 VisualDensity(
                                          //                     horizontal: -4,
                                          //                     vertical: -4),
                                          //             dense: true,
                                          //             title: NormalText(
                                          //                 suspectDrugList[index]
                                          //                     ['title'],
                                          //                 fontSize: 16,
                                          //                 color:
                                          //                     AppColor.black),
                                          //             controlAffinity:
                                          //                 ListTileControlAffinity
                                          //                     .leading,
                                          //             value: suspectDrugList[
                                          //                         index]
                                          //                     ['suspectDrug'] ??
                                          //                 false,
                                          //             onChanged: (bool? value) {
                                          //               setState(() {
                                          //                 suspectDrugList[index]
                                          //                         [
                                          //                         'suspectDrug'] =
                                          //                     value!;

                                          //                 if (stepperController
                                          //                     .suspectDrugsId
                                          //                     .contains(
                                          //                         suspectDrugList[
                                          //                                 index]
                                          //                             ['id'])) {
                                          //                   stepperController
                                          //                       .suspectDrugsId
                                          //                       .remove(
                                          //                           suspectDrugList[
                                          //                                   index]
                                          //                               ['id']);
                                          //                 } else {
                                          //                   stepperController
                                          //                       .suspectDrugsId
                                          //                       .add(suspectDrugList[
                                          //                               index]
                                          //                           ['id']);
                                          //                 }
                                          //                 // stepperController
                                          //                 //     .suspectDrugsId
                                          //                 //     .add(stepperController
                                          //                 //             .suspectDrugList![
                                          //                 //         index]['id']);
                                          //               });
                                          //             },
                                          //           );
                                          //         }),
                                          //   ),
                                          // ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Container(
                                              height: 44,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              decoration: BoxDecoration(
                                                  color: AppColor.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColor
                                                          .lightPurple)),
                                              child: Center(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButton2<Object>(
                                                    value: stepperController
                                                            .selectedDrugsItems
                                                            .isEmpty
                                                        ? null
                                                        : stepperController
                                                            .selectedDrugsItems
                                                            .last,
                                                    isExpanded: true,
                                                    underline: const SizedBox(),
                                                    isDense: true,
                                                    hint: Text(
                                                      txtSuspectDrugs,
                                                      style: TextStyle(
                                                          color:
                                                              AppColor.purple),
                                                    ),
                                                    items: suspectDrugList
                                                        .map((item) {
                                                      return DropdownMenuItem(
                                                        value: item,
                                                        enabled: false,
                                                        child: StatefulBuilder(
                                                          builder: (context,
                                                              menuSetState) {
                                                            final _isSelected =
                                                                stepperController
                                                                    .suspectDrugsId
                                                                    .contains(item[
                                                                        'id']);
                                                            return InkWell(
                                                              onTap: () {
                                                                stepperController
                                                                    .suspectDrugsId = [];
                                                                stepperController
                                                                    .selectedDrugsItems = [];
                                                                stepperController
                                                                    .selectedDrugsItemsName = [];

                                                                _isSelected
                                                                    ? stepperController
                                                                        .selectedDrugsItems
                                                                        .remove(
                                                                            item)
                                                                    : stepperController
                                                                        .selectedDrugsItems
                                                                        .add(
                                                                            item);
                                                                _isSelected
                                                                    ? stepperController
                                                                        .suspectDrugsId
                                                                        .remove(item[
                                                                            'id'])
                                                                    : stepperController
                                                                        .suspectDrugsId
                                                                        .add(item[
                                                                            'id']);
                                                                _isSelected
                                                                    ? stepperController
                                                                        .selectedDrugsItemsName
                                                                        .remove(item[
                                                                            'title'])
                                                                    : stepperController
                                                                        .selectedDrugsItemsName
                                                                        .add(item[
                                                                            'title']);
                                                                //This rebuilds the StatefulWidget to update the button's text
                                                                setState(() {});
                                                                //This rebuilds the dropdownMenu Widget to update the check mark
                                                                menuSetState(
                                                                    () {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                                child: Row(
                                                                  children: [
                                                                    NormalText(
                                                                        item[
                                                                            'title'],
                                                                        fontSize:
                                                                            15,
                                                                        color: AppColor
                                                                            .purple),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {},
                                                    selectedItemBuilder:
                                                        (context) {
                                                      return suspectDrugList
                                                          .map(
                                                        (item) {
                                                          return Container(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            child: Text(
                                                              stepperController
                                                                  .selectedDrugsItemsName
                                                                  .join(', '),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                          );
                                                        },
                                                      ).toList();
                                                    },
                                                    dropdownSearchData:
                                                        DropdownSearchData(
                                                      searchController:
                                                          stepperController
                                                              .drugValue,
                                                      searchInnerWidgetHeight:
                                                          50,
                                                      searchInnerWidget:
                                                          Container(
                                                        height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 8,
                                                          bottom: 4,
                                                          right: 8,
                                                          left: 8,
                                                        ),
                                                        child: TextFormField(
                                                          expands: true,
                                                          maxLines: null,
                                                          controller:
                                                              stepperController
                                                                  .drugValue,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10,
                                                              vertical: 8,
                                                            ),
                                                            hintText:
                                                                'Search for an Drugs...',
                                                            hintStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      searchMatchFn:
                                                          (item, searchValue) {
                                                        return (item.value
                                                            .toString()
                                                            .contains(searchValue
                                                                .capitalize!));
                                                      },
                                                    ),
                                                    onMenuStateChange:
                                                        (isOpen) {
                                                      if (!isOpen) {
                                                        stepperController
                                                            .drugValue
                                                            .clear();
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                NormalText(txtDailyDoses,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                textField(
                                                  controller: stepperController
                                                      .dailyDoesController,
                                                  hint: 'Daily Dosage',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  // validator: (val) {
                                                  //   if (val == null || val.isEmpty) {
                                                  //     return 'Please enter your Daily doses';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtIndicationForUse,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                textField(
                                                  controller: stepperController
                                                      .indicationController,
                                                  hint: 'Indication for use',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  // validator: (val) {
                                                  //   if (val == null || val.isEmpty) {
                                                  //     return 'Please enter your Indication for use';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    NormalText(txtBatchNo,
                                                        fontSize: 16,
                                                        color: AppColor.black),
                                                    NormalText("*",
                                                        fontSize: 16,
                                                        color: Colors.red),
                                                  ],
                                                ),
                                                textField(
                                                  controller: stepperController
                                                      .batchNoController,
                                                  hint: 'Batch No',
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  // validator: (val) {
                                                  //   if (val == null ||
                                                  //       val.isEmpty) {
                                                  //     return 'Please enter your Batch No';
                                                  //   }
                                                  // },
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtExpiryDate,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                    ),
                                                    child: TextFormField(
                                                      readOnly: true,
                                                      controller: stepperController
                                                          .expiryDateController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        14.0,
                                                                    horizontal:
                                                                        15),
                                                        fillColor:
                                                            AppColor.white,
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        isDense: true,
                                                        hintText: 'Expiry date',
                                                        suffixIcon:
                                                            GestureDetector(
                                                          onTap: () async {
                                                            DateTime?
                                                                selectedDate =
                                                                await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            1900),
                                                                    lastDate:
                                                                        DateTime(
                                                                            2100),
                                                                    builder:
                                                                        (context,
                                                                            child) {
                                                                      return Theme(
                                                                        data: Theme.of(context)
                                                                            .copyWith(
                                                                          colorScheme:
                                                                              ColorScheme.light(
                                                                            primary:
                                                                                AppColor.primary.withOpacity(0.1),
                                                                            // header background color
                                                                            onPrimary:
                                                                                Colors.black,
                                                                            // header text color
                                                                            onSurface:
                                                                                Colors.black, // body text color
                                                                          ),
                                                                          textButtonTheme:
                                                                              TextButtonThemeData(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.black, // button text color
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            child!,
                                                                      );
                                                                    });
                                                            if (selectedDate !=
                                                                null) {
                                                              String
                                                                  formattedDate =
                                                                  "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                              stepperController
                                                                      .expiryDateController
                                                                      .text =
                                                                  formattedDate;
                                                            }
                                                            print(
                                                                "DateController.text-- ${stepperController.expiryDateController.text}");
                                                          },
                                                          child:
                                                              Transform.scale(
                                                            scale: 0.4,
                                                            child: SvgPicture
                                                                .asset(Images
                                                                    .calender),
                                                          ),
                                                        ),
                                                        errorMaxLines: 2,
                                                        errorStyle:
                                                            const TextStyle(
                                                                height: 0,
                                                                fontSize: 10),
                                                        hintStyle: TextStyle(
                                                          color:
                                                              AppColor.purple,
                                                          fontSize: 15,
                                                          fontFamily: 'Rubik',
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtTherapyDate,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                          height: 44,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                AppColor.white,
                                                          ),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                stepperController
                                                                    .therapyDateController,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          14.0,
                                                                      horizontal:
                                                                          15),
                                                              fillColor:
                                                                  AppColor
                                                                      .white,
                                                              filled: true,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .lightPurple,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .lightPurple,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: AppColor
                                                                            .secondary,
                                                                        width:
                                                                            3,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                              isDense: true,
                                                              hintText:
                                                                  'Drug start date',
                                                              suffixIcon:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  DateTime?
                                                                      selectedDate =
                                                                      await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime(
                                                                              1900),
                                                                          lastDate: DateTime
                                                                              .now(),
                                                                          builder:
                                                                              (context, child) {
                                                                            return Theme(
                                                                              data: Theme.of(context).copyWith(
                                                                                colorScheme: ColorScheme.light(
                                                                                  primary: AppColor.primary.withOpacity(0.1),
                                                                                  // header background color
                                                                                  onPrimary: Colors.black,
                                                                                  // header text color
                                                                                  onSurface: Colors.black, // body text color
                                                                                ),
                                                                                textButtonTheme: TextButtonThemeData(
                                                                                  style: TextButton.styleFrom(
                                                                                    foregroundColor: Colors.black, // button text color
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: child!,
                                                                            );
                                                                          });
                                                                  if (selectedDate !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      selectedTherapyStartDate =
                                                                          selectedDate;
                                                                    });
                                                                    print(
                                                                        "selectedTherapyStartDate : $selectedTherapyStartDate");
                                                                    String
                                                                        formattedDate =
                                                                        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                                    stepperController
                                                                            .therapyDateController
                                                                            .text =
                                                                        formattedDate;
                                                                  }
                                                                  print(
                                                                      "DateController.text-- ${stepperController.therapyDateController.text}");
                                                                },
                                                                child: Transform
                                                                    .scale(
                                                                  scale: 0.4,
                                                                  child: SvgPicture
                                                                      .asset(Images
                                                                          .calender),
                                                                ),
                                                              ),
                                                              errorMaxLines: 2,
                                                              errorStyle:
                                                                  const TextStyle(
                                                                      height: 0,
                                                                      fontSize:
                                                                          10),
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: AppColor
                                                                    .purple,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Rubik',
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                          height: 44,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                AppColor.white,
                                                          ),
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            controller:
                                                                stepperController
                                                                    .therapyDateControllerStopDate,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.symmetric(
                                                                      vertical:
                                                                          14.0,
                                                                      horizontal:
                                                                          15),
                                                              fillColor:
                                                                  AppColor
                                                                      .white,
                                                              filled: true,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .lightPurple,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: AppColor
                                                                      .lightPurple,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              isDense: true,
                                                              hintText:
                                                                  'Drug stop date',
                                                              suffixIcon:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  DateTime?
                                                                      selectedDate =
                                                                      await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate: selectedTherapyStartDate ??
                                                                              DateTime
                                                                                  .now(),
                                                                          firstDate: selectedTherapyStartDate ??
                                                                              DateTime(
                                                                                  1900),
                                                                          lastDate: DateTime(
                                                                              2100),
                                                                          builder:
                                                                              (context, child) {
                                                                            return Theme(
                                                                              data: Theme.of(context).copyWith(
                                                                                colorScheme: ColorScheme.light(
                                                                                  primary: AppColor.primary.withOpacity(0.1),
                                                                                  // header backg00round color
                                                                                  onPrimary: Colors.black,
                                                                                  // header text color
                                                                                  onSurface: Colors.black, // body text color
                                                                                ),
                                                                                textButtonTheme: TextButtonThemeData(
                                                                                  style: TextButton.styleFrom(
                                                                                    foregroundColor: Colors.black, // button text color
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              child: child!,
                                                                            );
                                                                          });
                                                                  if (selectedDate !=
                                                                      null) {
                                                                    String
                                                                        formattedDate =
                                                                        "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                                    stepperController
                                                                            .therapyDateControllerStopDate
                                                                            .text =
                                                                        formattedDate;
                                                                  }
                                                                  print(
                                                                      "DateController.text-- ${stepperController.therapyDateControllerStopDate.text}");
                                                                },
                                                                child: Transform
                                                                    .scale(
                                                                  scale: 0.4,
                                                                  child: SvgPicture
                                                                      .asset(Images
                                                                          .calender),
                                                                ),
                                                              ),
                                                              errorMaxLines: 2,
                                                              errorStyle:
                                                                  const TextStyle(
                                                                      height: 0,
                                                                      fontSize:
                                                                          10),
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: AppColor
                                                                    .purple,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    'Rubik',
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtTherapyDuration,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                    ),
                                                    child: TextFormField(
                                                      controller: stepperController
                                                          .therapyDurationController,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        14.0,
                                                                    horizontal:
                                                                        15),
                                                        fillColor:
                                                            AppColor.white,
                                                        filled: true,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                            color: AppColor
                                                                .lightPurple,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: AppColor
                                                                      .secondary,
                                                                  width: 3,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        isDense: true,
                                                        hintText:
                                                            'Therapy duration',
                                                        // suffixIcon:
                                                        //     GestureDetector(
                                                        //   onTap: () async {
                                                        //     DateTime?
                                                        //         selectedDate =
                                                        //         await showDatePicker(
                                                        //             context:
                                                        //                 context,
                                                        //             initialDate:
                                                        //                 DateTime
                                                        //                     .now(),
                                                        //             firstDate:
                                                        //                 DateTime(
                                                        //                     1900),
                                                        //             lastDate:
                                                        //                 DateTime(
                                                        //                     2100),
                                                        //             builder:
                                                        //                 (context,
                                                        //                     child) {
                                                        //               return Theme(
                                                        //                 data: Theme.of(context)
                                                        //                     .copyWith(
                                                        //                   colorScheme:
                                                        //                       ColorScheme.light(
                                                        //                     primary:
                                                        //                         AppColor.primary.withOpacity(0.1),
                                                        //                     // header background color
                                                        //                     onPrimary:
                                                        //                         Colors.black,
                                                        //                     // header text color
                                                        //                     onSurface:
                                                        //                         Colors.black, // body text color
                                                        //                   ),
                                                        //                   textButtonTheme:
                                                        //                       TextButtonThemeData(
                                                        //                     style:
                                                        //                         TextButton.styleFrom(
                                                        //                       foregroundColor: Colors.black, // button text color
                                                        //                     ),
                                                        //                   ),
                                                        //                 ),
                                                        //                 child:
                                                        //                     child!,
                                                        //               );
                                                        //             });
                                                        //     if (selectedDate !=
                                                        //         null) {
                                                        //       String
                                                        //           formattedDate =
                                                        //           "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                        //       stepperController
                                                        //               .therapyDurationController
                                                        //               .text =
                                                        //           formattedDate;
                                                        //     }
                                                        //     print(
                                                        //         "DateController.text-- ${stepperController.therapyDurationController.text}");
                                                        //   },
                                                        //   child:
                                                        //       Transform.scale(
                                                        //     scale: 0.4,
                                                        //     child: SvgPicture
                                                        //         .asset(Images
                                                        //             .calender),
                                                        //   ),
                                                        // ),
                                                        errorMaxLines: 2,
                                                        errorStyle:
                                                            const TextStyle(
                                                                height: 0,
                                                                fontSize: 10),
                                                        hintStyle: TextStyle(
                                                          color:
                                                              AppColor.purple,
                                                          fontSize: 15,
                                                          fontFamily: 'Rubik',
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(
                                                    txtRoutsOfAdministration,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                  height: 44,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .lightPurple)),
                                                  child: Center(
                                                    child: DropdownButton(
                                                      value: stepperController
                                                          .dropdownRoutesofAdValue,
                                                      isExpanded: true,
                                                      underline:
                                                          const SizedBox(),
                                                      isDense: true,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      hint: Text(
                                                        "Routes of Administration",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .purple),
                                                      ),
                                                      items: routsOfAdList
                                                          .map((item) {
                                                        return DropdownMenuItem(
                                                          value: item['value'],
                                                          child: NormalText(
                                                              item['value'],
                                                              fontSize: 15,
                                                              color: AppColor
                                                                  .purple),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          stepperController
                                                                  .dropdownRoutesofAdValue =
                                                              newValue!;
                                                          stepperController
                                                                  .routesOfAdValues =
                                                              stepperController
                                                                  .dropdownRoutesofAdValue;
                                                          if (stepperController
                                                                  .routesOfAdValues ==
                                                              'Other') {
                                                            setState(() {
                                                              stepperController
                                                                      .isRoutesAdOther =
                                                                  true;
                                                            });
                                                          } else {
                                                            setState(() {
                                                              stepperController
                                                                      .isRoutesAdOther =
                                                                  false;
                                                            });
                                                          }
                                                          print(
                                                              "Stepper DropDown:== ${stepperController.routesOfAdValues}");
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                    visible: stepperController
                                                        .isRoutesAdOther,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 2.h),
                                                      child: TextFormField(
                                                        controller:
                                                            stepperController
                                                                .routesOfAdtOtherController,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          14.0,
                                                                      horizontal:
                                                                          15),
                                                          fillColor:
                                                              AppColor.white,
                                                          filled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color: AppColor
                                                                  .lightPurple,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              width: 1,
                                                              color: AppColor
                                                                  .lightPurple,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: AppColor
                                                                        .secondary,
                                                                    width: 3,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8)),
                                                          isDense: true,
                                                          hintText: 'Type here',
                                                          errorMaxLines: 2,
                                                          errorStyle:
                                                              const TextStyle(
                                                                  height: 0,
                                                                  fontSize: 10),
                                                          hintStyle: TextStyle(
                                                            color:
                                                                AppColor.purple,
                                                            fontSize: 15,
                                                            fontFamily: 'Rubik',
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                NormalText(txtResolutionEvent,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                  height: 44,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .lightPurple)),
                                                  child: Center(
                                                    child: DropdownButton(
                                                      value: stepperController
                                                          .dropdownResoulutionValue,
                                                      isExpanded: true,
                                                      underline:
                                                          const SizedBox(),
                                                      isDense: true,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      hint: Text(
                                                        txtResolutionEvent,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .purple),
                                                      ),
                                                      items: resolutionList
                                                          .map((item) {
                                                        return DropdownMenuItem(
                                                          value: item['value'],
                                                          child: NormalText(
                                                              item['value'],
                                                              fontSize: 15,
                                                              color: AppColor
                                                                  .purple),
                                                        );
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          stepperController
                                                                  .dropdownResoulutionValue =
                                                              newValue;
                                                          stepperController
                                                                  .resolutionValues =
                                                              stepperController
                                                                  .dropdownResoulutionValue;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                NormalText(
                                                    txtDidReactionAbateAfterStoppingDrug,
                                                    fontSize: 16,
                                                    color: AppColor.black),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: SizedBox(
                                              height: 100,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 0,
                                                    childAspectRatio: 1 / 0.25,
                                                  ),
                                                  itemCount:
                                                      stoppingDrugList.length,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      width: 118,
                                                      child: RadioListTile(
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: -4,
                                                                vertical: -4),
                                                        title: Text(
                                                            stoppingDrugList[
                                                                        index]
                                                                    ['value']
                                                                .toString()),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        activeColor:
                                                            AppColor.primary,
                                                        value: stoppingDrugList[
                                                                index]
                                                            .toString(),
                                                        groupValue:
                                                            stepperController
                                                                .stopDrugValueRadioBtn,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            stepperController
                                                                    .stopDrugValueRadioBtn =
                                                                value
                                                                    .toString();
                                                            stepperController
                                                                    .stoppingDrugValue =
                                                                stoppingDrugList[
                                                                        index]
                                                                    ['value'];
                                                            print(
                                                                "stepperController.stopDrugValueRadioBtn:-- ${stepperController.stoppingDrugValue}");
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: NormalText(
                                                txtDidReactionAppearsAfterReintroduction,
                                                fontSize: 16,
                                                color: AppColor.black),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: SizedBox(
                                              height: 90,
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 0,
                                                    childAspectRatio: 1 / 0.25,
                                                  ),
                                                  itemCount: reIntroList.length,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      width: 115,
                                                      child: RadioListTile(
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: -4,
                                                                vertical: -4),
                                                        title: Text(
                                                            reIntroList[index]
                                                                    ['value']
                                                                .toString()),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        activeColor:
                                                            AppColor.primary,
                                                        value:
                                                            reIntroList[index]
                                                                .toString(),
                                                        groupValue:
                                                            stepperController
                                                                .reIntroValueRadioBtn,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            stepperController
                                                                    .reIntroValueRadioBtn =
                                                                value
                                                                    .toString();
                                                            stepperController
                                                                    .stoppingReIntroValue =
                                                                reIntroList[
                                                                        index]
                                                                    ['value'];
                                                            print(
                                                                "stepperController.reIntroValueRadioBtn:-- ${stepperController.stoppingReIntroValue}");
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : (lastIndex == 1)
                                    ? Form(
                                        key: stepper4FormKey,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              NormalText(
                                                  txtOtherRelevantHistory,
                                                  fontSize: 16,
                                                  color: AppColor.black),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              textField2(
                                                controller: stepperController
                                                    .relevantHistoryController,
                                                hint: 'Type here',
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 8,
                                                // validator: (val) {
                                                //   if (val == null ||
                                                //       val.isEmpty) {
                                                //     return 'Please enter your Relevant history';
                                                //   }
                                                // },
                                              ),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              NormalText(
                                                  txtConcomitantDrugsAndDateOfAdministration,
                                                  fontSize: 16,
                                                  color: AppColor.black),
                                              NormalText(
                                                "(Name, Dose, regimen, dates, Indication)",
                                                fontSize: 14,
                                                color: AppColor.purple,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              textField2(
                                                controller: stepperController
                                                    .dateOfAdministrationController,
                                                hint: 'Type here',
                                                textInputAction:
                                                    TextInputAction.done,
                                                maxLines: 8,
                                                // validator: (val) {
                                                //   if (val == null ||
                                                //       val.isEmpty) {
                                                //     return 'Please enter your Concomitant drugs';
                                                //   }
                                                // },
                                              ),
                                              // NormalText(txtDummy2, fontSize: 14, color: AppColor.purple),
                                            ],
                                          ),
                                        ),
                                      )
                                    : (lastIndex == 2)
                                        ? Form(
                                            key: stepper3FormKey,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        NormalText(
                                                            txtNameAndAddressOfManufacturer,
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        textField2(
                                                          controller:
                                                              stepperController
                                                                  .addressController,
                                                          hint: 'Type here',
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          maxLines: 8,
                                                          // validator: (val) {
                                                          //   if (val == null ||
                                                          //       val.isEmpty) {
                                                          //     return 'Please enter your Address';
                                                          //   }
                                                          // },
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        NormalText(
                                                            txtReportType,
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black),
                                                      ],
                                                    ),
                                                  ),

                                                  // SizedBox(height: 2.h,),
                                                  // NormalText(txtDateReceivedByManufacturer, fontSize: 16, color: AppColor.black),
                                                  // textField(
                                                  //     controller: stepperController.manufacturerDateController,readOnly: true,
                                                  //     validator: (val){
                                                  //       if(val == null || val.isEmpty){
                                                  //         return 'Please selected your Manufacturer Date';
                                                  //       }
                                                  //     },
                                                  //     hint: 'dd/mm/yy',suffixIcon: GestureDetector(
                                                  //   onTap: ()async {
                                                  //     DateTime? selectedDate = await showDatePicker(
                                                  //         context: context,
                                                  //         initialDate: DateTime.now(),
                                                  //         firstDate: DateTime(2000),
                                                  //         lastDate: DateTime(2100),
                                                  //         builder: (context , child){
                                                  //           return Theme(
                                                  //             data: Theme.of(context).copyWith(
                                                  //               colorScheme: ColorScheme.light(
                                                  //                 primary: AppColor.primary.withOpacity(0.1), // header background color
                                                  //                 onPrimary: Colors.black, // header text color
                                                  //                 onSurface: Colors.black, // body text color
                                                  //               ),
                                                  //               textButtonTheme: TextButtonThemeData(
                                                  //                 style: TextButton.styleFrom(
                                                  //                   foregroundColor: Colors.black, // button text color
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             child: child!,
                                                  //           );
                                                  //         }
                                                  //     );
                                                  //     if (selectedDate != null) {
                                                  //       String formattedDate =
                                                  //           "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                  //       stepperController.manufacturerDateController.text = formattedDate;
                                                  //     }
                                                  //   },
                                                  //   child: Transform.scale(
                                                  //       scale: 0.4,
                                                  //       child: SvgPicture.asset(Images.calender)),
                                                  // )),
                                                  // SizedBox(height: 1.h,),
                                                  // NormalText(txtDateOfThisReport, fontSize: 16, color: AppColor.black),
                                                  // textField(
                                                  //     controller: stepperController.reportDateController,readOnly: true,
                                                  //     validator: (val){
                                                  //       if(val == null || val.isEmpty){
                                                  //         return 'Please selected your Report Date';
                                                  //       }
                                                  //     },
                                                  //     hint: 'dd/mm/yy',suffixIcon: GestureDetector(
                                                  //   onTap: ()async {
                                                  //     DateTime? selectedDate = await showDatePicker(
                                                  //         context: context,
                                                  //         initialDate: DateTime.now(),
                                                  //         firstDate: DateTime(2000),
                                                  //         lastDate: DateTime(2100),
                                                  //         builder: (context , child){
                                                  //           return Theme(
                                                  //             data: Theme.of(context).copyWith(
                                                  //               colorScheme: ColorScheme.light(
                                                  //                 primary: AppColor.primary.withOpacity(0.1), // header background color
                                                  //                 onPrimary: Colors.black, // header text color
                                                  //                 onSurface: Colors.black, // body text color
                                                  //               ),
                                                  //               textButtonTheme: TextButtonThemeData(
                                                  //                 style: TextButton.styleFrom(
                                                  //                   foregroundColor: Colors.black, // button text color
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             child: child!,
                                                  //           );
                                                  //         }
                                                  //     );
                                                  //     if (selectedDate != null) {
                                                  //       String formattedDate =
                                                  //           "${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
                                                  //       stepperController.reportDateController.text = formattedDate;
                                                  //     }
                                                  //   },
                                                  //   child: Transform.scale(
                                                  //       scale: 0.4,
                                                  //       child: SvgPicture.asset(Images.calender)),
                                                  // )),
                                                  // SizedBox(height: 1.h,),
                                                  // NormalText(txtMfrControlNo, fontSize: 16, color: AppColor.black),
                                                  // textField(controller: stepperController.mfrControlController,hint: 'Therapy date',  textInputAction: TextInputAction.done,
                                                  //   validator: (val){
                                                  //     if(val == null || val.isEmpty){
                                                  //       return 'Please enter your Therapy date';
                                                  //     }
                                                  //   },),
                                                  // SizedBox(height: 1.h,),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(left: 10),
                                                  //   child: NormalText(txtReportSource, fontSize: 16, color: AppColor.black),
                                                  // ),
                                                  // ListView.builder(
                                                  //   // scrollDirection: Axis.horizontal,
                                                  //   controller: ScrollController(),
                                                  //   itemCount: reportSourceList.length,
                                                  //   shrinkWrap: true,
                                                  //   itemBuilder: (context, index) {
                                                  //     return  Expanded(
                                                  //       child: SizedBox(
                                                  //         width: 152,
                                                  //         child: RadioListTile(title: NormalText(reportSourceList[index]['value'].toString(), fontSize: 16, color: AppColor.black),
                                                  //           contentPadding: const EdgeInsets.only(right: 10),
                                                  //           dense: true,
                                                  //           activeColor: AppColor.primary,
                                                  //           value: reIntroList[index].toString(),
                                                  //           groupValue: stepperController.reportSourceValueRadioBtn,
                                                  //           onChanged: (value) {
                                                  //             setState(() {
                                                  //               stepperController.reportSourceValueRadioBtn = value.toString();
                                                  //               stepperController.reportSourceValue = reportSourceList[index]['value'];
                                                  //               print("stepperController.reportSourceValueRadioBtn:-- ${stepperController.reportSourceValue}");
                                                  //             });
                                                  //           },
                                                  //         ),
                                                  //       ),
                                                  //     );
                                                  //   },
                                                  // ),
                                                  // // Column(
                                                  // //   children: [
                                                  // //     Row(
                                                  // //       mainAxisAlignment: MainAxisAlignment.start,
                                                  // //       children: <Widget>[
                                                  // //         Radio(
                                                  // //           value: 1,
                                                  // //           activeColor: AppColor.primary,
                                                  // //           groupValue: stepperController.reportSourceID,
                                                  // //           onChanged: (val) {
                                                  // //             setState(() {
                                                  // //               stepperController.reportSourceRadioBtn = 'STUDY';
                                                  // //               stepperController.reportSourceID = 1;
                                                  // //             });
                                                  // //           },
                                                  // //         ),
                                                  // //         Text(
                                                  // //           'STUDY',
                                                  // //           style: new TextStyle(fontSize: 17.0),
                                                  // //         ),
                                                  // //
                                                  // //         Radio(
                                                  // //           value: 2,
                                                  // //           activeColor: AppColor.primary,
                                                  // //           groupValue: stepperController.reportSourceID,
                                                  // //           onChanged: (val) {
                                                  // //             setState(() {
                                                  // //               stepperController.reportSourceRadioBtn = 'LITERATURE';
                                                  // //               stepperController.reportSourceID = 2;
                                                  // //             });
                                                  // //           },
                                                  // //         ),
                                                  // //         Text(
                                                  // //           'LITERATURE',
                                                  // //           style: new TextStyle(
                                                  // //             fontSize: 17.0,
                                                  // //           ),
                                                  // //         ),
                                                  // //       ],
                                                  // //     ),
                                                  // //     Row(
                                                  // //       children: [
                                                  // //         Radio(
                                                  // //           value: 3,
                                                  // //           activeColor: AppColor.primary,
                                                  // //           groupValue: stepperController.reportSourceID,
                                                  // //           onChanged: (val) {
                                                  // //             setState(() {
                                                  // //               stepperController.reportSourceRadioBtn = 'HEALTH PROFESSIONAL';
                                                  // //               stepperController.reportSourceID = 3;
                                                  // //             });
                                                  // //           },
                                                  // //         ),
                                                  // //         Text(
                                                  // //           'HEALTH PROFESSIONAL',
                                                  // //           style: new TextStyle(fontSize: 17.0),
                                                  // //         ),
                                                  // //       ],
                                                  // //     ),
                                                  // //
                                                  // //   ],
                                                  // // ),
                                                  // SizedBox(height: 1.h,),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: GridView.builder(
                                                      shrinkWrap: true,
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 0,
                                                        childAspectRatio:
                                                            1 / 0.25,
                                                      ),
                                                      itemCount:
                                                          reportTypeList.length,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          width: 142,
                                                          //   height: 100,
                                                          child: RadioListTile(
                                                            visualDensity:
                                                                VisualDensity(
                                                              horizontal: -4,
                                                            ),
                                                            title: NormalText(
                                                                reportTypeList[
                                                                            index]
                                                                        [
                                                                        'value']
                                                                    .toString(),
                                                                fontSize: 16,
                                                                color: AppColor
                                                                    .black),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10),
                                                            dense: true,
                                                            activeColor:
                                                                AppColor
                                                                    .primary,
                                                            value: reIntroList[
                                                                    index]
                                                                .toString(),
                                                            groupValue:
                                                                stepperController
                                                                    .reportTypeValueRadioBtn,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                stepperController
                                                                        .reportTypeValueRadioBtn =
                                                                    value
                                                                        .toString();
                                                                stepperController
                                                                        .reportTypeValue =
                                                                    reportTypeList[
                                                                            index]
                                                                        [
                                                                        'value'];
                                                                print(
                                                                    "stepperController.reportTypeValueRadioBtn:-- ${stepperController.reportTypeValue}");
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Row(
                                                  //   children: [
                                                  //     Expanded(
                                                  //       child: Column(
                                                  //         children: List.generate(
                                                  //           stepperController.reportSourceListItems.length,
                                                  //               (index) => Theme(
                                                  //             data: ThemeData(
                                                  //               checkboxTheme: CheckboxThemeData(
                                                  //                 shape: RoundedRectangleBorder(
                                                  //                   borderRadius: BorderRadius.circular(25),
                                                  //                 ),
                                                  //               ),
                                                  //               unselectedWidgetColor: const Color(0xFF95A1AC),
                                                  //             ),
                                                  //             child: CheckboxListTile(
                                                  //               controlAffinity: ListTileControlAffinity.leading,
                                                  //               contentPadding: EdgeInsets.zero,
                                                  //               checkboxShape: RoundedRectangleBorder(
                                                  //                 borderRadius: BorderRadius.circular(3),
                                                  //               ),
                                                  //               dense: true,
                                                  //               title: Text(
                                                  //                 stepperController.reportSourceListItems[index]["title"],
                                                  //                 style: const TextStyle(
                                                  //                   fontSize: 16.0,
                                                  //                   color: Colors.black,
                                                  //                 ),
                                                  //               ),
                                                  //               value: stepperController.reportSourceListItems[index]["value"],
                                                  //               onChanged: (value) {
                                                  //                 setState(() {
                                                  //                   stepperController.reportSourceListItems[index]["value"] = value;
                                                  //                   if (stepperController.multipleSelected.contains(stepperController.reportSourceListItems[index])) {
                                                  //                     stepperController.multipleSelected.remove(stepperController.reportSourceListItems[index]);
                                                  //                   } else {
                                                  //                     stepperController.multipleSelected.add(stepperController.reportSourceListItems[index]);
                                                  //                   }
                                                  //                 });
                                                  //               },
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //     Expanded(
                                                  //       child: Column(
                                                  //         children: List.generate(
                                                  //           stepperController.suspectListItems.length,
                                                  //               (index) => Theme(
                                                  //             data: ThemeData(
                                                  //               checkboxTheme: CheckboxThemeData(
                                                  //                 shape: RoundedRectangleBorder(
                                                  //                   borderRadius: BorderRadius.circular(25),
                                                  //                 ),
                                                  //               ),
                                                  //               unselectedWidgetColor: const Color(0xFF95A1AC),
                                                  //             ),
                                                  //             child: CheckboxListTile(
                                                  //               controlAffinity: ListTileControlAffinity.leading,
                                                  //               contentPadding: EdgeInsets.zero,
                                                  //               checkboxShape: RoundedRectangleBorder(
                                                  //                 borderRadius: BorderRadius.circular(3),
                                                  //               ),
                                                  //               dense: true,
                                                  //               title: Text(
                                                  //                 stepperController.reportSourceListItems[index]["title"],
                                                  //                 style: const TextStyle(
                                                  //                   fontSize: 16.0,
                                                  //                   color: Colors.black,
                                                  //                 ),
                                                  //               ),
                                                  //               value: stepperController.reportSourceListItems[index]["value"],
                                                  //               onChanged: (value) {
                                                  //                 setState(() {
                                                  //                   stepperController.reportSourceListItems[index]["value"] = value;
                                                  //                   if (stepperController.multipleSelected.contains(stepperController.reportSourceListItems[index])) {
                                                  //                     stepperController.multipleSelected.remove(stepperController.reportSourceListItems[index]);
                                                  //                   } else {
                                                  //                     stepperController.multipleSelected.add(stepperController.reportSourceListItems[index]);
                                                  //                   }
                                                  //                 });
                                                  //               },
                                                  //             ),
                                                  //           ),
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                                  //   children: <Widget>[
                                                  //     Radio(
                                                  //       value: 1,
                                                  //       activeColor: AppColor.primary,
                                                  //       groupValue: stepperController.reportTypeID,
                                                  //       onChanged: (val) {
                                                  //         setState(() {
                                                  //           stepperController.reportTypeRadioBtn = 'INITIAL';
                                                  //           stepperController.reportTypeID = 1;
                                                  //         });
                                                  //       },
                                                  //     ),
                                                  //     Text(
                                                  //       'INITIAL',
                                                  //       style: new TextStyle(fontSize: 17.0),
                                                  //     ),
                                                  //
                                                  //     Radio(
                                                  //       value: 2,
                                                  //       activeColor: AppColor.primary,
                                                  //       groupValue: stepperController.reportTypeID,
                                                  //       onChanged: (val) {
                                                  //         setState(() {
                                                  //           stepperController.reportTypeRadioBtn = 'FOLLOWUP';
                                                  //           stepperController.reportTypeID = 2;
                                                  //         });
                                                  //       },
                                                  //     ),
                                                  //     Text(
                                                  //       'FOLLOWUP',
                                                  //       style: new TextStyle(
                                                  //         fontSize: 17.0,
                                                  //       ),
                                                  //     ),
                                                  //
                                                  //
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : (lastIndex == 3)
                                            ? Form(
                                                key: stepper5FormKey,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        NormalText(txtComments,
                                                            fontSize: 16,
                                                            color:
                                                                AppColor.black),
                                                        SizedBox(
                                                          height: 1.h,
                                                        ),
                                                        textField(
                                                          controller:
                                                              stepperController
                                                                  .feedBackController,
                                                          hint: "Type here",
                                                          textInputAction:
                                                              TextInputAction
                                                                  .done,
                                                          maxLines: 4,
                                                          // validator: (val) {
                                                          //   if (val == null ||
                                                          //       val.isEmpty) {
                                                          //     return 'Please enter your Comments';
                                                          //   }
                                                          // },
                                                        ),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        Center(
                                                            child: NormalText(
                                                          "$txtUploadDocument (Select Multiple Files)",
                                                          fontSize: 16,
                                                          color: AppColor.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                        SizedBox(
                                                          height: 2.h,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            stepperController
                                                                .showActionSheet(
                                                                    context);
                                                          },
                                                          child: (stepperController
                                                                  .selectImage)
                                                              ? Container(
                                                                  // key: UniqueKey(),
                                                                  height: 30.h,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .lightPurple),
                                                                  ),
                                                                  child: Center(
                                                                    child: ListView.builder(
                                                                        itemCount: stepperController.userimage!.length,
                                                                        scrollDirection: Axis.horizontal,
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (BuildContext context, int index) {
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                ClipRRect(
                                                                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                              child: Stack(
                                                                                children: [
                                                                                  Image.file(File(stepperController.userimage![index].path)),
                                                                                  Positioned(
                                                                                    top: -15.0,
                                                                                    right: -15.0,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(3.0),
                                                                                      child: IconButton(
                                                                                        icon: Icon(
                                                                                          Icons.close,
                                                                                          color: Colors.red,
                                                                                        ),
                                                                                        onPressed: () {
                                                                                          setState(() {
                                                                                            stepperController.userimage!.removeAt(index);
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }),
                                                                  )
                                                                  //     Swiper(
                                                                  //   itemBuilder:
                                                                  //       (BuildContext context,
                                                                  //           int index) {
                                                                  //     return ClipRRect(
                                                                  //       borderRadius:
                                                                  //           const BorderRadius.only(bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                                                                  //       child:
                                                                  //           Image.file(File(stepperController.userimage![index].path)),
                                                                  //     );
                                                                  //   },
                                                                  //   itemCount: stepperController
                                                                  //       .userimage!
                                                                  //       .length,
                                                                  //   pagination:
                                                                  //       const SwiperPagination(),
                                                                  //   indicatorLayout:
                                                                  //       PageIndicatorLayout.COLOR,
                                                                  //   autoplay:
                                                                  //       true,
                                                                  //   autoplayDelay:
                                                                  //       6000,
                                                                  //   // control: SwiperControl(),
                                                                  // ),
                                                                  )
                                                              : Container(
                                                                  // key: UniqueKey(),
                                                                  height: 30.h,
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    border: Border.all(
                                                                        color: AppColor
                                                                            .lightPurple),
                                                                    color: AppColor
                                                                        .white,
                                                                  ),
                                                                  child: Transform
                                                                      .scale(
                                                                          scale:
                                                                              0.5,
                                                                          child:
                                                                              SvgPicture.asset(
                                                                            Images.pickFile,
                                                                          )),
                                                                ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                        stepperController.isLoading
                            ? loaderButton()
                            : (lastIndex == 3)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      customButtonNew(
                                          title: "Save Draft",
                                          onTap: () {
                                            saveDraft();
                                          }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      customButtonNew(
                                          title: txtSubmit,
                                          onTap: () {
                                            stepper();
                                          }),
                                      SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                : stepperController.isLoading
                                    ? loaderButton()
                                    : customButton(
                                        title: txtNext,
                                        onTap: () {
                                          stepper();
                                        }),
                      ],
                    ),
                  ),
          ),
        ),
      );
    });
  }

  stepper() async {
    print("Step : 1");
    if (lastIndex == -1) {
      print("Step : 2");
      if (stepper1FormKey.currentState!.validate()) {
        setState(() {
          stepperController.isLoading = true;
          curIndex++;
        });
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {
              lastIndex++;
              stepperController.isLoading = false;
            });
          },
        );
        // print("Step : 3");
        // if (stepperController.genderRadioBtn != '') {
        //   print("Step : 4");
        //   if (stepperController.dropdownCountryValue != null) {
        //     print("Step : 5");

        //     //       if(stepperController.describeReactionValue != ''){
        //     //
        //     //       }
        //     //    else{
        //     //      showMsg(context,msg: 'Selected your describe reactions',color: Colors.red);
        //     //       }
        //   }
        //   else {
        //     print("Step : 6");
        //     showMsg(context, msg: 'Selected your country', color: Colors.red);
        //   }
        // }
        // else {
        //   print("Step : 7");
        //   showMsg(context, msg: 'Selected your gender', color: Colors.red);
        // }
      }
    } else if (lastIndex == 0) {
      if (stepper2FormKey.currentState!.validate()) {
        setState(() {
          stepperController.isLoading = true;
          curIndex++;
        });
        Future.delayed(
          const Duration(seconds: 1),
          () {
            setState(() {
              lastIndex++;
              stepperController.isLoading = false;
            });
          },
        );
        // if (stepperController.suspectDrugsId != "") {

        //   //     if(stepperController.stoppingDrugValue != ''){
        //   //       if(stepperController.stoppingReIntroValue != ''){
        //   //
        //   //       }
        //   //       else{
        //   //         showMsg(context,msg: 'Selected your re-introduction',color: Colors.red);
        //   //       }
        //   //     }
        //   //    else{
        //   //       showMsg(context,msg: 'Selected your stopping drug',color: Colors.red);
        //   //     }
        // } else {
        //   showMsg(context,
        //       msg: 'Selected your suspect drugs', color: Colors.red);
        // }
      }
    } else if (lastIndex == 1) {
      // if(stepperController.stepper4FormKey.currentState!.validate()){
      //
      // }
      setState(() {
        curIndex++;

        stepperController.isLoading = true;
      });
      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(() {
            lastIndex++;
            stepperController.isLoading = false;
          });
        },
      );
    } else if (lastIndex == 2) {
      // if(stepperController.stepper3FormKey.currentState!.validate()){
      //   if(stepperController.reportSourceValue != ''){
      //     if(stepperController.reportTypeValue != ''){
      //
      //     }
      //    else{
      //       showMsg(context,msg: 'Selected your report type',color: Colors.red);
      //     }
      //   }else{
      //     showMsg(context,msg: 'Selected your report source',color: Colors.red);
      //   }
      // }
      setState(() {
        stepperController.isLoading = true;
        curIndex++;
      });
      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(() {
            lastIndex++;
            stepperController.isLoading = false;
          });
        },
      );
    } else if (lastIndex == 3) {
      // if(stepperController.stepper5FormKey.currentState!.validate()){
      //
      // }

      if (stepperController.ageController.text != '' &&
          stepperController.describeController.text != '' &&
          stepperController.genderRadioBtn != '' &&
          stepperController.dropdownCountryValue != null &&
          stepperController.batchNoController.text != '' &&
          stepperController.suspectDrugsId.length > 0) {
        setState(() {
          stepperController.isLoading = true;
          stepperController.isLoader = true;
          curIndex++;
        });
        stepperController.formStoreAPI().then((res) {
          if (res['status']) {
            showMsg(context, msg: res['message'], color: Colors.green);
            stepperController.isLoading = false;
            stepperController.dateController.text = "";
            stepperController.eventStartDateController.text = "";
            stepperController.patentInitialsController.text = "";
            stepperController.dropdownCountryValue;
            stepperController.phone = "";
            stepperController.usertype = "";
            stepperController.dropdownResoulutionValue;
            stepperController.dropdownRoutesofAdValue;
            stepperController.dropdownEventLater;
            natureEventList = [];
            stoppingDrugList = [];
            reIntroList = [];
            describeReactionList = [];
            reportSourceList = [];
            reportTypeList = [];
            routsOfAdList = [];
            resolutionList = [];
            suspectDrugList = [];
            stepperController.suspectDrugsId = [];
            stepperController.selectedDrugsItems = [];
            stepperController.selectedDrugsItemsName = [];

            stepperController.natureEventValue = [];
            stepperController.ageController.text = "";
            stepperController.sexController.text = "";
            stepperController.describeController.text = "";
            stepperController.dailyDoesController.text = "";
            stepperController.indicationController.text = "";
            stepperController.therapyDurationController.text = "";
            stepperController.therapyDateController.text = "";
            stepperController.routesAdministrationController.text = "";
            stepperController.addressController.text = "";
            stepperController.manufacturerDateController.text = "";
            stepperController.reportDateController.text = "";
            stepperController.mfrControlController.text = "";
            lastIndex = -1;
            stepperController.genderRadioBtn = '';
            stepperController.genderRadioValue = '';
            stepperController.batchNoController.text = "";
            stepperController.expiryDateController.text = "";
            stepperController.stopDrugValueRadioBtn = '';
            stepperController.reIntroValueRadioBtn = '';
            stepperController.reportSourceValueRadioBtn = '';
            stepperController.reportTypeValueRadioBtn = '';
            stepperController.relevantHistoryController.text = "";
            stepperController.dateOfAdministrationController.text = "";
            stepperController.feedBackController.text = "";
            stepperController.ethnicityController.text = "";
            stepperController.therapyDateControllerStopDate.text = "";
            stepperController.routesOfAdtOtherController.text = "";
            stepperController.eventLaterOtherController.text = "";
            stepperController.selectImage = false;
            curIndex = 0;
            lastIndex = -1;
            stepperController.isLoading = false;
            stepperController.isLoader = false;
            setState(() {});
            save("save_status", "0");
            Get.to(const SuccessFulScreen());
          } else {
            setState(() {
              stepperController.isLoading = false;
              stepperController.isLoader = false;
            });
            showMsg(context, msg: res['message'], color: Colors.red);
          }
        });
      } else {
        setState(() {
          stepperController.isLoading = false;
          stepperController.isLoader = false;
        });
        showMsg(context,
            msg: 'Please fill all mandatory fields.', color: Colors.red);
      }
    }
  }

  saveDraft() async {
    print("Step : 1");
    if (lastIndex == 3) {
      if (stepperController.ageController.text != '' &&
          stepperController.describeController.text != '' &&
          stepperController.genderRadioBtn != '' &&
          stepperController.dropdownCountryValue != null &&
          stepperController.batchNoController.text != '' &&
          stepperController.suspectDrugsId.length > 0) {
        setState(() {
          stepperController.isLoading = true;
          stepperController.isLoader = true;
          curIndex++;
        });

        //    stepperController.dropdownCountryValue;
        // stepperController.phone = "";
        // stepperController.usertype = "";
        // stepperController.dropdownResoulutionValue;
        // stepperController.dropdownRoutesofAdValue;
        // stepperController.dropdownEventLater;
        // natureEventList = [];
        // stoppingDrugList = [];
        // reIntroList = [];
        // describeReactionList = [];
        // reportSourceList = [];
        // reportTypeList = [];
        // routsOfAdList = [];
        // resolutionList = [];
        // suspectDrugList = [];
        // stepperController.suspectDrugsId = [];
        // stepperController.selectedDrugsItems = [];
        // stepperController.selectedDrugsItemsName = [];
        // stepperController.natureEventValue = [];
        // stepperController.stopDrugValueRadioBtn = '';
        // stepperController.reIntroValueRadioBtn = '';

        // stepperController.genderRadioBtn = '';
        // stepperController.genderRadioValue = '';
        // stepperController.reportSourceValueRadioBtn = '';
        // stepperController.reportTypeValueRadioBtn = '';
        lastIndex = -1;
        save("save_status", "1");
        save("dateController", stepperController.dateController.text);
        save("eventStartDateController",
            stepperController.eventStartDateController.text);
        save("patentInitialsController",
            stepperController.patentInitialsController.text);

        save("ageController", stepperController.ageController.text);

        save("sexController", stepperController.sexController.text);
        save("describeController", stepperController.describeController.text);
        save("dailyDoesController", stepperController.dailyDoesController.text);
        save("indicationController",
            stepperController.indicationController.text);
        save("therapyDurationController",
            stepperController.therapyDurationController.text);
        save("therapyDateController",
            stepperController.therapyDateController.text);
        save("routesAdministrationController",
            stepperController.routesAdministrationController.text);
        save("addressController", stepperController.addressController.text);
        save("manufacturerDateController",
            stepperController.manufacturerDateController.text);
        save("reportDateController",
            stepperController.reportDateController.text);
        save("mfrControlController",
            stepperController.mfrControlController.text);
        save("batchNoController", stepperController.batchNoController.text);

        save("expiryDateController",
            stepperController.expiryDateController.text);

        save("relevantHistoryController",
            stepperController.relevantHistoryController.text);

        save("dateOfAdministrationController",
            stepperController.dateOfAdministrationController.text);
        save("feedBackController", stepperController.feedBackController.text);
        save("ethnicityController", stepperController.ethnicityController.text);
        save("therapyDateControllerStopDate",
            stepperController.therapyDateControllerStopDate.text);
        save("routesOfAdtOtherController",
            stepperController.routesOfAdtOtherController.text);
        save("eventLaterOtherController",
            stepperController.eventLaterOtherController.text);
        // stepperController.selectImage = false;
        curIndex = 0;
        lastIndex = -1;
        stepperController.isLoading = false;
        stepperController.isLoader = false;
        setState(() {});
        showMsg(context,
            msg: "Successfully save data as a draft", color: Colors.green);
        Get.to(const SuccessFulScreen());
      } else {
        setState(() {
          stepperController.isLoading = false;
          stepperController.isLoader = false;
        });
        showMsg(context,
            msg: 'Please fill all mandatory fields.', color: Colors.red);
      }
    }
  }

  void getLocalData() async {
    // final prefs = await SharedPreferences.getInstance();
    suspectDrug();
    optionList();
  }

  optionList() async {
    if (natureEventList.isEmpty ||
        stoppingDrugList.isEmpty ||
        reIntroList.isEmpty ||
        describeReactionList.isEmpty ||
        reportSourceList.isEmpty ||
        reportTypeList.isEmpty ||
        routsOfAdList.isEmpty ||
        resolutionList.isEmpty) {
      setState(() {
        stepperController.isLoader = true;
      });
      natureEventList = [];
      stoppingDrugList = [];
      reIntroList = [];
      describeReactionList = [];
      reportSourceList = [];
      reportTypeList = [];
      routsOfAdList = [];
      resolutionList = [];
      stepperController.optionListApi().then((value) {
        print("Local option data : $value");

        if (value['status']) {
          value['data']['COUNTRIES'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              countryList.add({'lable': key, 'value': value});
            });
          });
          print("COUNTRYLIST:-- ${countryList[0]['value'].toString()}");

          value['data']['ADVERSE_REACTION_OPTIONS'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              describeReactionList.add({'lable': key, 'value': value});
            });
          });
          print(
              "describeReactionList:-- ${describeReactionList[1]['value'].toString()}");

          value['data']['NATURE_OF_EVENT'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              natureEventList.add({'lable': key, 'value': value});
            });
          });
          print("NATURE_OF_EVENT:-- ${natureEventList[1]['value'].toString()}");

          value['data']['ROUTS_OF_ADMINISTRATION'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              routsOfAdList.add({'lable': key, 'value': value});
            });
          });
          print(
              "ROUTS_OF_ADMINISTRATION:-- ${routsOfAdList[1]['value'].toString()}");

          value['data']['STOPPING_DRUG_OPTIONS'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              stoppingDrugList.add({'lable': key, 'value': value});
            });
          });
          print(
              "stoppingDrugList:-- ${stoppingDrugList[1]['value'].toString()}");

          value['data']['REINTRO_DUCTION_OPTIONS'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              reIntroList.add({'lable': key, 'value': value});
            });
          });
          print("reIntroList:-- ${reIntroList[1]['value'].toString()}");

          value['data']['REPORT_SOURCES'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              reportSourceList.add({'lable': key, 'value': value});
            });
          });
          print(
              "reportSourceList:-- ${reportSourceList[1]['value'].toString()}");

          value['data']['RESOLUTION_ACTION'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              resolutionList.add({'lable': key, 'value': value});
            });
          });
          print("resolutionList:-- ${resolutionList[1]['value'].toString()}");

          value['data']['REPORT_TYPES'].forEach((key, value) {
            print("$key: $value");
            setState(() {
              reportTypeList.add({'lable': key, 'value': value});
            });
          });
          print("reportTypeList:-- ${reportTypeList[1]['value'].toString()}");
          setState(() {
            stepperController.isLoader = false;
          });
        }
      });
    }
  }

  suspectDrug() async {
    if (suspectDrugList.isEmpty) {
      stepperController.suspectDrugApi().then((value) {
        if (value['status']) {
          setState(() {
            suspectDrugList = value['data'];
          });
        }
      });
    }
  }

  void updateSteper(int index) {
    print("CurrentIndex ${index.toString()}");
    setState(() {
      if (index == 0) {
        lastIndex = index - 1;
        curIndex = index;
      } else if (index == 1) {
        lastIndex = index - 1;
        curIndex = index;
      } else if (index == 2) {
        lastIndex = index - 1;
        curIndex = index;
      } else if (index == 3) {
        lastIndex = index - 1;
        curIndex = index;
      } else if (index == 4) {
        lastIndex = index - 1;
        curIndex = index;
      } else if (index == 5) {
        lastIndex = index - 1;
        curIndex = index;
      }
    });
  }
}
