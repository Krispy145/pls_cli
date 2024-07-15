# Setting Up Push Notifications

Follow these steps to finish setting up push notifications for your Firebase project:

## 1. Xcode Background Mode

Ensure that the background modes capability is enabled for your iOS app in Xcode:

- Open your iOS project in Xcode.
- Go to the **Signing & Capabilities** tab.
- Add the **Background Modes** capability.
- Check the **Remote notifications** checkbox.

## 2. Add APNS Auth Key to Firebase Project

To enable push notifications with Firebase Cloud Messaging (FCM), you need to upload your APNs (Apple Push Notification service) authentication key to Firebase:

- Go to the Firebase Console and select your project.
- Navigate to **Project Settings** > **Cloud Messaging**.
- Under **iOS app configuration**, click on **Upload your APNs Auth Key**.
- Follow the instructions to generate and upload your APNs key.

## 3. Add APNS Key in Developer Console

Add the APNs key to the Apple Developer Console:

- Go to the Apple Developer Portal.
- Navigate to **Certificates, Identifiers & Profiles** > **Keys**.
- Create a new key and provide a name.
- Download the key and upload it to Firebase as mentioned in step 2.
- Here is a good guide to generating and uploading your APNS Key:
  - [APNS Setup](https://medium.com/@m1nori/ios-setup-of-push-notifications-flutter-firebase-775b0430140e)
- NOTE: if the bundle identifier is not configured with Push Notifiactions selected, this will need to be selected and saved
  - Use [This Link](https://developer.apple.com/account/resources/identifiers/list) to find the bundle id anc check the selected services for the app

That's it! You've now completed setting up push notifications for your Firebase project. You can now send push notifications to your iOS app using Firebase Cloud Messaging.

## 4. Add Firebase Functions to Project

- Run `firebase init functons` from the project root directory
  - If a Firebase project has been created already:
    - Select the correct
  - Else add a new Firebase project and name appropriately
- Overwrite the existing codebase if one already exists
- Select TypeScript as the desired language for the functions to be written in
- NB: Ensure you DO NOT overwrite the existing src/index.ts file, as this file already contains base function logic for use with the notifications

That's it! You've now completed setting up push notifications for your Firebase project. You can now send push notifications to your iOS app using Firebase Cloud Messaging.
