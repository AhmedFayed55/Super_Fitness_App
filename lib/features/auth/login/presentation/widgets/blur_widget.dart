import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:super_fitness_app/config/routing/app_routes.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/flutter_toast.dart';
import 'package:super_fitness_app/core/helpers/spacing.dart';
import 'package:super_fitness_app/core/helpers/validators.dart';
import 'package:super_fitness_app/core/l10n/translations/app_localizations.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_event.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_state.dart';
import 'package:super_fitness_app/features/auth/login/presentation/manager/login_screen_view_model.dart';
import 'package:super_fitness_app/features/auth/login/presentation/widgets/login_button.dart';
import 'or_divider_widget.dart';

class BlurWidget extends StatefulWidget {
  const BlurWidget({super.key});

  @override
  State<BlurWidget> createState() => _BlurWidgetState();
}

class _BlurWidgetState extends State<BlurWidget> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = context.localization;
    final ThemeData theme = context.theme;
    final double height = context.height;
    final LoginScreenViewModel viewModel = context.read<LoginScreenViewModel>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(AppAssets.fieldsBackground, fit: BoxFit.cover),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.042,
                  vertical: height * 0.029,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Text(locale.login, style: theme.textTheme.displayLarge),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.065,
                      ),
                      child: BlocConsumer<LoginScreenViewModel, LoginScreenState>(
                        listener: (context, state) {
                          if(state.isSuccess){
                            ToastMessage.toastMsg(locale.login_successfully);
                            Future.delayed(const Duration(seconds: 1),(){
                              context.pushNamedAndRemoveUntil(AppRoutes.appSections, predicate: (route) => false,);
                            });
                          } else if(state.errorMsg != null && state.showToast){
                            ToastMessage.toastMsg(state.errorMsg ?? locale.something_went_wrong,backgroundColor: theme.colorScheme.error);
                          }
                        },
                        builder: (context, state) => Form(
                          key: viewModel.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: locale.email,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    size: 20,
                                  ),
                                ),
                                validator: (value) =>
                                    Validations.validateEmail(context, value),
                                controller: viewModel.emailController,
                              ),
                              verticalSpace(14),
                              TextFormField(
                                obscureText: isObscure,
                                validator: (value) =>
                                    Validations.validatePassword(context, value),
                                controller: viewModel.passController,
                                decoration: InputDecoration(
                                  hintText: locale.password,
                                  prefixIcon: const Icon(
                                    Icons.lock_open_outlined,
                                    size: 20,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isObscure = !isObscure;
                                      });
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              verticalSpace(8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(onPressed: (){
                                  context.pushNamed(AppRoutes.forgetPassword);
                                }, child: Text(
                                  locale.forget_password_ques,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),),
                              ),
                              verticalSpace(height * .029),
                              const OrDividerWidget(),
                              verticalSpace(height * .023),
                              Row(
                                spacing: context.width * .05,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CustomCircleAvatar(FontAwesomeIcons.facebookF),
                                  CustomCircleAvatar(FontAwesomeIcons.google),
                                  CustomCircleAvatar(FontAwesomeIcons.apple),
                                ],
                              ),
                              verticalSpace(height * .023),
                              LoginButton(loginTap: (){
                                if(viewModel.formKey.currentState!.validate()){
                                  viewModel.doIntent(SubmitLoginEvent());
                                }
                              }, isLoading: state.isLoading,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar(this.customIcon, {super.key});
  final IconData customIcon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.secondary,
      child: Icon(customIcon),
    );
  }
}
