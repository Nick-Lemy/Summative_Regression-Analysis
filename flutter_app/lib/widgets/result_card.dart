import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ResultCard extends StatelessWidget {
  final String result;
  final bool hasError;
  
  const ResultCard({
    super.key,
    required this.result,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              'Prediction will appear here',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: hasError ? null : AppColors.cardGradient,
        color: hasError ? Colors.red.shade50 : null,
        borderRadius: BorderRadius.circular(16),
        border: hasError ? Border.all(color: AppColors.error, width: 2) : null,
        boxShadow: hasError
            ? null
            : [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(
            hasError ? Icons.error_outline : Icons.work_outline,
            size: 48,
            color: hasError ? AppColors.error : Colors.white,
          ),
          const SizedBox(height: 16),
          Text(
            hasError ? 'Error' : 'Predicted Unemployment Rate',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: hasError ? AppColors.error : Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            result,
            style: TextStyle(
              fontSize: hasError ? 16 : 36,
              fontWeight: FontWeight.bold,
              color: hasError ? AppColors.error : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          if (!hasError) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Prediction Complete',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
