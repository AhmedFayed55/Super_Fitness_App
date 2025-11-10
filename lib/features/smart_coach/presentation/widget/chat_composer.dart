import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';

class ChatComposer extends StatelessWidget {
  final TextEditingController controller;
  final SmartChatState state;
  final Function(String) onSend;
  final SmartChatViewModel viewModel;

  const ChatComposer({
    super.key,
    required this.controller,
    required this.state,
    required this.onSend,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = context.colorScheme;
    final loc = context.localization;
    // ignore: deprecated_member_use
    final bgColor = colorScheme.surface.withOpacity(0.08);
    final borderColor = colorScheme.outline;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        // ignore: deprecated_member_use
        border: Border.all(color: borderColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: theme.textTheme.bodyMedium,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                hintText: loc.type_your_message,
                hintStyle: theme.textTheme.bodySmall,
                border: InputBorder.none,
              ),
              textDirection: viewModel.isArabic(controller.text)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              textAlign: viewModel.isArabic(controller.text)
                  ? TextAlign.right
                  : TextAlign.left,
              onSubmitted: onSend,
              onChanged: (_) {},
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => onSend(controller.text),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary,
              ),
              child: state.isSendingOrReceivingMessage
                  ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(
                      Icons.send_rounded,
                      color: colorScheme.onPrimary,
                      size: 20,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
