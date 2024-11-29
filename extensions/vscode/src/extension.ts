// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below

import {addFeature} from "./commands/add/feature.command";
import {addStructure} from "./commands/add/structure.command";
import {addComponent} from "./commands/add/component.command";
import {commands, ExtensionContext} from "vscode";
import {addModel} from "./commands/add/model.command";
import {addAdmob} from "./commands/add/admob.command";
import {addNotifications} from "./commands/add/notifications.command";
import {createApp} from "./commands/create/app.command";
import {addDataLayer} from "./commands/add/data-layer.command";
import {addDomainLayer} from "./commands/add/domain-layer.command";
import {addPresentationLayer} from "./commands/add/presentation-layer.command";
import {addAuth} from "./commands/add/authentication.command";
import {addDeepLinks} from "./commands/add/deeplinks.command";
import {addAssets} from "./commands/add/assets.command";
import {createPackage} from "./commands/create/package.command";
import {createEcosystem} from "./commands/create/ecosystem.command";
import {addUserLocation} from "./commands/add/user-location.command";
import {addEcosystemPresentationLayer} from "./commands/add/ecosystem-presentation-layer.command";
import {addEcosystemDataLayer} from "./commands/add/ecosystem-data-layer.command";
import {addEcosystemDomainLayer} from "./commands/add/ecosystem-domain-layer.command";
import {addEcosystemFeature} from "./commands/add/ecosystem-feature.command";

// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
export function activate(context: ExtensionContext) {
  /// CREATE
  let app = commands.registerCommand("lets-yak.create-app", createApp);
  let newPackage = commands.registerCommand(
    "lets-yak.create-package",
    createPackage
  );
  let ecosystem = commands.registerCommand(
    "lets-yak.create-ecosystem",
    createEcosystem
  );

  /// ADD
  let feature = commands.registerCommand("lets-yak.add-feature", addFeature);

  let auth = commands.registerCommand("lets-yak.add-auth", addAuth);

  let data_layer = commands.registerCommand(
    "lets-yak.add-data-layer",
    addDataLayer
  );

  let domain_layer = commands.registerCommand(
    "lets-yak.add-domain-layer",
    addDomainLayer
  );

  let presentation_layer = commands.registerCommand(
    "lets-yak.add-presentation-layer",
    addPresentationLayer
  );

  let structure = commands.registerCommand(
    "lets-yak.add-structure",
    addStructure
  );
  let component = commands.registerCommand(
    "lets-yak.add-component",
    addComponent
  );
  let admob = commands.registerCommand("lets-yak.add-admob", addAdmob);

  let notifications = commands.registerCommand(
    "lets-yak.add-notifications",
    addNotifications
  );

  let model = commands.registerCommand("lets-yak.add-model", addModel);

  let deepLinks = commands.registerCommand(
    "lets-yak.add-deeplinks",
    addDeepLinks
  );

  let assets = commands.registerCommand("lets-yak.add-assets", addAssets);

  let userLocation = commands.registerCommand(
    "lets-yak.add-user-location",
    addUserLocation
  );

  let ecosystemFeature = commands.registerCommand(
    "lets-yak.add-ecosystem-feature",
    addEcosystemFeature
  );

  let ecosystemPresentation = commands.registerCommand(
    "lets-yak.add-ecosystem-presentation-layer",
    addEcosystemPresentationLayer
  );

  let ecosystemData = commands.registerCommand(
    "lets-yak.add-ecosystem-data-layer",
    addEcosystemDataLayer
  );

  let ecosystemDomain = commands.registerCommand(
    "lets-yak.add-ecosystem-domain-layer",
    addEcosystemDomainLayer
  );

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
    assets,
    userLocation,
    ecosystemFeature,
    ecosystemPresentation,
    ecosystemData,
    ecosystemDomain
  );
}

// this method is called when your extension is deactivated
export function deactivate() {}
