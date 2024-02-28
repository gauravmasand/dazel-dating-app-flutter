import 'package:flutter/foundation.dart';

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(this.initialValue) : super(initialValue);

  late final T? initialValue;

  void reset() => value = initialValue;
}
