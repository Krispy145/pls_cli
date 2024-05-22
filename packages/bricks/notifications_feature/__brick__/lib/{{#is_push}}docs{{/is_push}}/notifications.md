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

## 3. Xcode Push Notifications

Configure your Xcode project to receive push notifications:

- Set up your app delegate to handle push notifications.
- Implement the necessary methods to handle registration for remote notifications, receiving push notifications, and handling user interactions with notifications.

## 4. Register Apple Developer Account for APNS

You need to enroll in the Apple Developer Program to obtain the necessary certificates and permissions for sending push notifications:

- Visit the Apple Developer website and enroll in the Apple Developer Program if you haven't already done so.
- Generate the necessary APNs authentication key or certificates.

## 5. Add APNS Key in Developer Console

Add the APNs key to the Apple Developer Console:

- Go to the Apple Developer Portal.
- Navigate to **Certificates, Identifiers & Profiles** > **Keys**.
- Create a new key and provide a name.
- Download the key and upload it to Firebase as mentioned in step 2.
- Here is a good guide to generating and uploading your APNS Key:
- https://medium.com/@m1nori/ios-setup-of-push-notifications-flutter-firebase-775b0430140e

## 6. Add Firebase Functions to Project

- Run `firebase init functons` from the project root directory
  - If a Firebase project has been created already:
    - Select the correct
  - Else add a new Firebase project and name appropriately
- Select TypeScript as the desired language for the functions to be written in
- NB: Ensure you do ot overwrite the existing index.ts file, as this file already contains base function logic for use with the notifications

That's it! You've now completed setting up push notifications for your Firebase project. You can now send push notifications to your iOS app using Firebase Cloud Messaging.
