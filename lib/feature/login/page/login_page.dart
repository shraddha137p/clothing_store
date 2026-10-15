import 'package:clothing_store/feature/login/bloc/login_bloc.dart';
import 'package:clothing_store/feature/login/bloc/login_event.dart';
import 'package:clothing_store/feature/login/bloc/login_state.dart';
import 'package:go_router/go_router.dart';

import '../../../utilities/export_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LoginBloc(), child: const LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.success) {
              context.go('/products');
            }

            if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Invalid email or password',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();

            final bool isButtonEnabled =
                state.isFormValid && state.status != LoginStatus.loading;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 70.h),

                  CommonText.bold('Welcome Back!', size: 28.sp),

                  SizedBox(height: 8.h),

                  CommonText.regular(
                    'Login to continue shopping',
                    size: 14.sp,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 40.h),

                  CommonText.medium('Email Address', size: 14.sp),
                  SizedBox(height: 8.h),

                  CommonTextField(
                    controller: emailController,
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    prefixIcon: const Icon(Icons.email_outlined),
                    onChanged: (value) {
                      bloc.add(LoginEmailChanged(value));
                    },
                    validator: validateEmail,
                  ),

                  SizedBox(height: 20.h),

                  CommonText.medium('Password', size: 14.sp),

                  SizedBox(height: 8.h),

                  CommonTextField(
                    controller: passwordController,
                    hintText: 'Enter your password',
                    obscure: obscurePassword,
                    inputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    onChanged: (value) {
                      bloc.add(LoginPasswordChanged(value));
                    },
                    validator: validatePassword,
                    fieldSubmitted: (_) {
                      if (isButtonEnabled) {
                        bloc.add(LoginSubmitted());
                      }
                    },
                  ),

                  SizedBox(height: 32.h),

                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: state.status == LoginStatus.loading
                          ? 'Please wait...'
                          : 'Login',
                      type: isButtonEnabled
                          ? ButtonType.primary
                          : ButtonType.disable,
                      onTap: isButtonEnabled
                          ? () {
                              FocusScope.of(context).unfocus();

                              bloc.add(LoginSubmitted());
                            }
                          : null,
                      btnCornerRadius: 12.r,
                      btnVerticalPadding: 16.h,
                      textSize: 16.sp,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
