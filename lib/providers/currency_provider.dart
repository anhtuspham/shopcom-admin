import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Currency { usd, vnd }

class CurrencyNotifier extends StateNotifier<Currency> {
  CurrencyNotifier() : super(Currency.usd);

  void toggle() {
    state = state == Currency.usd ? Currency.vnd : Currency.usd;
  }

  void set(Currency currency) {
    state = currency;
  }
}

final currencyProvider = StateNotifierProvider<CurrencyNotifier, Currency>((ref) => CurrencyNotifier());
