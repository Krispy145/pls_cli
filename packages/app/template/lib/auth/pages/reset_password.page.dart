import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/_core.dart';
import '../_auth.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  final String email;
  final String token;
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ResetPasswordBloc(),
        child: _ResetPasswordForm(email: email, token: token),
      ),
    );
  }
}

class _ResetPasswordForm extends StatelessWidget {
  final String email;
  final String token;
  const _ResetPasswordForm({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final locale = AppLocalizations.of(context);
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: _successListener,
      child: Column(
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocSelector<ResetPasswordBloc, ResetPasswordState, String?>(
                  selector: (state) => state.password.error,
                  builder: (context, error) {
                    return TextInput.withError(
                      formFieldType: FormFieldType.password,
                      error: error,
                      onChanged: (value) =>
                          context.read<ResetPasswordBloc>().add(
                                ResetPasswordChanged(value),
                              ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                BlocSelector<ResetPasswordBloc, ResetPasswordState, String?>(
                  selector: (state) => state.confirmPassword.error,
                  builder: (context, error) {
                    return TextInput.withError(
                      formFieldType: FormFieldType.password,
                      error: error,
                      onChanged: (value) =>
                          context.read<ResetPasswordBloc>().add(
                                ResetConfirmPasswordChanged(value),
                              ),
                    );
                  },
                ),
                BlocSelector<ResetPasswordBloc, ResetPasswordState, String?>(
                  selector: (state) => state.formError,
                  builder: (context, state) {
                    return FormBlocError(
                      textHeight: 50,
                      text: state,
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          BlocSelector<ResetPasswordBloc, ResetPasswordState, BlocStatus>(
            selector: (state) => state.status,
            builder: (context, state) => Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 13),
                    Loader(
                      isLoading: state == BlocStatus.loading,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                onPressed: () => context
                    .read<ResetPasswordBloc>()
                    .add(ResetPasswordSubmit(email: email, token: token)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _successListener(BuildContext _, ResetPasswordState state) {
    if (state.status == BlocStatus.success) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("An email has been sent to ${state.email.value}"),
      //   ),
      // );
    }
  }
}
