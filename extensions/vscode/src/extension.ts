// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as cp from "child_process";
import * as path from "path";
import { newFeature } from "./commands/new-feature.command";
import { addComponent } from "./commands/add-component.command";
import { addPage } from "./commands/add-page.command";
import { commands, ExtensionContext } from "vscode";
import { addBloc } from "./commands/add-bloc.command";
import { addCubit } from "./commands/add-cubit.command";
import { addModel } from "./commands/add-model.command";
import { addFile } from "./commands/add-file.command";
import { addBlocEvent } from "./commands/add-bloc-event.command";
import { addFormInput } from "./commands/add-input.command";

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: ExtensionContext) {
  let feature = commands.registerCommand(
    "digital-oasis.new-feature",
    newFeature
  );
  let component = commands.registerCommand(
    "digital-oasis.add-component",
    addComponent
  );
  
  
  let model = commands.registerCommand("digital-oasis.add-model", addModel);
  let newFile = commands.registerCommand("digital-oasis.add-file", addFile);
  let formInput = commands.registerCommand(
    "digital-oasis.add-input",
    addFormInput
  );

  context.subscriptions.push(
    feature,
    formInput,
    component,    
    model,
    newFile,
  );
}

// this method is called when your extension is deactivated
export function deactivate() {}
