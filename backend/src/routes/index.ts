import { Router } from "express";
import userRouter from "./user_routes";

const rootRouter: Router = Router();

rootRouter.use("/user", userRouter);

export default rootRouter;
