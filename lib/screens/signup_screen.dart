import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:finance_tracker/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bottom_navigation.dart';
import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widgets/small_action_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Text Editing controllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My finance tracker',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              'Login',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Center(
                  child: AnimatedContainer(
                    width: _isKeyboardOpen ? 60.w : 120.w,
                    height: _isKeyboardOpen ? 60.h : 120.h,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/image.png'))),
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  'Sign up to Finance tracker',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontSize: 22),
                ),
                SizedBox(height: 30.h),
                TextFieldInput(
                  controller: _nameController,
                  hintText: 'Your name',
                  labelText: 'Name',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 25.h),
                TextFieldInput(
                  controller: _emailController,
                  hintText: 'name@example.com',
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 25.h),
                TextFieldInput(
                  controller: _passwordController,
                  hintText: '********',
                  labelText: 'Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldInput(
                        controller: _confirmPassController,
                        hintText: '********',
                        labelText: 'Confirm password',
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                    ),
                    SizedBox(width: 30.h),
                    GestureDetector(
                      onTap: signUpUser,
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const SmallActionButton(),
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
