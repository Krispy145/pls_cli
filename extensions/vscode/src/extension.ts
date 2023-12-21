// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below

import { newFeature } from "./commands/new-feature.command";
import { newStructure } from "./commands/new-structure.command";
import { addComponent } from "./commands/add-component.command";
import { commands, ExtensionContext } from "vscode";
import { addModel } from "./commands/add-model.command";
import { addAdmob } from "./commands/add-admob.command";
import { addNotifications } from "./commands/add-notifications.command";
import { createApp } from "./commands/create-app.command";

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: ExtensionContext) {
  let app = commands.registerCommand("digital-oasis.create-app", createApp);
  let feature = commands.registerCommand(
    "digital-oasis.new-feature",
    newFeature
  );

  let structure = commands.registerCommand(
    "digital-oasis.new-structure",
    newStructure
  );
  let component = commands.registerCommand(
    "digital-oasis.add-component",
    addComponent
  );
  let admob = commands.registerCommand("digital-oasis.add-admob", addAdmob);

  let notifications = commands.registerCommand(
    "digital-oasis.add-notifications",
    addNotifications
  );

  let model = commands.registerCommand("digital-oasis.add-model", addModel);

  context.subscriptions.push(
    app,
    feature,
    structure,
    component,
    model,
    admob,
    notifications
  );
}

// this method is called when your extension is deactivated
export function deactivate() {}
