import { Router } from "express";
import { validateData } from "../utils/validation_handler";
import { errorHandler } from "../utils/error_handler";

import { authMiddleware } from "../middlewares/auth";
import { MettingController } from "../controllers/meeting_controller";
import { MeetingValidations } from "../validations/meeting_validations";

const meetingRouter = Router();
const meetingController = new MettingController();

meetingRouter.post(
  "/create",
  authMiddleware,
  validateData(MeetingValidations.createMeetingValidationSchema),
  errorHandler(meetingController.createMeeting)
);

meetingRouter.post(
  "/end",
  authMiddleware,
  validateData(MeetingValidations.endMeetingValidationSchema),
  errorHandler(meetingController.endMeeting)
);

export default meetingRouter;
