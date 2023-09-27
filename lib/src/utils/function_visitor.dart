import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Find all the functions in a given file.
class FunctionVisitor extends SimpleAstVisitor<FunctionVisitor> {
  /// Callback used when a switch case is found
  final void Function(SwitchCase)? onCaseFound;

  /// Callback used when a expression funciton body is found
  final void Function(ExpressionFunctionBody)? onExpressionFunctionBodyFound;

  /// The first found switch case in the body of a function
  SwitchCase? switchCase;

  /// Find all the functions in a given file.
  FunctionVisitor({this.onCaseFound, this.onExpressionFunctionBodyFound});

  @override
  FunctionVisitor? visitBlock(Block node) {
    node.visitChildren(FunctionVisitor(onCaseFound: onCaseFound));
    return super.visitBlock(node);
  }

  @override
  FunctionVisitor? visitExpressionFunctionBody(ExpressionFunctionBody node) {
    onExpressionFunctionBodyFound?.call(node);
    return super.visitExpressionFunctionBody(node);
  }

  @override
  FunctionVisitor? visitSwitchStatement(SwitchStatement node) {
    node.visitChildren(FunctionVisitor(onCaseFound: onCaseFound));
    return super.visitSwitchStatement(node);
  }

  @override
  FunctionVisitor? visitSwitchCase(SwitchCase node) {
    if (switchCase == null && onCaseFound != null) {
      switchCase = node;
      onCaseFound!(node);
    }
    return super.visitSwitchCase(node);
  }
}
