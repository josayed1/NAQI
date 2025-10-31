import 'package:flutter/material.dart';
import '../utils/app_localizations.dart';

class FilterToggleCard extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onToggle;
  final AppLocalizations locale;

  const FilterToggleCard({
    super.key,
    required this.isEnabled,
    required this.onToggle,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: isEnabled
                ? [const Color(0xFF3CB371), const Color(0xFF90EE90)]
                : [Colors.grey[300]!, Colors.grey[200]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Water Drop Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.water_drop,
                  size: 48,
                  color: isEnabled ? Colors.white : Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Status Text
              Text(
                locale.filterStatus,
                style: TextStyle(
                  fontSize: 16,
                  color: isEnabled ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Enabled/Disabled Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isEnabled ? locale.filterEnabled : locale.filterDisabled,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isEnabled ? const Color(0xFF3CB371) : Colors.grey[600],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Toggle Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onToggle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: isEnabled ? const Color(0xFF3CB371) : Colors.grey[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isEnabled ? Icons.stop_circle_outlined : Icons.play_circle_outline,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isEnabled ? locale.disableFilter : locale.enableFilter,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
