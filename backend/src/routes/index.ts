import { Router } from "express";
import userRouter from "./user_routes";
import meetingRouter from "./meeting_routes";

const rootRouter: Router = Router();

rootRouter.use("/user", userRouter);
rootRouter.use("/meeting", meetingRouter);

export default rootRouter;
