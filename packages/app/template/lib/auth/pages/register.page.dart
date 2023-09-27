import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/_core.dart';
import '../_auth.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 35.0;
    return Scaffold(
      body: Stack(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => RegisterBloc(),
              ),
            ],
            child: const RemoveFocusWrapper(
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: _RegisterForm(
                        horizontalPadding: horizontalPadding,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 22, top: 35),
              child: Text(
                "1 of 4",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final double horizontalPadding;
  const _RegisterForm({
    Key? key,
    required this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        right: horizontalPadding,
        left: horizontalPadding,
        top: 20,
      ),
      child: ListView(
        children: [
          BlocSelector<RegisterBloc, RegisterState, String?>(
            selector: (state) => state.name.error,
            builder: (context, error) {
              return TextInput.withError(
                error: error,
                onChanged: (value) => context.read<RegisterBloc>().add(
                      RegisterNameChanged(value),
                    ),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocSelector<RegisterBloc, RegisterState, String?>(
            selector: (state) => state.email.error,
            builder: (context, error) {
              return TextInput.withError(
                keyboardType: TextInputType.emailAddress,
                error: error,
                onChanged: (value) => context.read<RegisterBloc>().add(
                      RegisterEmailChanged(value),
                    ),
              );
            },
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          BlocSelector<RegisterBloc, RegisterState, String?>(
            selector: (state) => state.password.error,
            builder: (context, error) {
              return TextInput.withError(
                formFieldType: FormFieldType.password,
                error: error,
                onChanged: (value) => context.read<RegisterBloc>().add(
                      RegisterPasswordChanged(value),
                    ),
              );
            },
          ),
          const SizedBox(height: 8),
          BlocSelector<RegisterBloc, RegisterState, String?>(
            selector: (state) => state.confirmPassword.error,
            builder: (context, error) {
              return TextInput.withError(
                formFieldType: FormFieldType.password,
                error: error,
                onChanged: (value) => context.read<RegisterBloc>().add(
                      RegisterConfirmPasswordChanged(value),
                    ),
              );
            },
          ),
          BlocSelector<RegisterBloc, RegisterState, String?>(
            selector: (state) => state.hasAgreed.error,
            builder: (context, error) {
              return Column(
                children: [
                  CheckboxInput(
                    onChanged: (value) => context.read<RegisterBloc>().add(
                          RegisterHasAgreedChanged(value),
                        ),
                    gap: 0,
                    label: RichText(
                      text: TextSpan(
                        text: "text ",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ),
                  FormBlocError(text: error),
                ],
              );
            },
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
