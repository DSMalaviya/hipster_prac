import {
  ChimeSDKMeetingsClient,
  CreateMeetingCommand,
  CreateAttendeeCommand,
  DeleteMeetingCommand,
  MediaCapabilities,
} from "@aws-sdk/client-chime-sdk-meetings";
import { Request, Response } from "express";
import { Configs } from "../secrets";
//to generate unique meeting id
import { v4 as uuidv4 } from "uuid";
import { ConstMessages } from "../utils/const_messages";
import { FirebaseHelper } from "../utils/firebase_helper";
import { UserModel } from "../models/user_model";

const client = new ChimeSDKMeetingsClient({
  region: "us-east-1",
  credentials: {
    accessKeyId: Configs.AWS_ACCESS_KEY_ID,
    secretAccessKey: Configs.AWS_SECRET_ACCESS_KEY,
  },
});

export class MettingController {
  firebaseHelper = new FirebaseHelper();

  public createMeeting = async (req: Request, res: Response) => {
    //fetch the recipient user info
    const recipient = await UserModel.findById(req.body.userId);
    const participant = await UserModel.findById(req.user._id);

    // Step 1: Create a meeting
    const meetingResponse = await client.send(
      new CreateMeetingCommand({
        ExternalMeetingId: uuidv4(),
        MediaRegion: "us-east-1",
      })
    );

    // Step 2: Create at first attendee (usually you’ll create per user)
    const attendee1 = await client.send(
      new CreateAttendeeCommand({
        MeetingId: meetingResponse.Meeting?.MeetingId,
        ExternalUserId: participant?._id,
        Capabilities: {
          Video: MediaCapabilities.SEND_RECEIVE,
          Audio: MediaCapabilities.SEND_RECEIVE,
          Content: MediaCapabilities.RECEIVE,
        }, // must be unique per user
      })
    );

    //step 3: create second attendee
    const attendee2 = await client.send(
      new CreateAttendeeCommand({
        MeetingId: meetingResponse.Meeting?.MeetingId,
        ExternalUserId: recipient?._id,
        Capabilities: {
          Video: MediaCapabilities.SEND_RECEIVE,
          Audio: MediaCapabilities.SEND_RECEIVE,
          Content: MediaCapabilities.RECEIVE,
        }, // must be unique per user
      })
    );

    //Todo: send message to other user via firebase
    await this.firebaseHelper.sendNotification(
      recipient?.fcmToken || "",
      {
        meetingId: meetingResponse.Meeting?.MeetingId,
        attendee: attendee2.Attendee?.AttendeeId,
        attendeeJoinToken: attendee2.Attendee?.JoinToken,
      },
      "New Meeting",
      "You have a new meeting"
    );

    //step 4: send response
    return res.status(200).json({
      message: ConstMessages.success,
      meetingInfo: {
        meetingId: meetingResponse.Meeting?.MeetingId,
        attendee1: attendee1.Attendee?.AttendeeId,
        attendee1JoinToken: attendee1.Attendee?.JoinToken,
        attendee2: attendee2.Attendee?.AttendeeId,
        attendee2JoinToken: attendee2.Attendee?.JoinToken,
      },
    });
  };

  //end meeting
  public endMeeting = async (req: Request, res: Response) => {
    await client.send(
      new DeleteMeetingCommand({ MeetingId: req.body.meetingId })
    );

    return res.status(200).json({ message: ConstMessages.success });
  };
}
