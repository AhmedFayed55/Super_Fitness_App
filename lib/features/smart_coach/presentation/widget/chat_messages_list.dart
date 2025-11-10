import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as core;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/utils/assets.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/typing_indicator.dart';

class ChatMessagesList extends StatelessWidget {
  final SmartChatViewModel viewModel;
  final SmartChatState state;

  const ChatMessagesList({
    super.key,
    required this.viewModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final loc = context.localization;

    final brightness = theme.brightness;

    final chatTheme =
        (brightness == Brightness.dark
                ? core.ChatTheme.dark()
                : core.ChatTheme.light())
            .copyWith(
              colors: core.ChatColors(
                primary: colorScheme.primary,
                onPrimary: colorScheme.onPrimary,
                surface: Colors.transparent,
                // ignore: deprecated_member_use
                surfaceContainer: colorScheme.surface.withOpacity(0.15),
                // ignore: deprecated_member_use
                surfaceContainerLow: colorScheme.surface.withOpacity(0.08),
                // ignore: deprecated_member_use
                surfaceContainerHigh: colorScheme.surface.withOpacity(0.25),
                onSurface: colorScheme.onPrimary,
              ),
            );

    final userPhoto = state.user?.photo;
    final hasUserPhoto = userPhoto != null && userPhoto.isNotEmpty;

    return Column(
      children: [
        Expanded(
          child: Chat(
            chatController: state.chatController,
            currentUserId: 'user1',
            theme: chatTheme,
            onMessageSend: (msg) => viewModel.doIntent(SendMessageEvent(msg)),
            resolveUser: (core.UserID id) async {
              if (id == 'user1') {
                return core.User(
                  id: 'user1',
                  name: state.user?.fullName ?? loc.you,
                  imageSource: hasUserPhoto ? userPhoto : AppAssets.robot,
                );
              } else {
                return core.User(
                  id: 'bot',
                  name: loc.smart_coach_title,
                  imageSource: AppAssets.robot,
                );
              }
            },
            builders: core.Builders(
              composerBuilder: (context) => const SizedBox.shrink(),
              chatMessageBuilder:
                  (
                    context,
                    message,
                    index,
                    animation,
                    child, {
                    groupStatus,
                    isRemoved,
                    required isSentByMe,
                  }) {
                    if (message is! core.TextMessage) return child;
                    final textMessage = message;

                    return Padding(
                      padding: EdgeInsets.only(
                        left: isSentByMe ? context.mdW(50) : context.mdW(12),
                        right: isSentByMe ? context.mdW(12) : context.mdW(50),
                        top: context.mdH(6),
                        bottom: context.mdH(6),
                      ),
                      child: Row(
                        mainAxisAlignment: isSentByMe
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!isSentByMe)
                            CircleAvatar(
                              radius: context.mdW(18),
                              backgroundImage: const AssetImage(
                                AppAssets.robot,
                              ),
                              // ignore: deprecated_member_use
                              backgroundColor: colorScheme.surface.withOpacity(
                                0.1,
                              ),
                            ),
                          if (!isSentByMe) SizedBox(width: context.mdW(8)),

                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.mdW(14),
                                vertical: context.mdH(10),
                              ),
                              decoration: BoxDecoration(
                                color: isSentByMe
                                    // ignore: deprecated_member_use
                                    ? (colorScheme.primary.withOpacity(0.5))
                                    // ignore: deprecated_member_use
                                    : (AppColors.grey[10]!.withOpacity(0.5)),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    context.mdRadius(16),
                                  ),
                                  topRight: Radius.circular(
                                    context.mdRadius(16),
                                  ),
                                  bottomLeft: isSentByMe
                                      ? Radius.circular(context.mdRadius(16))
                                      : Radius.zero,
                                  bottomRight: isSentByMe
                                      ? Radius.zero
                                      : Radius.circular(context.mdRadius(16)),
                                ),
                              ),
                              child: Directionality(
                                textDirection:
                                    viewModel.isArabic(textMessage.text)
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: MarkdownBody(
                                  data: textMessage.text,
                                  selectable: true,
                                  styleSheet: MarkdownStyleSheet.fromTheme(
                                    theme,
                                  ).copyWith(p: theme.textTheme.bodyLarge),
                                ),
                              ),
                            ),
                          ),

                          if (isSentByMe) SizedBox(width: context.mdW(8)),
                          if (isSentByMe)
                            CircleAvatar(
                              radius: context.mdW(18),
                              backgroundImage: hasUserPhoto
                                  ? NetworkImage(userPhoto)
                                  : const AssetImage(AppAssets.robot)
                                        as ImageProvider,
                              // ignore: deprecated_member_use
                              backgroundColor: colorScheme.surface.withOpacity(
                                0.1,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
            ),
          ),
        ),

        if (state.isSendingOrReceivingMessage)
          Builder(
            builder: (context) {
              final isRtl = Directionality.of(context) == TextDirection.rtl;

              return Padding(
                padding: EdgeInsets.only(
                  left: isRtl ? context.mdW(60) : context.mdW(8),
                  right: isRtl ? context.mdW(8) : context.mdW(60),
                  bottom: context.mdH(6),
                ),
                child: Row(
                  mainAxisAlignment: isRtl
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!isRtl)
                      CircleAvatar(
                        radius: context.mdW(18),
                        backgroundImage: const AssetImage(AppAssets.robot),
                        // ignore: deprecated_member_use
                        backgroundColor: colorScheme.surface.withOpacity(0.1),
                      ),
                    if (!isRtl) SizedBox(width: context.mdW(6)),

                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.mdW(14),
                          vertical: context.mdH(10),
                        ),
                        decoration: BoxDecoration(
                          // ignore: deprecated_member_use
                          color: (AppColors.grey[10]!.withOpacity(0.5)),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(context.mdRadius(16)),
                            topRight: Radius.circular(context.mdRadius(16)),
                            bottomRight: isRtl
                                ? Radius.zero
                                : Radius.circular(context.mdRadius(16)),
                            bottomLeft: isRtl
                                ? Radius.circular(context.mdRadius(16))
                                : Radius.zero,
                          ),
                        ),
                        child: const TypingIndicator(),
                      ),
                    ),

                    if (isRtl) SizedBox(width: context.mdW(6)),
                    if (isRtl)
                      CircleAvatar(
                        radius: context.mdW(18),
                        backgroundImage: const AssetImage(AppAssets.robot),
                        // ignore: deprecated_member_use
                        backgroundColor: colorScheme.surface.withOpacity(0.1),
                      ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
