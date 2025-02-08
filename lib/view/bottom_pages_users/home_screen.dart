import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/generated/assets.dart';
import 'package:founder_code_hr_app/main.dart';
import 'package:founder_code_hr_app/res/const_files/app_btn.dart';
import 'package:founder_code_hr_app/res/const_files/app_const.dart';
import 'package:founder_code_hr_app/res/const_files/color_const.dart';
import 'package:founder_code_hr_app/res/const_files/text_const.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/location_view_model.dart';
import 'package:founder_code_hr_app/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  DateTime? _selectedDate;

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false).profileApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final profile = profileViewModel.modelData;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: screenWidth,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextConst(
                title: profile?.data?.name != null
                    ? "Hii, ${profile!.data!.name}"
                    : "Hii, User",
                color: AppColor.white10,
              ),
              const Icon(
                Icons.notifications_active,
                color: AppColor.white10,
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primary,
      ),
      body: profile == null
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColor.primary,
            ))
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Card(
                elevation: 5,
                color: AppColor.white10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(circularBorderRadius10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenWidth * 0.2,
                            width: screenWidth * 0.2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: profile.data?.profileImage != null &&
                                        profile.data!.profileImage!.isNotEmpty
                                    ? NetworkImage(profile.data!.profileImage!)
                                    : const AssetImage(Assets.assetsNoInternet)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                              border:
                                  Border.all(width: 1, color: AppColor.primary),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextConst(
                                title: profile.data!.name ?? "N/A",
                                color: AppColor.blackTemp,
                              ),
                              TextConst(
                                title: profile.data!.designation ?? "N/A",
                                fontSize: textFontSize17,
                              )
                            ],
                          ),
                          if (locationProvider.isProcessing)
                            const CircularProgressIndicator(
                              color: AppColor.primary,
                            ),
                            if (profile.data!.punchInStatus == 1 &&
                              !locationProvider.isProcessing)
                            ButtonConst(
                              loading: locationProvider.isLoading,
                              onTap: locationProvider.isInRange
                                  ? () => locationProvider.punchIn().then((_) {
                                        locationProvider.punchApi(
                                          context,
                                        );
                                      })
                                  : () {
                                      showCustomSnackBar(
                                          "You are not in range!", context);
                                    },
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              fontSize: textFontSize15,
                              color: locationProvider.isInRange
                                  ? AppColor.secondary
                                  : Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(circularBorderRadius5),
                              label: "Punch In",
                            ),
                            if (profile.data!.punchInStatus == 2 &&
                              !locationProvider.isProcessing)
                            ButtonConst(
                              loading: locationProvider.isLoading,
                              onTap: locationProvider.isInRange
                                  ? () => locationProvider.punchOut().then((_) {
                                        locationProvider.punchApi(context);
                                      })
                                  : () {
                                      showCustomSnackBar(
                                          "You are not in range!", context);
                                    },
                              width: screenWidth * 0.2,
                              height: screenHeight * 0.05,
                              fontSize: textFontSize13,
                              color: locationProvider.isInRange
                                  ? AppColor.secondary
                                  : Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(circularBorderRadius5),
                              label: "Punch Out",
                            ),
                        ],
                      ),
                      spaceHeight10,
                      const Divider(
                        thickness: 0.3,
                      ),
                      spaceHeight10,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextConst(
                            title: "Office Timeing :-",
                            color: AppColor.blackTemp,
                          ),
                          TextConst(
                            title: "10:00 Am To 7:00 Pm",
                            fontSize: textFontSize15,
                            color: AppColor.secondary,
                          ),
                        ],
                      ),
                      spaceHeight10,
                    ],
                  ),
                ),
              ),
              spaceHeight20,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: const Text(
                  "Current Attendance Status ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              spaceHeight20,
              Row(
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 5,
                        color: AppColor.white10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              circularBorderRadius10), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextConst(
                                title: "Your Punching Time & Date Day",
                                color: AppColor.red,
                                fontSize: textFontSize15,
                              ),
                              TextConst(
                                title: locationProvider.statusPunchIn.isEmpty ?"Please Punch In":locationProvider.statusPunchIn,
                                fontSize: textFontSize15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceHeight10,
                      Card(
                        elevation: 5,
                        color: AppColor.white10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              circularBorderRadius10), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextConst(
                                title: "Your Punch Out Time & Date Day",
                                color: AppColor.red,
                                fontSize: textFontSize15,
                              ),
                              TextConst(
                                title: locationProvider.statusPunchOut.isEmpty ?"Please Punch Out":locationProvider.statusPunchOut,
                                fontSize: textFontSize15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              spaceHeight20,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: Card(
                  elevation: 5,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.blue),
                            SizedBox(width: 10),
                            TextConst(
                              title: "Total Coming Days",
                              fontWeight: FontWeight.bold,
                              fontSize: textFontSize15,
                              color: AppColor.blackTemp,
                            ),
                            Spacer(),
                            TextConst(
                              title: "${profile.data!.totalComingDays} Days",
                              fontSize: textFontSize15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.beach_access, color: Colors.red),
                            SizedBox(width: 10),
                            TextConst(
                              title: "Total Leave",
                              fontWeight: FontWeight.bold,
                              fontSize: textFontSize15,
                              color: AppColor.blackTemp,
                            ),
                            Spacer(),
                            TextConst(
                              title: "${profile.data!.totalAbsentDays} Days",
                              fontSize: textFontSize15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Icon(Icons.timer, color: Colors.orange),
                            SizedBox(width: 10),
                            TextConst(
                              title: "Half Days",
                              fontWeight: FontWeight.bold,
                              fontSize: textFontSize15,
                              color: AppColor.blackTemp,
                            ),
                            Spacer(),
                            TextConst(
                              title: "${profile.data!.totalHalfDays} Days",
                              fontSize: textFontSize15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ),
        Align(
          alignment: Alignment.center,
          child: ButtonConst(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.mapScreen);
            },
            width: screenWidth*0.2,
            height: screenHeight*0.04,
            label: "View Map",
            fontWeight: FontWeight.bold,
            fontSize: textFontSize12,
          ),
        )
            ]),
    );
  }
}

