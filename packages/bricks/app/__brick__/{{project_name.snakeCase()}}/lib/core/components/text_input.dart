import 'package:flutter/material.dart';
import 'package:{{project_name.snakeCase()}}/core/_core.dart';

enum FormFieldType { password, text }

class TextInput extends StatefulWidget {
  /// Custom label positioned above the text field.
  final String? labelText;
  final double? elevation;

  /// Style for the [labelText].
  final TextStyle? labelStyle;
  final EdgeInsets? contentPadding;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final FormFieldType? formFieldType;
  final Function? onEditingComplete;
  final String? value;
  final bool? autocorrect;

  /// Widget positioned at the end of the text field. Inline with the [labelText]
  final Widget? endIcon;

  final Widget? labelSuffixIcon;

  /// Widget passed to the default [TextField] [InputDecoration.suffixIcon]
  final Widget? suffixIcon;
  final double? cursorHeight;
  final Color borderColor;
  final Color? cursorColor;

  /// Hint text passed through to the default [TextField]
  final String? hintText;

  final TextInputAction? textInputAction;

  /// Style for the [hintText].
  final TextStyle? hintStyle;
  final bool enabled;
  final List<String>? autofillHints;
  final TextEditingController? controller;
  final InputBorder? disabledBorder;
  final Widget? prefix;
  final bool hideable;
  final String? initialValue;
  final BoxConstraints? suffixIconConstraints;
  final FocusNode? focusNode;
  final String? _error;

  final bool _withError;

  /// Custom text field styled to the design.
  ///
  /// For a text field with error display see [TextInput.withError()].
  const TextInput({
    Key? key,
    this.initialValue,
    this.value,
    this.textInputAction,
    this.autofillHints,
    this.elevation,
    this.controller,
    this.autocorrect,
    this.focusNode,
    this.contentPadding,
    this.cursorColor,
    this.suffixIcon,
    this.labelSuffixIcon,
    this.labelText,
    this.suffixIconConstraints,
    this.onChanged,
    this.hintText,
    this.hintStyle,
    this.labelStyle,
    this.borderColor = Colors.black,
    this.keyboardType,
    this.onEditingComplete,
    this.formFieldType = FormFieldType.text,
    this.endIcon,
    this.style,
    this.cursorHeight,
    this.enabled = true,
    this.disabledBorder,
    this.prefix,
    this.hideable = false,
  })  : _withError = false,
        _error = null,
        super(key: key);

  /// Styled text field with a [FormBlocError] positioned below the input.
  ///
  /// If [error] is not null then the error will show. [FormBlocError] takes up
  /// 23pt of space regardless of whether there is an error or not. This makes sure
  /// the page sizing doesn't change when an error is visible.
  const TextInput.withError({
    Key? key,
    this.textInputAction,
    this.autofillHints,
    this.initialValue,
    this.elevation,
    this.controller,
    this.value,
    this.labelStyle,
    this.autocorrect,
    this.contentPadding,
    this.focusNode,
    this.suffixIcon,
    this.labelSuffixIcon,
    String? error,
    this.labelText,
    this.onChanged,
    this.cursorColor,
    this.keyboardType,
    this.hintText,
    this.hintStyle,
    this.borderColor = Colors.black,
    this.onEditingComplete,
    this.endIcon,
    this.suffixIconConstraints,
    this.formFieldType = FormFieldType.text,
    this.style,
    this.cursorHeight,
    this.enabled = true,
    this.disabledBorder,
    this.prefix,
    this.hideable = false,
  })  : _withError = true,
        _error = error,
        super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool showText = true;
  late final TextEditingController controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.formFieldType == FormFieldType.password) {
      showText = false;
    }
    _focusNode = widget.focusNode ?? FocusNode();

    controller = widget.controller ??
        TextEditingController(text: widget.value ?? widget.initialValue ?? "");
  }

  @override
  void didUpdateWidget(covariant TextInput oldWidget) {
    if (oldWidget.controller != widget.controller &&
        widget.controller != null) {
      controller = widget.controller!;
    }
    if (widget.value != null && oldWidget.value != widget.value) {
      // move the cursor if the last letter of the value has changed
      final bool shouldMoveCursor = widget.value?.last != oldWidget.value?.last;

      controller.value = controller.value.copyWith(
        text: widget.value ?? controller.text,
        // Note(Dan): changed to only edit the cursor position if the end of the
        // string has changed.
        selection: shouldMoveCursor
            ? TextSelection.fromPosition(
                TextPosition(
                  offset: widget.value != null
                      ? widget.value!.length
                      : controller.text.length,
                ),
              )
            : null,
      );
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (widget._withError) {
      return Column(
        children: [
          _buildTextField(context),
          if (widget._error != null) FormBlocError(text: widget._error),
        ],
      );
    }
    return _buildTextField(context);
  }

  // This is the actual TextField.
  //
  // Placed in a method rather than a widget as it is the actual TextField and to
  // reduce the amount of prop drilling.
  Widget _buildTextField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                widget.labelText ?? "",
                style: widget.labelStyle ??
                    Theme.of(context).inputDecorationTheme.labelStyle,
              ),
            ),
            // _buildSuffixIcon() ?? const SizedBox(),
            // widget.suffixIcon ?? const SizedBox(), // labelSuffixIcon
            widget.labelSuffixIcon ?? const SizedBox(),
          ],
        ),
        Material(
          elevation: widget.elevation ?? 5,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            textInputAction: widget.textInputAction,
            autofillHints: widget.autofillHints,
            focusNode: _focusNode,
            autocorrect: widget.autocorrect ?? true,
            controller: controller,
            obscureText: !showText,
            onEditingComplete: widget.onEditingComplete as void Function()?,
            keyboardType: widget.keyboardType,
            onChanged: widget.onChanged,
            style: widget.style ??
                Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: AppColors.textBlack),
            cursorColor: widget.cursorColor ?? AppColors.textBlack,
            cursorHeight: widget.cursorHeight ?? 20,
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              prefixIconConstraints: const BoxConstraints(),
              suffixIconConstraints: widget.suffixIconConstraints ??
                  const BoxConstraints(
                    maxWidth: 40,
                    maxHeight: 44,
                  ),
              suffixIcon: widget.suffixIcon ?? _buildSuffixIcon(),
              hintText: widget.hintText,
              hintStyle: widget.hintStyle,
              isDense: true,
              enabled: widget.enabled,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.endIcon != null) return widget.endIcon;
    if (widget.formFieldType == FormFieldType.password && widget.hideable) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
          child: Icon(
            showText ? Icons.visibility : Icons.visibility_off,
            size: 30,
            color: Colors.black54,
          ),
          onTap: () => setState(() {
            showText = !showText;
          }),
        ),
      );
    }
    return null;
  }
}
