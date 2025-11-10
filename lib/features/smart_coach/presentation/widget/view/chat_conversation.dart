import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/config/routing/routing_extensions.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_composer.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/chat_messages_list.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/previous_conversations_drawer.dart';
import 'package:super_fitness_app/widgets/custom_app_bar.dart';

class ChatConversationView extends StatefulWidget {
  const ChatConversationView({super.key});

  @override
  State<ChatConversationView> createState() => _ChatConversationViewState();
}

class _ChatConversationViewState extends State<ChatConversationView> {
  final TextEditingController _composerController = TextEditingController();

  @override
  void dispose() {
    _composerController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context, String text) {
    if (text.trim().isEmpty) return;
    context.read<SmartChatViewModel>().doIntent(SendMessageEvent(text));
    _composerController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final viewModel = context.read<SmartChatViewModel>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: CustomBackButton(onTap: () => context.pop()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          context.localization.smart_coach_title,
          style: theme.textTheme.displayLarge,
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: context.mdW(16)),
            onPressed: () => viewModel.doIntent(ToggleDrawerEvent()),
            icon: SvgPicture.asset(
              AppAssets.chatList,
              width: context.mdIcon(24),
              height: context.mdIcon(24),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.chatBackground,
              fit: BoxFit.cover,
            ).blurred(blur: 6, colorOpacity: 0.07, blurColor: AppColors.black),
          ),

          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<SmartChatViewModel, SmartChatState>(
                    buildWhen: (prev, curr) =>
                        prev.chatController != curr.chatController ||
                        prev.currentChatId != curr.currentChatId ||
                        prev.isLoadingMessages != curr.isLoadingMessages ||
                        prev.isSendingOrReceivingMessage !=
                            curr.isSendingOrReceivingMessage,
                    builder: (context, chatState) {
                      if (chatState.isLoadingMessages) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.lightOrange[10],
                              ),
                              SizedBox(height: context.mdH(12)),
                              Text(
                                context.localization.loading_messages,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }

                      return ChatMessagesList(
                        key: ValueKey(chatState.currentChatId ?? 'new-chat'),
                        viewModel: viewModel,
                        state: chatState,
                      );
                    },
                  ),
                ),

                BlocBuilder<SmartChatViewModel, SmartChatState>(
                  buildWhen: (prev, curr) =>
                      prev.isSendingOrReceivingMessage !=
                      curr.isSendingOrReceivingMessage,
                  builder: (context, composerState) {
                    return ChatComposer(
                      controller: _composerController,
                      state: composerState,
                      onSend: (text) => _sendMessage(context, text),
                      viewModel: viewModel,
                    );
                  },
                ),
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
