// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below

import { addFeature } from "./commands/add/feature.command";
import { addStructure } from "./commands/add/structure.command";
import { addComponent } from "./commands/add/component.command";
import { commands, ExtensionContext } from "vscode";
import { addModel } from "./commands/add/model.command";
import { addAdmob } from "./commands/add/admob.command";
import { addNotifications } from "./commands/add/notifications.command";
import { createApp } from "./commands/create/app.command";
import { addDataLayer } from "./commands/add/data-layer.command";
import { addDomainLayer } from "./commands/add/domain-layer.command";
import { addPresentationLayer } from "./commands/add/presentation-layer.command";
import { addAuth } from "./commands/add/authentication.command";
import { addDeepLinks } from "./commands/add/deeplinks.command";
import { addAssets } from "./commands/add/assets.command";
import { createPackage } from "./commands/create/package.command";
import { createEcosystem } from "./commands/create/ecosystem.command";

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: ExtensionContext) {
  /// CREATE
  let app = commands.registerCommand("digital-oasis.create-app", createApp);
  let newPackage = commands.registerCommand(
    "digital-oasis.create-package",
    createPackage
  );
  let ecosystem = commands.registerCommand(
    "digital-oasis.create-ecosystem",
    createEcosystem
  );

  /// ADD
  let feature = commands.registerCommand(
    "digital-oasis.add-feature",
    addFeature
  );

  let auth = commands.registerCommand("digital-oasis.add-auth", addAuth);

  let data_layer = commands.registerCommand(
    "digital-oasis.add-data-layer",
    addDataLayer
  );

  let domain_layer = commands.registerCommand(
    "digital-oasis.add-domain-layer",
    addDomainLayer
  );

  let presentation_layer = commands.registerCommand(
    "digital-oasis.add-presentation-layer",
    addPresentationLayer
  );

  let structure = commands.registerCommand(
    "digital-oasis.add-structure",
    addStructure
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

  let deepLinks = commands.registerCommand(
    "digital-oasis.add-deeplinks",
    addDeepLinks
  );

  let assets = commands.registerCommand("digital-oasis.add-assets", addAssets);

  context.subscriptions.push(
    /// CREATE
    app,
    newPackage,
    ecosystem,

    /// ADD
    feature,
    auth,
    data_layer,
    domain_layer,
    presentation_layer,
    structure,
    component,
    model,
    admob,
    notifications,
    deepLinks,
    assets
  );
}

// this method is called when your extension is deactivated
export function deactivate() {}
