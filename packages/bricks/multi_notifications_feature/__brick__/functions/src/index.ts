import * as functions from "firebase-functions";

import * as admin from "firebase-admin";

admin.initializeApp();

// Send a message to a topic
export const sendToTopic = functions.https.onCall((data) => {
  const title = data.title;
  const body = data.body;
  const imageUrl = data.image_url;
  const topic = data.topic;

  // Notification details.
  const message: admin.messaging.Message = {
    notification: {
      title: title,
      body: body,
      imageUrl: imageUrl,
    },

    // Android specific fields
    android: {
      notification: {
        imageUrl: imageUrl,
      },
      priority: "high",
    },

    // iOS specific fields
    apns: {
      payload: {
        aps: {
          "mutable-content": 1,
        },
        headers: {
          "apns-priority": "5",
          "apns-push-type": "alert",
        },
      },
      fcmOptions: {
        imageUrl: imageUrl,
      },
    },

    // Webpush specific fields
    webpush: {
      headers: {
        image: imageUrl,
      },
    },
    data: data,
    topic: topic,
  };

  admin
    .messaging()
    .send(message)
    .then((response) => {
      console.log("Successfully sent message:", response);
    })
    .catch((error) => {
      console.error("Error sending message:", error);
    });
});
