import { HttpException } from "./root";

export class BadRequestException extends HttpException {
  constructor(message: string, errors: any[] | undefined) {
    super(message, 400, errors ?? []);
  }
}
