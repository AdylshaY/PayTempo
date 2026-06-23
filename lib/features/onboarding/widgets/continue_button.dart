import 'package:flutter/material.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

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
                : Text(l10n.continueButtonLabel),
          ),
        );
      },
    );
  }
}
