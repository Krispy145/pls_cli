import 'package:flutter_bloc/flutter_bloc.dart';

/// This is a utility bloc to allow global errors to be shown to the user.
///
/// which will use this cubit to show an appropriate error message
class GlobalErrorCubit extends Cubit<String?> {
  GlobalErrorCubit() : super(null);
  void showErrorMessage(String? message) {
    emit(message);
  }
}

/// Use this in any blocs [addError] function to display a pop up with the message
///
/// Example in a bloc:
/// ```dart
/// void _onEventThatProducesAnError(){
///  try{
///    // do something
///  } catch(e){
///    // show a scaffold
///    addError(GlobalErrorMessage("This error will show on a snackbar $e"));
///  }
/// }
/// ```
class GlobalErrorMessage {
  final String message;
  GlobalErrorMessage(this.message);
}
