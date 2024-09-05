import 'package:ayurveda/core/constants.dart';
import 'package:ayurveda/core/utils/app_colors.dart';
import 'package:ayurveda/presentation/provider/login_provider.dart';
import 'package:ayurveda/presentation/widgets/app_space_widget.dart';
import 'package:ayurveda/presentation/widgets/input_decoration_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.dark,
              ),
              forceMaterialTransparency: true,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/login_banner.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo_small.png',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login or Register To Book Your Appointments',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    setHeight(32),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Email"),
                    ),
                    setHeight(8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your username';
                        }
                        if (value.length < 3) {
                          return 'Please enter a valid username';
                        }
                        return null;
                      },
                      controller:
                          context.watch<LoginProvider>().usernameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: inputDecoration(
                        context,
                        hintText: "Enter your email",
                      ),
                    ),
                    setHeight(16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("Password"),
                    ),
                    setHeight(8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      controller:
                          context.watch<LoginProvider>().passwordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: inputDecoration(
                        context,
                        hintText: "Enter your password",
                      ),
                    ),
                    setHeight(64),
                    Consumer<LoginProvider>(
                      builder: (context, snapshot, _) {
                        if (snapshot.errorMessage.isNotEmpty) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(snapshot.errorMessage),
                                ),
                              );
                            snapshot.errorMessage = "";
                          });
                        }
                        if (snapshot.isLogin) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            kNavigationKey.currentState
                                ?.pushNamedAndRemoveUntil(
                              '/home',
                              (route) => false,
                            );
                          });
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<LoginProvider>().login();
                            }
                          },
                          child: snapshot.isLoading
                              ? CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                        );
                      },
                    ),
                    setHeight(32),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "By creating or logging into an account you are agreeing with our",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w100),
                          children: [
                            TextSpan(
                              text: " Terms and Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w100,
                                    color: AppColors.linkColor,
                                  ),
                              children: [
                                TextSpan(
                                  text: " and",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w100),
                                  children: [
                                    TextSpan(
                                      text: " Privacy Policy",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w100,
                                            color: AppColors.linkColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget contains(){
  return Container(
    margin: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.black.withOpacity(0.2),
        width: 1,
      ),
    ),
    padding: const EdgeInsets.all(16),
    child: const Column(
      children: [
        Text("Hello"),
        Row(
          children: [
            Expanded(child: Text("Rate")),
            Expanded(child: Text("1000")),
          ],
        ),
      ],
    ),
  );
}