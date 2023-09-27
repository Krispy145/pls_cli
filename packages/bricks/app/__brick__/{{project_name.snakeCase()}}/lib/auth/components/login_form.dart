import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:{{project_name.snakeCase()}}/auth/_auth.dart';
import 'package:{{project_name.snakeCase()}}/navigation/_navigation.dart';

import '../../core/_core.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final passwordKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 450),
      child: BlocProvider(
        create: (context) => LoginBloc(),
        child: Column(
          children: [
            AutofillGroup(
              child: Column(
                children: [
                  _Username(
                    onNext: _handleNext,
                  ),
                  _Password(key: passwordKey, onSubmit: _handleSubmit),
                ],
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    FormBlocError(
                      alignment: Alignment.center,
                      text: state.formError,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      width: 159,
                      height: 62,
                      child: ElevatedButton(
                        onPressed: () => _handleSubmit(context),
                        child: Loader(
                          progressIndicatorColor: Colors.white,
                          isLoading: state.isLoading,
                          child: Text(
                            locale.actionLogin,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            TextButton(
              onPressed: () => context.pushRoute(
                const ForgottenPasswordRoute(),
              ),
              child: Text(
                locale.actionForgottenPasswordLink,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  /// Focus and scroll the password field into view.
  void _handleNext() {
    FocusScope.of(context).nextFocus();
    final targetContext = passwordKey.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.2,
      );
    }
  }

  void _handleSubmit(BuildContext context) {
    context.read<LoginBloc>().add(LoginSubmitted());
  }
}

class _Username extends StatelessWidget {
  final void Function() onNext;
  const _Username({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocSelector<LoginBloc, LoginState, String?>(
      selector: (state) => state.email.error,
      builder: (context, error) => TextInput.withError(
        labelText: locale.labelEmail,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        autofillHints: const [AutofillHints.email],
        error: error,
        onEditingComplete: onNext,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginEmailChanged(value)),
      ),
    );
  }
}

class _Password extends StatelessWidget {
  final void Function(BuildContext) onSubmit;
  const _Password({Key? key, required this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocSelector<LoginBloc, LoginState, String?>(
      selector: (state) => state.password.error,
      builder: (context, error) => TextInput.withError(
        keyboardType: TextInputType.text,
        autofillHints: const [AutofillHints.password],
        formFieldType: FormFieldType.password,
        labelText: locale.labelPassword,
        textInputAction: TextInputAction.go,
        onEditingComplete: () => onSubmit(context),
        hideable: true,
        error: error,
        onChanged: (value) =>
            context.read<LoginBloc>().add(LoginPasswordChanged(value)),
      ),
    );
  }
}
