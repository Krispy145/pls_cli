import 'package:bloc_forms/bloc_forms.dart';

final passwordValidator = FormInputModel<String>(
  validator: (value) =>
      value.required(message: "Please enter a password") ??
      value?.validateLength(
        8,
        message: "Your password must be at least 8 characters long.",
      ) ??
      value?.validatePattern(
        pattern: RegExp(
          r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$",
        ),
        message:
            "Your password must contain at least: one uppercase, one lowercase and one special character.",
      ),
);
