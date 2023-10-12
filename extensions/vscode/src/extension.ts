// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below

import { newFeature } from "./commands/new-feature.command";
import { addComponent } from "./commands/add-component.command";
import { commands, ExtensionContext } from "vscode";
import { addModel } from "./commands/add-model.command";
import { addAdmob } from "./commands/add-admob.command";


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
  let admob = commands.registerCommand(
    "digital-oasis.add-admob",
    addAdmob
  );
  
  
  let model = commands.registerCommand("digital-oasis.add-model", addModel);
  
  

  context.subscriptions.push(
    feature,
    component,    
    model,
    admob,  
  );
}

// this method is called when your extension is deactivated
export function deactivate() {}
