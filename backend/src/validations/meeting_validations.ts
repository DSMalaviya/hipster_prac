import { z } from "zod";

export class MeetingValidations {
  public static readonly createMeetingValidationSchema = z.object({
    userId: z.string(),
  });

  public static readonly endMeetingValidationSchema = z.object({
    meetingId: z.string(),
  });
}
