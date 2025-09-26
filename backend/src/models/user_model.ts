import mongoose, { Schema } from "mongoose";

export interface User extends mongoose.Document {
  name: string;
  email: string;
  password: string;
  fcmToken?: string;
  profileImageUrl?: string;
  _id: string;
}

const userSchema = new Schema<User>({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    index: true,
  },
  password: {
    type: String,
    required: true,
  },
  profileImageUrl: {
    type: String,
  },
  fcmToken: {
    type: String,
  },
});

export const UserModel = mongoose.model("User", userSchema);
