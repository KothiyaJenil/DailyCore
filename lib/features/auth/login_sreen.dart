import 'package:dailycore/core/constants/App_Colors.dart';
import 'package:dailycore/core/constants/App_Text_Style.dart';
import 'package:dailycore/core/util/auth_validators.dart';
import 'package:dailycore/features/auth/register_screen.dart';
import 'package:dailycore/providers/auth_provider.dart';
import 'package:dailycore/widget/custom_bottom_navbar.dart';
import 'package:dailycore/widget/custom_form_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isHide = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVm = Provider.of<AuthProvider>(context);
    String email = _emailController.text.toString();
    String password = _passwordController.text.toString();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              height: MediaQuery.of(context).size.height / 1.8,
              child: SvgPicture.asset("assets/images/svg/bike.svg"),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text("Login", style: AppTextStyles.display),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: "Email",
                      validator: (value) => Validators.email(value),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: "Password",
                      obscureText: _isHide,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isHide = !_isHide;
                          });
                        },
                        icon: Icon(
                          _isHide
                              ? CupertinoIcons.eye_slash_fill
                              : CupertinoIcons.eye_solid,
                          color: AppColors.primary,
                        ),
                      ),
                      validator: (value) => Validators.password(value),
                    ),
                    const SizedBox(height: 16),
                    // if (authVm.isLoading)
                    //   const CircularProgressIndicator()
                    // else
                    FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final success = await authVm.login(
                            email: email,
                            password: password,
                          );

                          if (success) {
                            if (mounted) {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const CustomBottomNavbar(),
                                ),
                              );
                            }
                          } else {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    authVm.errorMessage ?? "Login failed",
                                  ),
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: Text(
                        "Login",
                        style: AppTextStyles.subheading.copyWith(
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text("Create an account"),
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
