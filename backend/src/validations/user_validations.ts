import { z } from "zod";

export class UserValidations {
  public static readonly createUserValidationSchema = z.object({
    email: z.email(),
    name: z.string().min(3).max(50),
    password: z.string().min(6),
    profileImageUrl: z.string().optional(),
    fcmToken: z.string().optional(),
  });

  public static readonly loginUserValidationSchema = z.object({
    email: z.email(),
    password: z.string().min(6),
    fcmToken: z.string().optional(),
  });
}
