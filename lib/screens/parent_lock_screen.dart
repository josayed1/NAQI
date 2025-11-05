import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_state.dart';

class ParentLockScreen extends StatefulWidget {
  final bool isSetup;
  final bool isDisabling;
  
  const ParentLockScreen({
    super.key,
    this.isSetup = false,
    this.isDisabling = false,
  });

  @override
  State<ParentLockScreen> createState() => _ParentLockScreenState();
}

class _ParentLockScreenState extends State<ParentLockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();
  bool _obscurePin = true;
  String? _errorMessage;

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.isSetup ? 'إعداد رمز PIN' : 'إدخال رمز PIN',
            style: const TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black87),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Color(0xFF3CB371),
                ),
                const SizedBox(height: 24),
                
                Text(
                  widget.isSetup
                      ? 'قم بإنشاء رمز PIN لحماية الإعدادات'
                      : widget.isDisabling
                          ? 'أدخل رمز PIN لإيقاف وضع الوالدين'
                          : 'أدخل رمز PIN للمتابعة',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // PIN Input
                TextField(
                  controller: _pinController,
                  obscureText: _obscurePin,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 8,
                  ),
                  decoration: InputDecoration(
                    labelText: 'رمز PIN',
                    hintText: '••••••',
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF3CB371),
                        width: 2,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePin ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePin = !_obscurePin;
                        });
                      },
                    ),
                  ),
                ),
                
                if (widget.isSetup) ...[
                  const SizedBox(height: 16),
                  
                  // Confirm PIN Input
                  TextField(
                    controller: _confirmPinController,
                    obscureText: _obscurePin,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      letterSpacing: 8,
                    ),
                    decoration: InputDecoration(
                      labelText: 'تأكيد رمز PIN',
                      hintText: '••••••',
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF3CB371),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
                
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ],
                
                const SizedBox(height: 32),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3CB371),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.isSetup ? 'تأكيد' : 'فتح',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Security note
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning_amber, color: Colors.orange, size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'احتفظ برمز PIN في مكان آمن. لا يمكن استرجاعه إذا فقد.',
                          style: TextStyle(fontSize: 12, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() async {
    final appState = Provider.of<AppState>(context, listen: false);
    final pin = _pinController.text.trim();

    if (pin.length < 4) {
      setState(() {
        _errorMessage = 'يجب أن يكون رمز PIN على الأقل 4 أرقام';
      });
      return;
    }

    if (widget.isSetup) {
      // Setup mode
      final confirmPin = _confirmPinController.text.trim();
      
      if (pin != confirmPin) {
        setState(() {
          _errorMessage = 'رموز PIN غير متطابقة';
        });
        return;
      }

      await appState.toggleParentMode(true, pin);
      
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تفعيل وضع الوالدين بنجاح'),
            backgroundColor: Color(0xFF3CB371),
          ),
        );
      }
    } else if (widget.isDisabling) {
      // Disabling mode
      if (appState.verifyParentPin(pin)) {
        await appState.toggleParentMode(false, null);
        
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إيقاف وضع الوالدين'),
              backgroundColor: Color(0xFF3CB371),
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = 'رمز PIN غير صحيح';
        });
      }
    } else {
      // Verify mode
      if (appState.verifyParentPin(pin)) {
        if (mounted) {
          Navigator.pop(context, true);
        }
      } else {
        setState(() {
          _errorMessage = 'رمز PIN غير صحيح';
        });
      }
    }
  }
}
