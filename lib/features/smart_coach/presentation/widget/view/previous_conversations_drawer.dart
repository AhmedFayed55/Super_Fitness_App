import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/theme/colors.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/core/helpers/dialogue_utils.dart';

class PreviousConversationsDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> conversations;
  final bool isLoading;
  final VoidCallback? onClose;
  final Function(String)? onSelectConversation;
  final Function(String)? onDeleteConversation;

  const PreviousConversationsDrawer({
    super.key,
    required this.conversations,
    this.isLoading = false,
    this.onClose,
    this.onSelectConversation,
    this.onDeleteConversation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Align(
      alignment: isRTL ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        width: context.mdW(263),
        height: double.infinity,
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: AppColors.grey[10]!.withOpacity(0.9),
          borderRadius: BorderRadius.only(
            topLeft: isRTL ? Radius.zero : Radius.circular(context.mdRadius(32)),
            bottomLeft: isRTL ? Radius.zero : Radius.circular(context.mdRadius(32)),
            topRight: isRTL ? Radius.circular(context.mdRadius(32)) : Radius.zero,
            bottomRight: isRTL ? Radius.circular(context.mdRadius(32)) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: AppColors.black.withOpacity(0.4),
              blurRadius: context.mdW(10),
              offset: Offset(isRTL ? context.mdW(4) : -context.mdW(4), 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.mdW(20),
            vertical: context.mdH(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.mdH(50)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      context.localization.previous_conversations,
                      style: theme.textTheme.displayMedium,
                    ),
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: Icon(
                      Icons.close,
                      color: colorScheme.onPrimary,
                      size: context.mdIcon(20),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.mdH(16)),

              if (isLoading)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                  ),
                )
              else if (conversations.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      context.localization.no_conversations_yet,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: conversations.length,
                    separatorBuilder: (context, index) =>
                        Container(height: 0.5, color: AppColors.grey[30]),
                    itemBuilder: (context, index) {
                      final chat = conversations[index];
                      final chatId = chat['id'] as String;
                      final title = chat['title'] as String;

                      return InkWell(
                        onTap: () => onSelectConversation?.call(chatId),
                        borderRadius: BorderRadius.circular(
                          context.mdRadius(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: context.mdH(10),
                            horizontal: context.mdW(8),
                          ),
                          child: Row(
                            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                            children: [
                              Icon(
                                isRTL ? Icons.arrow_forward_ios_rounded : Icons.arrow_back_ios_new_rounded,
                                color: colorScheme.primary,
                                size: context.mdIcon(14),
                              ),
                              SizedBox(width: context.mdW(16)),
                              Expanded(
                                child: Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    _showDeleteDialog(context, chatId, title),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: AppColors.grey[70],
                                  size: context.mdIcon(20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String chatId, String title) {
    DialogueUtils.showMessage(
      context: context,
      title: context.localization.delete_conversation,
      message: context.localization.are_you_sure_delete(title),
      posActionName: context.localization.delete,
      posAction: () => onDeleteConversation?.call(chatId),
      ngeActionName: context.localization.cancel,
    );
  }
}
