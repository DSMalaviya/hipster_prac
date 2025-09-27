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
import { json } from "zod";

const client = new ChimeSDKMeetingsClient({
  region: Configs.AWS_REGION,
  credentials: {
    accessKeyId: Configs.AWS_ACCESS_KEY_ID,
    secretAccessKey: Configs.AWS_SECRET_ACCESS_KEY,
  },
});

export class MettingController {
  firebaseHelper = new FirebaseHelper();

  public createMeeting = async (req: Request, res: Response) => {
    //fetch the recipient user info
    const attendee1Info = await UserModel.findById(req.user._id);
    const attendee2Info = await UserModel.findById(req.body.userId);

    const externalMeetingId = uuidv4();

    // Step 1: Create a meeting
    const meetingResponse = await client.send(
      new CreateMeetingCommand({
        ExternalMeetingId: externalMeetingId,
        MediaRegion: Configs.AWS_REGION,
      })
    );

    let meeting = meetingResponse.Meeting;

    // Step 2: Create at first attendee (usually you’ll create per user)
    const attendee1 = await client.send(
      new CreateAttendeeCommand({
        MeetingId: meeting?.MeetingId,
        ExternalUserId: attendee1Info?._id,
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
        MeetingId: meeting?.MeetingId,
        ExternalUserId: attendee2Info?._id,
        Capabilities: {
          Video: MediaCapabilities.SEND_RECEIVE,
          Audio: MediaCapabilities.SEND_RECEIVE,
          Content: MediaCapabilities.RECEIVE,
        }, // must be unique per user
      })
    );

    let mediaPlacementInfo = {
      audioHostUrl: meeting?.MediaPlacement?.AudioHostUrl,
      audioFallbackUrl: meeting?.MediaPlacement?.AudioFallbackUrl,
      screenDataUrl: meeting?.MediaPlacement?.ScreenDataUrl,
      screenSharingUrl: meeting?.MediaPlacement?.ScreenSharingUrl,
      screenViewingUrl: meeting?.MediaPlacement?.ScreenViewingUrl,
      eventIngestionUrl: meeting?.MediaPlacement?.EventIngestionUrl,
      signalingUrl: meeting?.MediaPlacement?.SignalingUrl,
      turnControlUrl: meeting?.MediaPlacement?.TurnControlUrl,
    };

    let meetingDetails = {
      externalMeetingId,
      meetingId: meetingResponse.Meeting?.MeetingId,
      attendee1Name: attendee1Info?.name,
      attendee1: attendee1.Attendee?.AttendeeId,
      attendee1JoinToken: attendee1.Attendee?.JoinToken,
      attendee1ExternalUserId: attendee1.Attendee?.ExternalUserId,
      attendee2Name: attendee2Info?.name,
      attendee2: attendee2.Attendee?.AttendeeId,
      attendee2JoinToken: attendee2.Attendee?.JoinToken,
      attendee2ExternalUserId: attendee2.Attendee?.ExternalUserId,
      mediaPlacementInfo,
    };

    //Todo: send message to other user via firebase
    await this.firebaseHelper.sendNotification(
      attendee2Info?.fcmToken || "",
      { data: JSON.stringify(meetingDetails) },
      "New Meeting",
      "You have a new meeting"
    );

    //just for safty reason end meeting after 20 min of creation
    // setTimeout(async () => {
    //   try {
    //     await client.send(
    //       new DeleteMeetingCommand({
    //         MeetingId: meetingResponse.Meeting?.MeetingId,
    //       })
    //     );
    //   } catch (error) {
    //     console.log(error);
    //   }
    // }, 1200000);

    //step 4: send response
    return res.status(200).json({
      message: ConstMessages.success,
      meetingDetails,
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
