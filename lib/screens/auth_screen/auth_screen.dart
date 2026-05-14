import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/controller/auth_controller.dart';
import 'package:sankar_task/screens/auth_screen/widgets/signinForm.dart';
import 'package:sankar_task/screens/auth_screen/widgets/signupForm.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  final _loginKey = GlobalKey<FormState>();
  final _signKey = GlobalKey<FormState>();

  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final double s = (screen.width / 390).clamp(0.85, 1.25);

    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16 * s),
      borderSide: BorderSide(color: AppColors.black12Op15),
    );

    final fillColor = AppColors.whiteOp7;
    final cardColor = AppColors.whiteOp6;
    final btnColor = AppColors.accentOp25;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20 * s, vertical: 24 * s),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 12 * s),
                          Text(
                            AppConstants.welcomeHeading,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 26 * s,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 6 * s),
                          Text(
                            AppConstants.welcomeSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.welcomeSubtitle,
                              fontSize: 16 * s,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(height: 48 * s),

                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteOp4,
                          borderRadius: BorderRadius.circular(16 * s),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8 * s,
                          vertical: 4 * s,
                        ),
                        child: TabBar(
                          controller: _tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20 * s),
                          ),
                          labelColor: AppColors.tabLabelPink,
                          unselectedLabelColor: AppColors.tabUnselectedGrey,
                          tabs: [
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6 * s),
                                child: Text(
                                  AppConstants.loginTabLabel,
                                  style: TextStyle(fontSize: 16 * s),
                                ),
                              ),
                            ),
                            Tab(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 6 * s),
                                child: Text(
                                  AppConstants.signupTabLabel,
                                  style: TextStyle(fontSize: 16 * s),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16 * s),

                      // Card container with bounded TabBarView height to avoid layout errors
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16 * s),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackOp05,
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16 * s),
                        child: SingleChildScrollView(
                          child: SizedBox(
                            height:
                                (_tab.index == 0 ? 350 : 350) *
                                s, // prevents RenderViewport error
                            child: TabBarView(
                              controller: _tab,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                SignInForm(
                                  formKey: _loginKey,
                                  inputBorder: inputBorder,
                                  fillColor: fillColor,
                                  btnColor: btnColor,
                                  scale: s,
                                ),
                                SignUpForm(
                                  formKey: _signKey,
                                  inputBorder: inputBorder,
                                  fillColor: fillColor,
                                  btnColor: btnColor,
                                  scale: s,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 14 * s),

                      SizedBox(height: 8 * s),
                      Text(
                        AppConstants.firestoreNoticeText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.mutedGrey,
                          fontSize: 13 * s,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
