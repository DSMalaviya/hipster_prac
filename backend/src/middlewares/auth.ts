import { Request, Response, NextFunction } from "express";
import { UnAuthorizedException } from "../exceptions/unauthorized";
import jwt from "jsonwebtoken";
import { Configs } from "../secrets";
import { User, UserModel } from "../models/user_model";

declare global {
  namespace Express {
    interface Request {
      user: User;
    }
  }
}

export const authMiddleware = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = req.headers.authorization;
  if (!token) {
    next(new UnAuthorizedException("Please provide a token", []));
    return;
  }

  try {
    const payload = jwt.verify(token, Configs.JWT_SECRET) as any;
    const user = await UserModel.findById(payload.user_id, {
      password: 0,
    });

    if (!user) {
      next(new UnAuthorizedException("User not found", []));
      return;
    }
    req.user = user;
    next();
  } catch (error) {
    next(new UnAuthorizedException("Unauthorized", []));
  }
};
