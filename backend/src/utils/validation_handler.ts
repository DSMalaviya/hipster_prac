import { NextFunction, Request, Response } from "express";
import { z } from "zod";
import { BadRequestException } from "../exceptions/bad_request";
import { InternalException } from "../exceptions/internal_exception";
import { ConstMessages } from "./const_messages";

export const validateData = (
  schema: z.ZodObject<any, any> | z.ZodArray<any>
) => {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      schema.parse(req.body);
      next();
    } catch (error) {
      if (error instanceof z.ZodError) {
        const errorMessages = error.issues.map(
          (issue) => `${issue.path.join(".")} is ${issue.message}`
        );
        next(
          new BadRequestException(
            ConstMessages.unprocessableEntrity,
            errorMessages
          )
        );
      } else {
        next(new InternalException(ConstMessages.internalServerError, []));
      }
    }
  };
};
