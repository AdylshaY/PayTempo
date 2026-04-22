import 'package:flutter/material.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    super.key,
    required this.selectedCurrency,
    required this.saving,
    required this.onPressed,
  });

  final ValueNotifier<String?> selectedCurrency;
  final ValueNotifier<bool> saving;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([selectedCurrency, saving]),
      builder: (BuildContext context, _) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: saving.value || selectedCurrency.value == null
                ? null
                : onPressed,
            child: saving.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Continue'),
          ),
        );
      },
    );
  }
}
