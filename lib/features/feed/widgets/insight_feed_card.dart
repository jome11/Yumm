import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/insight_model.dart';

IconData _iconFor(InsightTag tag) {
  switch (tag) {
    case InsightTag.warning:
      return Icons.warning_rounded;
    case InsightTag.priority:
      return Icons.bolt_rounded;
    case InsightTag.routine:
      return Icons.check_circle_rounded;
  }
}

class InsightFeedCard extends StatelessWidget {
  final InsightModel insight;
  final VoidCallback? onTap;

  const InsightFeedCard({super.key, required this.insight, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = AppColors.insightColor(insightTagLabel(insight.tag));
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_iconFor(insight.tag), color: Colors.white, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      insightTagLabel(insight.tag),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(insight.title,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(insight.meta,
                      style: TextStyle(color: Colors.white.withOpacity(0.65), fontSize: 11)),
                  const SizedBox(height: 8),
                  Text(insight.description,
                      style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12.5, height: 1.35)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
