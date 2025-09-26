import { NextFunction, Request, Response } from "express";
import { HttpException } from "../exceptions/root";

export const errorMiddleware = (
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (error instanceof HttpException) {
    return res.status(error.statusCode ?? 500).json({
      message: error.message,
      errors: error.errors ?? [],
    });
  }

  return res.status(500).json({ message: error.message });
};
