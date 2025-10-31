import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class ParentalControlScreen extends StatefulWidget {
  const ParentalControlScreen({super.key});

  @override
  State<ParentalControlScreen> createState() => _ParentalControlScreenState();
}

class _ParentalControlScreenState extends State<ParentalControlScreen> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool _isSettingPin = false;
  
  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppStateProvider>(context);
    final isRTL = appState.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isRTL ? 'وضع الوالدين' : 'Parental Control'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icon
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3CB371).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      appState.isParentalControlEnabled
                          ? Icons.lock
                          : Icons.lock_open,
                      size: 50,
                      color: const Color(0xFF3CB371),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Status Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          isRTL ? 'الحالة' : 'Status',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          appState.isParentalControlEnabled
                              ? (isRTL ? 'مفعّل ✅' : 'Enabled ✅')
                              : (isRTL ? 'غير مفعّل' : 'Disabled'),
                          style: TextStyle(
                            fontSize: 16,
                            color: appState.isParentalControlEnabled
                                ? const Color(0xFF3CB371)
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Info Card
                Card(
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline, color: Colors.blue),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isRTL
                                ? 'عند تفعيل وضع الوالدين، سيتطلب إدخال رمز PIN لتغيير الإعدادات أو إيقاف الفلتر.'
                                : 'When enabled, PIN will be required to change settings or disable the filter.',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Enable/Disable Button or PIN Entry
                if (!appState.isParentalControlEnabled)
                  _buildEnableSection(context, appState, isRTL)
                else
                  _buildDisableSection(context, appState, isRTL),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildEnableSection(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    if (!_isSettingPin) {
      return ElevatedButton.icon(
        onPressed: () {
          setState(() {
            _isSettingPin = true;
          });
        },
        icon: const Icon(Icons.lock),
        label: Text(isRTL ? 'تفعيل وضع الوالدين' : 'Enable Parental Control'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3CB371),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      );
    }
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isRTL ? 'تعيين رمز PIN' : 'Set PIN Code',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isRTL ? 'رمز PIN (4 أرقام)' : 'PIN Code (4 digits)',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.pin, color: Color(0xFF3CB371)),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _confirmPinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isRTL ? 'تأكيد رمز PIN' : 'Confirm PIN',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.pin, color: Color(0xFF3CB371)),
              ),
            ),
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isSettingPin = false;
                        _pinController.clear();
                        _confirmPinController.clear();
                      });
                    },
                    child: Text(isRTL ? 'إلغاء' : 'Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _handleSetPin(context, appState, isRTL);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3CB371),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(isRTL ? 'تأكيد' : 'Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDisableSection(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              isRTL ? 'إيقاف وضع الوالدين' : 'Disable Parental Control',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              decoration: InputDecoration(
                labelText: isRTL ? 'أدخل رمز PIN' : 'Enter PIN Code',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.pin, color: Color(0xFF3CB371)),
              ),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () {
                _handleDisable(context, appState, isRTL);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(isRTL ? 'إيقاف التفعيل' : 'Disable'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _handleSetPin(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    final pin = _pinController.text;
    final confirmPin = _confirmPinController.text;
    
    if (pin.length != 4) {
      _showError(
        context,
        isRTL ? 'يجب أن يكون الرمز 4 أرقام' : 'PIN must be 4 digits',
      );
      return;
    }
    
    if (pin != confirmPin) {
      _showError(
        context,
        isRTL ? 'الرمزان غير متطابقين' : 'PINs do not match',
      );
      return;
    }
    
    appState.setParentalControl(true, pin);
    
    setState(() {
      _isSettingPin = false;
      _pinController.clear();
      _confirmPinController.clear();
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRTL
            ? '✅ تم تفعيل وضع الوالدين'
            : '✅ Parental control enabled'),
        backgroundColor: const Color(0xFF3CB371),
      ),
    );
  }
  
  void _handleDisable(
    BuildContext context,
    AppStateProvider appState,
    bool isRTL,
  ) {
    final pin = _pinController.text;
    
    if (pin.length != 4) {
      _showError(
        context,
        isRTL ? 'يجب أن يكون الرمز 4 أرقام' : 'PIN must be 4 digits',
      );
      return;
    }
    
    if (!appState.verifyParentalPin(pin)) {
      _showError(
        context,
        isRTL ? '❌ رمز PIN غير صحيح' : '❌ Incorrect PIN',
      );
      return;
    }
    
    appState.setParentalControl(false, null);
    _pinController.clear();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isRTL
            ? '✅ تم إيقاف وضع الوالدين'
            : '✅ Parental control disabled'),
      ),
    );
  }
  
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
