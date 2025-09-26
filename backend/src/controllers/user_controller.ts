import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { Configs } from "../secrets";
import { Request, Response } from "express";
import { z } from "zod";
import { UserValidations } from "../validations/user_validations";
import { UserModel } from "../models/user_model";
import { BadRequestException } from "../exceptions/bad_request";
import { ConstMessages } from "../utils/const_messages";

export class UserController {
  public createUser = async (req: Request, res: Response) => {
    const userReq = req.body as z.infer<
      typeof UserValidations.createUserValidationSchema
    >;

    const existingUser = await UserModel.findOne({ email: userReq.email });
    if (existingUser) {
      throw new BadRequestException(ConstMessages.userAlreadyExists, []);
    }

    userReq.password = await bcrypt.hash(userReq.password, 10);
    const user = await UserModel.create(userReq);
    const token = jwt.sign({ user_id: user._id }, Configs.JWT_SECRET, {
      expiresIn: "30d",
    });
    return res.status(201).json({
      message: ConstMessages.userCreated,
      data: user,
      token,
    });
  };

  public loginUser = async (req: Request, res: Response) => {
    const userReq = req.body as z.infer<
      typeof UserValidations.loginUserValidationSchema
    >;

    const user = await UserModel.findOne({ email: userReq.email });
    if (!user) {
      throw new BadRequestException(ConstMessages.wrongUsernameOrPassword, []);
    }

    const isPasswordValid = await bcrypt.compare(
      userReq.password,
      user.password
    );
    if (!isPasswordValid) {
      throw new BadRequestException(ConstMessages.wrongUsernameOrPassword, []);
    }

    if (userReq.fcmToken) {
      user.fcmToken = userReq.fcmToken;
      await user.save();
    }

    const token = jwt.sign({ user_id: user._id }, Configs.JWT_SECRET, {
      expiresIn: "30d",
    });
    return res.status(200).json({ message: ConstMessages.success, token });
  };

  public getUser = async (req: Request, res: Response) => {
    return res.status(200).json(req.user);
  };

  public listAllUsers = async (req: Request, res: Response) => {
    const users = await UserModel.find({}, { password: 0, fcmToken: 0 }).where({
      _id: { $ne: req.user._id },
    });
    return res.status(200).json({ message: ConstMessages.success, users });
  };
}
