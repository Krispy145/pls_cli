
# Digital Oasis Cli

A cli for quickly generating boilerplate files with a vscode extension.

### Installing the cli

To install make sure flutter is installed then run:

```
flutter pub global activate -sgit {{githubPath}}
```

## Commands

The command line tool can be used with `rn` or `render` both will be added to path

Each command follows the format:

```
render <command> <subcommand> [options]
```

> :zap:
>
> All commands and options are documented automatically by the cli. Run `rn --help` or `rn add bloc --help` to view the options and subcommands of the current command.

The following is the structure of the commands.

- [Add](#add)
  - [ Bloc ](#bloc)
  - [ Component ](#component)
  - [ Cubit ](#cubit)
  - [ Event ](#event)
  - [ Feature ](#feature)
  - [ File ](#file)
  - [ Input ](#input)
  - [ Model ](#model)
  - [ Page ](#page)
  - [ Assets ](#assets)
  - [ Fonts ](#fonts)
- [ Deploy ](#deploy)
- [ Create ](#create)
- [ Find ](#find)
  - Project-root
- [ List ](#list)
  - Features
  - Route-generators
- [ Run ](#run)
- [ Update ](#update)

### Add

The add command generates various boilerplates for a flutter app. Most commands have the `--feature (-f)` option which is the feature to add the generation to.

For example below would add a bloc to the user feature.

```
rn add bloc -f user
```

It can also be used for nested features eg.

```
rn add component -f user/profile
```

This would add a component to the **profile** feature which is inside the **user** feature.

Most commands also allow you to specify the path to a feature with the `--path (-p)`. The path can be relative or absolute. eg.

```
rn add bloc -p lib/user
```

#### Bloc

Adds a new bloc to a feature.

Options:

- `(-p) --path <path/to/feature>` the path to the feature which will contain the bloc
- `(-f) --feature <feature>` the feature to add the bloc to
- `(-n) --name <name>` The name of the bloc.
- `--form` Whether the bloc is a form bloc or not. Defaults to false `--no-form`.
- `(-i) --inputs <list,of,inputs>` If the bloc is a form this is a string containing a comma separated list of inputs for the form. Eg "email,password"
- `(-e) --events <list,of,events>` If the bloc is **NOT** a form then this is the list of events the bloc should have.

#### Component

Adds a new component to a feature.

Options:

- `(-p) --path` Directory of the feature where to output the generated code.
- `(-n), --name` The name of the generated component.
- `(-f), --feature` Add the generation to a feature

#### Cubit

Adds a cubit to a feature.

- `(-p) --path` Directory where to output the generated code.
- `(-n) --name` The name of the generated item.
- `(-f) --feature` Add the generation to a feature
- `--[no-]form` Creates a form cubit
- `--[no-]hasState` Whether the cubit has a freezed state class
- `(-i) --inputs <list,of,inputs>` Inputs to add to a form. Only used in a form bloc

#### Event

Adds an event to an already existing bloc.

Options:

- `(-p) --path <path/to/user_bloc.dart>` Path to the bloc file
- `--name` The name of the event

#### Feature

Adds the skeleton of a feature.

Options:

- `(-p) --path` Directory where to output the generated code.
- `(-n) --name` The name of the generated item.
- `(-f) --feature` Add the generation to a feature

#### File

Adds a new file along with a barrel file of the same name as the parent directory. This command is similar to `touch <file>`.

For example the following command will add the file `user.repo.dart` to the repositories directory and also add an `_repositories.dart` file which will export `user.repo.dart`

```
rn add file -p lib/user/repositories/user.repo.dart
```

Options:

- `(-p) --path` The path and file name to be generated. The path will recursively create folders if they don't exist.

#### Input

Adds a form input to a already existing bloc or cubit.

Options:

- `(-p) --path <path/to/user_cubit.dart>` Path to the bloc or cubit file
- `--name` The name of the event

#### Model

Adds a model to a feature.

Options:

- `(-p) --path` Directory where to output the generated code.
- `(-n) --name` The name of the generated item.
- `(-f) --feature` Add the generation to a feature
- `--serializable` Whether the model should be serializable and have the `fromJson` method.

#### Page

Adds a page to a feature and adds the route to the route_generator file.

Options:

- `(-p) --path` Directory where to output the generated code.
- `(-n) --name` The name of the generated item.
- `(-f) --feature` Add the generation to a feature
- `--[no-]args` Whether the page has Arguments. Defaults to false.

#### Assets

The assets command will generate a dart file with an enum style static class of all the assets.

#### Fonts

The fonts command will take the names of the fonts in the assets/fonts folder and add them to the pubspec.yaml file. It will also generate a dart file with an enum style class of font families.

The files in the font directory must be in the format `<font-family>-<weight>-<style>.(ttf | other)`

### Deploy

Tag and push a project which will trigger a deploy to the app stores.

Options:

- `(-e) --environment` Select the environment for the build.
- `(-v) --version` Set the build number and version.

### Find

Find different aspects of the project. This intended for use as part of the vscode extension and is not very useful by it's self.

Available subcommands:

- `project-root`

### List

List different aspects of the project. This intended for use as part of the vscode extension and is not very useful by it's self.

Available subcommands:

- `features` List all features of the project
- `route-generators` List the route generators in a given file.

### Run

Run works like `npm run <script-name>`. It will find the script inside the `pubspec.yaml` and run it.

Scripts are can either be a string or an array. If the script is an array in needs to contain two fields in each map:

- `command` a string of the command to be run
- `cwd` (optional) the working directory in which to run the command
  Multiple commands can be added to the array and the will be executed sequentially.

> :white_check_mark:
>
> Use it to never have to type the stupid build runner command again!
>
> ```
> scripts:
>   gen: "flutter pub run build_runner build --delete-conflicting-outputs"
>   gen:api:
>     - command: flutter pub run build_runner build --delete-conflicting-outputs"
>       cwd: api
>
> ```

Usage:

```
rn run <script-name>
```

Run commands can also take environment variables. For an example look at the pubspec file in this project: 

```yaml
bundle: mason bundle ./packages/bricks/$BRICK -o ./lib/bundles/ -t dart
```
The script above can be run with `BRICK=cubit rn run bundle` which will replace the "$BRICK" with the matching env variable.


### Update

Updates the cli to the latest version on master or update and install the vscode extension.

## Vscode extension

The vscode extension is a wrapper around the command line tool. All of the **Add** commands can be done by right clicking the correct file or feature in the project explorer.

### Requirements

- Have node and npm installed
- Have the [render](#installing-the-cli) cli installed.
- Have the VScode command line tool enabled. To install this open the Command Palette (Cmd+Shift+P) and type 'shell command' to find the `Shell Command: Install 'code' command in PATH command`.

To install the extension, first install the command line tool, then run

```
rn update --vscode
```

This will clone the repo, build the extension and install it. Sometimes you may have to run it twice if you haven't already got it installed. TODO: fix this.

### Features

Only the Add commands are available.

- Bloc - Right click on a feature directory.
- Component - Right click on a feature directory.
- Cubit - Right click on a feature directory.
- Event - Right click on a bloc file.
- Feature - Right click on the lib folder or a feature directory.
- File - Right click on any directory.
- Input - Right click on a bloc or cubit file.
- Model - Right click on a feature directory.
- Page - Right click on a feature directory.

## Developing

Dart clis can be globally activated from a local path, this is useful for developing. 
```sh
flutter pub global activate -spath . --overwrite
```

This project uses [mason](https://pub.dev/packages/mason) to parse and bundle the templates. This is all done while developing so that the end user doesn't need mason installed.

All of the bricks used throughout this app are in the `packages/bricks` folder. 

### The App Brick (Used in Create)

> **Warning**
> Do not edit the "app" brick directly.

The app brick is automatically generated by the `./packages/app_brick_generator/` tool. The source of the app brick can be found in the `./packages/app/template/` folder. The template is a fully working flutter app and can be run while developing to test new features and additions. 

Once the template is ready to be used in the create command it needs to be transpiled to a brick. This is where all the references to "flutter_template" are replaced with moustache syntax ready for the `create` command.

To transpile the template run the following in the cli root directory (you can see the underlying command in the pubspec):

```sh
rn run bundle:app
```

Then like all other bricks it must be bundled into the cli using:
```sh
BRICK=app run bundle
```

### Developing Bricks

All bricks apart from the app brick can be modified directly. When you make changes to the brick it must be bundled into the cli with the following command (run from the cli root dir): 
```sh
BRICK=bloc rn run bundle
```
Note the environment variable BRICK must be the name of the brick you edited.

### Vscode extension
   This guide from microsoft gives a good outline on how to get started with developing the vscode extension: https://code.visualstudio.com/api/get-started/your-first-extension