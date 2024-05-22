import * as functions from "firebase-functions";

import * as admin from "firebase-admin";

admin.initializeApp();

export const sendToTopic = functions.https.onCall((data) => {
  const title = data.title;
  const body = data.body;
  const imageUrl = data.imageUrl;
  const topic = data.topic;

  const message: admin.messaging.Message = {
    notification: {
      title: title,
      body: body,
      imageUrl: imageUrl,
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
