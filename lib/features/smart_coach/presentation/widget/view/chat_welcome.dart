import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/widgets/blur_container.dart';

class ChatWelcomeView extends StatelessWidget {
  final VoidCallback onGetStarted;

  const ChatWelcomeView({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.chatBackground, fit: BoxFit.cover),
          ).blurred(blur: 6, colorOpacity: 0.05, blurColor: AppColors.black),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(context.mdW(20)),
                  child: Row(
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<SmartChatViewModel, SmartChatState>(
                            builder: (context, state) {
                              final userName =
                                  state.user?.firstName ??
                                  context.localization.user;
                              return Text(
                                '${context.localization.hi} $userName,',
                                style: theme.textTheme.displaySmall,
                              );
                            },
                          ),
                          SizedBox(height: context.mdH(6)),
                          Text(
                            context.localization.i_am_your_smart_coach,
                            style: theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                      const Spacer(flex: 1),
                      GestureDetector(
                        child: SvgPicture.asset(
                          AppAssets.chatList,
                          width: context.mdIcon(24),
                          height: context.mdIcon(24),
                        ),
                        onTap: () {
                          //  show chat list
                        },
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: context.mdW(350),
                      height: context.mdH(450),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: context.mdW(343),
                            height: context.mdW(428),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AppAssets.robot,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                BlurContainer(
                  blurSigma: 15,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                '${context.localization.how_can_i_assist_you}\n',
                            style: theme.textTheme.displayLarge,
                          ),
                          TextSpan(
                            text: context.localization.today,
                            style: theme.textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.mdH(40)),
                    CustomElevatedButton(
                      widget: Text(context.localization.get_started),
                      isLoading: false,
                      onPressed: onGetStarted,
                    ),
                  ],
                ),
                SizedBox(height: context.mdH(24)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
