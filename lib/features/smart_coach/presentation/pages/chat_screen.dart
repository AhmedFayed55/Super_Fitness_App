import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/di/di.dart';
import 'package:super_fitness_app/core/extensions/extensions.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_event.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_state.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/view_model/smart_chat_view_model.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/shimmer/chat_welcome_shimmer.dart';
import 'package:super_fitness_app/features/smart_coach/presentation/widget/view/chat_welcome.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final vm = getIt.get<SmartChatViewModel>();
        vm.doIntent(InitializeChatEvent());
        vm.doIntent(LoadUserDataEvent());
        return vm;
      },
      child: BlocBuilder<SmartChatViewModel, SmartChatState>(
        builder: (context, state) {
          if (state.isLoadingUser || state.isLoading || state.isLoadingChats) {
            return const ChatWelcomeShimmer();
          }

          if (state.error != null && state.error!.isNotEmpty) {
            return Scaffold(
              body: Center(
                child: Text(state.error!, textAlign: TextAlign.center),
              ),
            );
          }

          if (state.userChats.isNotEmpty || state.currentChatId != null) {
            return const ChatWelcomeView();
          }

          return Scaffold(
            body: Center(
              child: Text(
                context.localization.no_conversations_yet,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}
