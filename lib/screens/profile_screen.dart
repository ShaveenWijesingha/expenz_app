import 'package:expens/screens/onbording_screen.dart';
import 'package:expens/services/expense_service.dart';
import 'package:expens/services/income_service.dart';
import 'package:expens/services/user_service.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:expens/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  //open scafold messenger for logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(KDefaltPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kGrey,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kMainColor),
                    ),
                    onPressed: () async {
                      //clear the user data
                      await UserService.clearUserDetails();
                      //clear the all expense and incomes
                      if (context.mounted) {
                        await ExpenseService().deleteAllExpenses(context);
                        await IncomeService().deleteAllIncomes(context);
                      }

                      //navigate to the onbording screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnbordingScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text("Yes", style: TextStyle(color: kLightGrey)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(KDefaltPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: kMainColor, width: 3),
                        color: kMainColor.withOpacity(0.5),
                      ),

                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(Icons.person, color: kWhite, size: 60),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Welcome Shaveen",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () async {},
                      icon: Icon(Icons.edit, size: 30, color: kBlack),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                const ProfileCard(
                  icon: Icons.wallet,
                  title: "My Wallet",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kMainColor,
                ),
                const ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kMainColor,
                ),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
