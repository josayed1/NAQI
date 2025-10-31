import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';
import '../l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _showPinDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final appState = Provider.of<AppState>(context, listen: false);

    _pinController.clear();
    _confirmPinController.clear();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.setPin),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.enterPin,
                hintText: '****',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.confirmPin,
                hintText: '****',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              if (_pinController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.pinRequired)),
                );
                return;
              }
              if (_pinController.text != _confirmPinController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.pinMismatch)),
                );
                return;
              }
              appState.setParentalPin(_pinController.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('PIN set successfully')),
              );
            },
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              
              // Quiet Mode
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
                child: SwitchListTile(
                  value: appState.quietMode,
                  onChanged: appState.setQuietMode,
                  title: Text(l10n.quietMode),
                  subtitle: Text(l10n.quietModeDesc),
                  secondary: Icon(
                    appState.quietMode
                        ? Icons.notifications_off
                        : Icons.notifications_active,
                    color: const Color(0xFF3CB371),
                  ),
                ),
              ),

              // Parental Control
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.child_care,
                        color: Color(0xFF3CB371),
                      ),
                      title: Text(l10n.parentalControl),
                      subtitle: Text(
                        appState.parentalPin != null
                            ? 'PIN is set'
                            : 'No PIN set',
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showPinDialog(context),
                      ),
                    ),
                    if (appState.parentalPin != null)
                      SwitchListTile(
                        value: appState.isParentalLocked,
                        onChanged: (value) async {
                          if (value) {
                            await appState.toggleParentalLock(true);
                          } else {
                            // Require PIN to unlock
                            await _verifyPinAndUnlock(context);
                          }
                        },
                        title: const Text('Lock Settings'),
                        secondary: Icon(
                          appState.isParentalLocked
                              ? Icons.lock
                              : Icons.lock_open,
                        ),
                      ),
                  ],
                ),
              ),

              // About Section
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 0,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Color(0xFF3CB371),
                      ),
                      title: Text(l10n.about),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.appName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${l10n.version}: 1.0.0',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.privacy,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // App Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3CB371), Color(0xFF90EE90)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.water_drop,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyPinAndUnlock(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final appState = Provider.of<AppState>(context, listen: false);
    final pinController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.enterPin),
        content: TextField(
          controller: pinController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'PIN',
            hintText: '****',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () {
              if (appState.verifyPin(pinController.text)) {
                Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid PIN')),
                );
              }
            },
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
          ),
        ],
      ),
    );

    pinController.dispose();

    if (result == true) {
      await appState.toggleParentalLock(false);
    }
  }
}
