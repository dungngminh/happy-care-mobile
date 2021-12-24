import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/drug.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';
import 'package:happy_care/modules/prescription/edit_prescription/edit_prescription_controller.dart';
import 'package:happy_care/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class EditPrescriptionScreen extends GetView<EditPrescriptionController> {
  EditPrescriptionScreen({Key? key}) : super(key: key);
  final prescription = Get.arguments as Prescription;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: kMainColor),
          title: Text(
            "Cập nhật ${prescription.id!.substring(0, 5)}..${prescription.id!.substring(prescription.id!.length - 6, prescription.id!.length - 1)} ",
            style: GoogleFonts.openSans(
              color: kMainColor,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.save_rounded),
              color: kMainColor,
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: CustomTextField(
                  color: Colors.black,
                  controller: controller.diagnoseController,
                  icon: Icons.search_rounded,
                  labelText: "Chuẩn đoán",
                  hintText: "Nhập vào chuẩn đoán...",
                  // controller:
                  //     controller.ageController,
                ),
              ),
              SizedBox(
                height: 1.2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: CustomTextField(
                  color: Colors.black,
                  controller: controller.noteController,
                  icon: Icons.search_rounded,
                  labelText: "Ghi chú (nếu có)",
                  hintText: "Nhập vào ghi chú...",
                ),
              ),
              SizedBox(height: 0.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thuốc",
                    style: GoogleFonts.openSans(
                      color: kMainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(),
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_rounded,
                      color: kMainColor,
                      size: 26,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: controller.listDrug.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Thuốc ${index + 1}",
                                  style: GoogleFonts.openSans(
                                      color: kMainColor,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                IconButton(
                                  padding: const EdgeInsets.only(),
                                  onPressed: () =>
                                      controller.removeAtIndex(index),
                                  icon: Icon(
                                    Icons.delete_rounded,
                                    color: kMainColor,
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.2.h,
                            ),
                            DropdownButtonFormField<Drug>(
                                value: controller
                                    .prescriptionController.drugList
                                    .firstWhere((drug) => drug.id!.contains(
                                        controller.listDrug[index].drug!)),
                                isExpanded: true,
                                items: controller
                                    .prescriptionController.drugList
                                    .map<DropdownMenuItem<Drug>>((Drug drug) {
                                  return DropdownMenuItem<Drug>(
                                    child: AutoSizeText(
                                      drug.name!,
                                      maxLines: 1,
                                    ),
                                    value: drug,
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.medication_rounded,
                                      color: kMainColor),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kMainColor.withOpacity(0.7),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kMainColor,
                                    ),
                                  ),
                                  focusColor: kMainColor,
                                  border: OutlineInputBorder(),
                                  labelText: "Thuốc",
                                  hintText: "Chọn thuốc",
                                  labelStyle:
                                      GoogleFonts.openSans(color: kMainColor),
                                  hintStyle:
                                      GoogleFonts.openSans(color: kMainColor),
                                ),
                                onChanged: (Drug? drug) {
                                  controller.listDrug[index].drug = drug!.id!;
                                  print(controller.listDrug[index].drug);
                                }),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomTextField(
                              color: Colors.black,
                              initialValue: controller.listDrug[index].dosage,
                              icon: Icons.note_alt_rounded,
                              labelText: "Mô tả liều dùng",
                              hintText: "Nhập vào mô tả liều dùng...",
                              onChangedFunction: (value) {
                                controller.listDrug[index].dosage = value;
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 1.5.h,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
