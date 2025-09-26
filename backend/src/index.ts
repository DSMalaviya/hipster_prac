import express, { Express } from "express";
import mongoose from "mongoose";
import { Configs } from "./secrets";
import rootRouter from "./routes";
import { errorMiddleware } from "./middlewares/error_middleware";

const app: Express = express();

mongoose
  .connect(Configs.MONGO_DB_URL)
  .then(() => {
    console.log("Database connected!");
  })
  .catch((err) => {
    console.log(err);
  });

app.use(express.json());

app.use("/api", rootRouter);

app.use(errorMiddleware);

app.listen(Configs.PORT, () => {
  console.log(`Server is running on port ${Configs.PORT}`);
});
