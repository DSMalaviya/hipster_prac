import dotenv from "dotenv";

dotenv.config({ path: "./.env" });

export class Configs {
  public static readonly PORT = process.env.PORT || 3000;
  public static readonly JWT_SECRET = process.env.JWT_SECRET || "";
  public static readonly MONGO_DB_URL = process.env.MONGO_DB_URL || "";
}
