import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends FormField<T> {
  /// Creates a [DropdownButton] widget wrapped in an [InputDecorator] and
  /// [FormField].
  ///
  /// The [DropdownButton] [items] parameters must not be null.
  CustomDropdownButtonFormField({
    Key key,
    T value,
    @required List<DropdownMenuItem<T>> items,
    DropdownButtonBuilder selectedItemBuilder,
    Widget hint,
    @required this.onChanged,
    this.decoration = const InputDecoration(),
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
    bool autovalidate = false,
    Widget disabledHint,
    int elevation = 8,
    TextStyle style,
    Widget icon,
    Color iconDisabledColor,
    Color iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight,
  }) : assert(items == null || items.isEmpty || value == null ||
      items.where((DropdownMenuItem<T> item) {
        return item.value == value;
      }).length == 1,
  'There should be exactly one item with [DropdownButton]\'s value: '
      '$value. \n'
      'Either zero or 2 or more [DropdownMenuItem]s were detected '
      'with the same value',
  ),
        assert(decoration != null),
        assert(elevation != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(itemHeight == null || itemHeight > 0),
        super(
        key: key,
        onSaved: onSaved,
        initialValue: value,
        validator: validator,
        autovalidate: autovalidate,
        builder: (FormFieldState<T> field) {
          final InputDecoration effectiveDecoration = decoration.applyDefaults(
            Theme.of(field.context).inputDecorationTheme,
          );
          return InputDecorator(
            decoration: effectiveDecoration.copyWith(errorText: field.errorText),
            isEmpty: field.value == null,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: field.value,
                items: items,
                selectedItemBuilder: selectedItemBuilder,
                hint: hint,
                onChanged: onChanged == null ? null : field.didChange,
                disabledHint: disabledHint,
                elevation: elevation,
                style: style,
                icon: icon,
                iconDisabledColor: iconDisabledColor,
                iconEnabledColor: iconEnabledColor,
                iconSize: iconSize,
                isDense: isDense,
                isExpanded: isExpanded,
                itemHeight: itemHeight,
              ),
            ),
          );
        },
      );

  /// {@macro flutter.material.dropdownButton.onChanged}
  final ValueChanged<T> onChanged;

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  @override
  FormFieldState<T> createState() => _DropdownButtonFormFieldState<T>();
}

class _DropdownButtonFormFieldState<T> extends FormFieldState<T> {
  @override
  CustomDropdownButtonFormField<T> get widget => super.widget as CustomDropdownButtonFormField<T>;

  @override
  void didChange(T value) {
    super.didChange(value);
    assert(widget.onChanged != null);
    widget.onChanged(value);
  }
}
