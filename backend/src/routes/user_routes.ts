import { Router } from "express";
import { validateData } from "../utils/validation_handler";
import { errorHandler } from "../utils/error_handler";
import { UserController } from "../controllers/user_controller";
import { authMiddleware } from "../middlewares/auth";
import { UserValidations } from "../validations/user_validations";

const userRouter = Router();
const userController = new UserController();

userRouter.post(
  "/signup",
  validateData(UserValidations.createUserValidationSchema),
  errorHandler(userController.createUser)
);

userRouter.post(
  "/login",
  validateData(UserValidations.loginUserValidationSchema),
  errorHandler(userController.loginUser)
);

userRouter.get("/me", authMiddleware, errorHandler(userController.getUser));

userRouter.get(
  "/all",
  authMiddleware,
  errorHandler(userController.listAllUsers)
);

export default userRouter;
