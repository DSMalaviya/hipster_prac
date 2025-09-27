import admin, { ServiceAccount } from "firebase-admin";
import serviceAccount from "../../keys/hipsterprac-5ede8-35478b91ce36.json";

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount as ServiceAccount),
});

export class FirebaseHelper {
  public sendNotification = async (
    token: string,
    data: any,
    title: string,
    body: string
  ) => {
    const message = {
      notification: {
        title,
        body,
      },
      data,
      token,
    };
    try {
      const response = await admin.messaging().send(message);
      console.log("Successfully sent message:", response);
    } catch (error) {
      console.log("Error sending message:", error);
    }
  };
}
