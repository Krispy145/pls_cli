import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/_core.dart';
import '../_auth.dart';

@RoutePage()
class ForgottenPasswordPage extends StatelessWidget {
  const ForgottenPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgotten Password"),
      ),
      body: BlocProvider(
        create: (_) => ForgottenPasswordBloc(),
        child: const _ForgottenPasswordForm(),
      ),
    );
  }
}

class _ForgottenPasswordForm extends StatelessWidget {
  const _ForgottenPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final locale = AppLocalizations.of(context);
    return BlocListener<ForgottenPasswordBloc, ForgottenPasswordState>(
      listener: _successListener,
      child: Column(
        children: [
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocSelector<ForgottenPasswordBloc, ForgottenPasswordState,
                    String?>(
                  selector: (state) => state.email.error,
                  builder: (context, state) {
                    return TextInput.withError(
                      style: Theme.of(context).textTheme.bodyLarge,
                      cursorHeight: 20,
                      onChanged: (value) => context
                          .read<ForgottenPasswordBloc>()
                          .add(ForgottenPasswordEmailChanged(value)),
                    );
                  },
                ),
                BlocSelector<ForgottenPasswordBloc, ForgottenPasswordState,
                    String?>(
                  selector: (state) => state.formError,
                  builder: (context, state) {
                    return FormBlocError(text: state);
                  },
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          BlocSelector<ForgottenPasswordBloc, ForgottenPasswordState,
              BlocStatus>(
            selector: (state) => state.status,
            builder: (context, state) => Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Loader(
                      isLoading: state == BlocStatus.loading,
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
                onPressed: () => context
                    .read<ForgottenPasswordBloc>()
                    .add(ForgottenPasswordSubmit()),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _successListener(BuildContext context, ForgottenPasswordState state) {
    if (state.status == BlocStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An email has been sent to ${state.email.value}"),
        ),
      );
    }
  }
}
