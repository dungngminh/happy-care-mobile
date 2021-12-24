import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/data/models/prescription/prescription.dart';
import 'package:happy_care/modules/prescription/detail_prescription/detail_prescription_controller.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

class DetailPrescription extends GetView<DetailPrescriptionController> {
  DetailPrescription({Key? key}) : super(key: key);

  final prescription = Get.arguments as Prescription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kMainColor),
        centerTitle: true,
        title: Text(
          "Đơn thuốc ${prescription.id!.substring(0, 5)}..${prescription.id!.substring(prescription.id!.length - 6, prescription.id!.length - 1)} ",
          style: GoogleFonts.openSans(
            color: kMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: controller.userController.user.value.role == 'doctor'
            ? [
                IconButton(
                  onPressed: () => Get.toNamed(
                    AppRoutes.rEditPrescription,
                    arguments: prescription,
                  ),
                  icon: Icon(
                    Icons.edit_rounded,
                    color: kMainColor,
                  ),
                ),
              ]
            : null,
      ),
      body: Obx(() {
        final status = controller.status.value;
        if (status == DetailPrescriptionStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              color: kMainColor,
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Người tạo đơn thuốc:",
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          "Người nhận đơn thuốc:",
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          "Ngày cập nhật mới nhất:",
                          style: GoogleFonts.openSans(
                            color: kMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userController.user.value.role == 'doctor'
                              ? controller.userController.user.value.profile
                                      ?.fullname ??
                                  controller.userController.user.value.email
                              : controller.user.value.profile?.fullname ??
                                  controller.user.value.email,
                          style: GoogleFonts.openSans(
                            color: kTextMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          controller.userController.user.value.role != 'doctor'
                              ? controller.userController.user.value.profile
                                      ?.fullname ??
                                  controller.userController.user.value.email
                              : controller.user.value.profile?.fullname ??
                                  controller.user.value.email,
                          style: GoogleFonts.openSans(
                            color: kTextMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Text(
                          DateTime.parse(
                            prescription.date!,
                          ).toLocal().toString().substring(0, 16),
                          style: GoogleFonts.openSans(
                            color: kTextMainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Kết quả chuẩn đoán:",
                        style: GoogleFonts.openSans(
                          color: kMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        prescription.diagnose!,
                        style: GoogleFonts.openSans(
                          color: kTextMainColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "Danh sách kê thuốc: ${prescription.medicines!.length}",
                  style: GoogleFonts.openSans(
                    color: kMainColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: prescription.medicines!.length,
                itemBuilder: (context, index) {
                  var drug = controller.preController.drugList.firstWhere(
                      (element) => prescription.medicines![index].drug!
                          .contains(element.id!));
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tooltip(
                      message: drug.description,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage:
                                Image.asset("assets/images/medi.png").image),
                        title: Text(drug.name!),
                        subtitle: Text(prescription.medicines![index].dosage!),
                      ),
                    ),
                  );
                },
              ))
            ],
          );
        }
      }),
    );
  }
}
