import * as vscode from 'vscode';
import * as path from 'path';

export async function createApp() {
    const folderUri = await vscode.window.showOpenDialog({
        canSelectFiles: false,
        canSelectFolders: true,
        canSelectMany: false,
        openLabel: 'Select Directory',
    });

    if (!folderUri || folderUri.length === 0) {
        vscode.window.showErrorMessage('No directory selected.');
        return;
    }

    const appDirectory = folderUri[0].fsPath;

    const appName = await vscode.window.showInputBox({
        prompt: 'Enter the name for your new app',
        placeHolder: 'digital_oasis_app',
    });

    if (!appName) {
        vscode.window.showErrorMessage('App name not provided. Aborting.');
        return;
    }

    const terminal = vscode.window.createTerminal('Create New App');
    const cmd = `rn create app ${appName}`;

    // Change to the appDirectory and run the command
    terminal.sendText(`cd "${appDirectory}"`);
    terminal.sendText(cmd);
    terminal.show();    
}
