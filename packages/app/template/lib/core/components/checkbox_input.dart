import 'package:flutter/material.dart';
import 'package:flutter_template/core/_core.dart';

class CheckboxInput extends StatefulWidget {
  final void Function(bool)? onChanged;
  final String? labelText;
  final TextStyle? labelStyle;
  final Widget? label;
  final double? gap;
  const CheckboxInput({
    Key? key,
    this.onChanged,
    this.labelText,
    this.label,
    this.gap,
    this.labelStyle,
  })  : assert(
          (label != null && labelText == null) ||
              (labelText != null && label == null),
          "Either label or labelText must not be null",
        ),
        super(key: key);

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  bool _isOn = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: _handleChange,
          child: Row(
            children: [
              IgnorePointer(
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: AppColors.textBlack),
                  child: Checkbox(
                    side: const BorderSide(),
                    checkColor: Colors.white,
                    activeColor: AppColors.textBlack,
                    // materialTapTargetSize: MaterialTapTargetSize.padded,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _isOn,
                    onChanged: (_) {},
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: widget.gap ?? 8.0),
                  child: widget.label ??
                      Text(
                        widget.labelText!,
                        overflow: TextOverflow.ellipsis,
                        style: widget.labelStyle ??
                            const TextStyle(
                              fontSize: 12,
                              fontFamily: 'ProgramOTBook',
                              color: AppColors.textBlack,
                            ),
                      ),
                ),
              ), // Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
      ),
    );
  }

  void _handleChange() {
    final newValue = !_isOn;
    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
    setState(() {
      _isOn = newValue;
    });
  }
}
