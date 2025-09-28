# Setup Instructions

### Current configurations

- **Flutter version:** 3.35.4
- **Android Studio:** Android Studio Narwhal Feature Drop | 2025.1.
- **Xcode version:** 16.1
- **Video call SDK:** AWS Chime
- **CI/CD:** Github actions to build apk when code pushed on master branch.
  Used on the backend; not required for the Flutter app to run
- **Node.js version:** 22.20.0
- **Database:** MongoDB 8.2

### Android APK

- **Android APK link:** [Android apk](https://drive.google.com/file/d/1vSRiJBo_WjsXHTpbVTpByrnlGIzso7OV/view?usp=sharing)
- **Working demo recording:** [Screen recording](https://drive.google.com/file/d/1CGhSgga70qoPW8Qc-CSWISD5uLZZFoXk/view?usp=sharing)

### To run the project, follow the steps below:

1. Clone or download the repository, then run `flutter pub get`.
2. Run the app on an Android emulator or a physical Android device.
3. Create a new user account to test. Two Android devices (each logged in with a different account) are required to test the video call feature. Meetings are created by the backend Node.js server; the other user receives a push notification and can then join the meeting.
4. The Node.js backend is already deployed on AWS EC2, so no backend setup is required. When a meeting and attendee are created, they are returned in the response to the requesting user and a push notification is sent to the other user.
5. I currently don't have an Apple Developer account, so some functionality (for example, push notifications) will not work on iOS.
