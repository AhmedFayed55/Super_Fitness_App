import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/components/custom_elevated_button.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/chat_conversation.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/previous_conversations_drawer.dart';
import 'package:super_fitness_app/widgets/blur_container.dart';

class ChatWelcomeView extends StatelessWidget {
  const ChatWelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final viewModel = context.read<SmartChatViewModel>();

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
                        onTap: () => viewModel.doIntent(ToggleDrawerEvent()),
                        child: SvgPicture.asset(
                          AppAssets.chatList,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: context.mdW(350),
                      height: context.mdH(450),
                      child: Image.asset(AppAssets.robot, fit: BoxFit.contain),
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: viewModel,
                              child: const ChatConversationView(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: context.mdH(24)),
              ],
            ),
          ),

          BlocBuilder<SmartChatViewModel, SmartChatState>(
            buildWhen: (prev, curr) =>
                prev.showDrawer != curr.showDrawer ||
                prev.isLoadingChats != curr.isLoadingChats ||
                prev.userChats.length != curr.userChats.length,
            builder: (context, drawerState) {
              if (!drawerState.showDrawer) return const SizedBox.shrink();

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                right: 0,
                top: 0,
                bottom: 0,
                child: PreviousConversationsDrawer(
                  conversations: drawerState.userChats.map((chat) {
                    return {
                      'id': chat.id,
                      'title': chat.title,
                      'createdAt': chat.createdAt,
                      'lastMessageAt': chat.lastMessageAt,
                      'messageCount': chat.messageCount,
                    };
                  }).toList(),
                  isLoading: drawerState.isLoadingChats,
                  onClose: () => viewModel.doIntent(ToggleDrawerEvent()),
                  onSelectConversation: (chatId) async {
                    await viewModel.doIntent(SelectChatEvent(chatId));
                    viewModel.doIntent(ToggleDrawerEvent());
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: viewModel,
                          child: const ChatConversationView(),
                        ),
                      ),
                    );
                  },
                  onDeleteConversation: (chatId) {
                    viewModel.doIntent(DeleteChatEvent(chatId));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
