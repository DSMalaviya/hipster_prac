// To parse this JSON data, do
//
//     final meetingCreationModel = meetingCreationModelFromJson(jsonString);

import 'dart:convert';

MeetingCreationModel meetingCreationModelFromJson(String str) =>
    MeetingCreationModel.fromJson(json.decode(str));

String meetingCreationModelToJson(MeetingCreationModel data) =>
    json.encode(data.toJson());

class MeetingCreationModel {
  String? message;
  MeetingDetails? meetingDetails;

  MeetingCreationModel({this.message, this.meetingDetails});

  factory MeetingCreationModel.fromJson(Map<String, dynamic> json) =>
      MeetingCreationModel(
        message: json["message"],
        meetingDetails: json["meetingDetails"] == null
            ? null
            : MeetingDetails.fromJson(json["meetingDetails"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "meetingDetails": meetingDetails?.toJson(),
  };
}

class MeetingDetails {
  String? externalMeetingId;
  String? meetingId;
  String? attendee1;
  String? attendee1JoinToken;
  String? attendee1ExternalUserId;
  String? attendee1Name;
  String? attendee2Name;
  String? attendee2;
  String? attendee2JoinToken;
  String? attendee2ExternalUserId;
  MediaPlacementInfo? mediaPlacementInfo;

  MeetingDetails({
    this.externalMeetingId,
    this.meetingId,
    this.attendee1,
    this.attendee1JoinToken,
    this.attendee1ExternalUserId,
    this.attendee1Name,
    this.attendee2Name,
    this.attendee2,
    this.attendee2JoinToken,
    this.attendee2ExternalUserId,
    this.mediaPlacementInfo,
  });

  factory MeetingDetails.fromJson(Map<String, dynamic> json) => MeetingDetails(
    externalMeetingId: json["externalMeetingId"],
    meetingId: json["meetingId"],
    attendee1: json["attendee1"],
    attendee1JoinToken: json["attendee1JoinToken"],
    attendee1ExternalUserId: json["attendee1ExternalUserId"],
    attendee1Name: json["attendee1Name"],
    attendee2Name: json["attendee2Name"],
    attendee2: json["attendee2"],
    attendee2JoinToken: json["attendee2JoinToken"],
    attendee2ExternalUserId: json["attendee2ExternalUserId"],
    mediaPlacementInfo: json["mediaPlacementInfo"] == null
        ? null
        : MediaPlacementInfo.fromJson(json["mediaPlacementInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "externalMeetingId": externalMeetingId,
    "meetingId": meetingId,
    "attendee1": attendee1,
    "attendee1JoinToken": attendee1JoinToken,
    "attendee1ExternalUserId": attendee1ExternalUserId,
    "attendee1Name": attendee1Name,
    "attendee2Name": attendee2Name,
    "attendee2": attendee2,
    "attendee2JoinToken": attendee2JoinToken,
    "attendee2ExternalUserId": attendee2ExternalUserId,
    "mediaPlacementInfo": mediaPlacementInfo?.toJson(),
  };
}

class MediaPlacementInfo {
  String? audioHostUrl;
  String? audioFallbackUrl;
  String? screenDataUrl;
  String? screenSharingUrl;
  String? screenViewingUrl;
  String? eventIngestionUrl;
  String? signalingUrl;
  String? turnControlUrl;

  MediaPlacementInfo({
    this.audioHostUrl,
    this.audioFallbackUrl,
    this.screenDataUrl,
    this.screenSharingUrl,
    this.screenViewingUrl,
    this.eventIngestionUrl,
    this.signalingUrl,
    this.turnControlUrl,
  });

  factory MediaPlacementInfo.fromJson(Map<String, dynamic> json) =>
      MediaPlacementInfo(
        audioHostUrl: json["audioHostUrl"],
        audioFallbackUrl: json["audioFallbackUrl"],
        screenDataUrl: json["screenDataUrl"],
        screenSharingUrl: json["screenSharingUrl"],
        screenViewingUrl: json["screenViewingUrl"],
        eventIngestionUrl: json["eventIngestionUrl"],
        signalingUrl: json["signalingUrl"],
        turnControlUrl: json["turnControlUrl"],
      );

  Map<String, dynamic> toJson() => {
    "audioHostUrl": audioHostUrl,
    "audioFallbackUrl": audioFallbackUrl,
    "screenDataUrl": screenDataUrl,
    "screenSharingUrl": screenSharingUrl,
    "screenViewingUrl": screenViewingUrl,
    "eventIngestionUrl": eventIngestionUrl,
    "signalingUrl": signalingUrl,
    "turnControlUrl": turnControlUrl,
  };
}
