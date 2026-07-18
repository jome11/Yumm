import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yumm/views/widgets/error_view.dart';
import 'package:yumm/views/widgets/loading_indicator.dart';
import 'package:yumm/viewmodels/feed_bloc.dart';
import 'package:yumm/viewmodels/feed_event.dart';
import 'package:yumm/viewmodels/feed_state.dart';
import 'package:yumm/views/widgets/insight_feed_card.dart';
import 'package:yumm/constants.dart';
import 'package:yumm/views/hive_detail_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedBloc()..add(const FeedRequested()),
      child: const _FeedBody(),
    );
  }
}

class _FeedBody extends StatefulWidget {
  const _FeedBody();

  @override
  State<_FeedBody> createState() => _FeedBodyState();
}

class _FeedBodyState extends State<_FeedBody> {
  final _chatController = TextEditingController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.intelligence,
            style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w800, fontSize: 24)),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<FeedBloc, FeedState>(
              builder: (context, state) {
                if (state.status == FeedStatus.loading || state.status == FeedStatus.initial) {
                  return const LoadingIndicator();
                }
                if (state.status == FeedStatus.failure) {
                  return ErrorView(
                    message: state.errorMessage ?? 'Failed to load feed.',
                    onRetry: () => context.read<FeedBloc>().add(const FeedRequested()),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async => context.read<FeedBloc>().add(const FeedRequested()),
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: state.insights
                        .map((insight) => InsightFeedCard(
                              insight: insight,
                              onTap: insight.relatedHiveId == null
                                  ? null
                                  : () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HiveDetailScreen(hiveId: insight.relatedHiveId!),
                                        ),
                                      ),
                            ))
                        .toList(),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface(context),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppColors.divider(context)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.image_outlined, color: AppColors.textSecondary(context)),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.mic_none_rounded, color: AppColors.textSecondary(context)),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: _chatController,
                        style: TextStyle(color: AppColors.textPrimary(context)),
                        decoration: InputDecoration(
                          hintText: AppStrings.askAi,
                          hintStyle: TextStyle(color: AppColors.textSecondary(context)),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.arrow_upward_rounded, size: 18, color: Colors.white),
                        onPressed: () {
                          if (_chatController.text.trim().isEmpty) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('YummBeeGuard AI is not connected yet.')),
                          );
                          _chatController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
