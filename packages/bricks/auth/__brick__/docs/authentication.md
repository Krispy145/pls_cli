# Setting Up Authentication

Follow these steps to finish setting up authentication for your Firebase project:

## 1. Enable Login Methods on Firebase Dashboard

Navigate to the Firebase Console and select your project. Then go to **Authentication** > **Sign-in method**. Enable the login methods you want to use, such as email/password, Google, Facebook, etc. Follow the instructions provided to configure each login method.

## 2. Add Meta Tags for Web and Google Sign-In

If you're using Firebase Authentication and Google Sign-In for web applications, add the following meta tags to the `<head>` section of your HTML files:

```html
<meta
  name="google-signin-client_id"
  content="YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com"
/>
```

Replace `YOUR_GOOGLE_CLIENT_ID` with your actual Google client ID obtained from the Google Cloud Console.

## 3. Setup Firestore Database

To set up the Firestore Database:

- Go to the Firebase Console and select your project.
- Navigate to **Firestore Database** and click on **Create Database**.
- Choose your preferred location (defaults to Europe) and set up your database.

## 4. Enable People API on Google Cloud

To enable the People API on Google Cloud:

- Go to the Google Cloud Console using the following link: [Google Cloud Console](https://console.cloud.google.com/apis/api/people.googleapis.com/metrics?project=YOUR_FIREBASE_PROJECT_ID&authuser=1)
- Replace `YOUR_FIREBASE_PROJECT_ID` with your actual Firebase project ID.
- Enable the People API if it's not already enabled.

That's it! You've now completed setting up authentication for your Firebase project.
