import { HttpException } from "./root";

export class InternalException extends HttpException {
  constructor(message: string, errors: any[] | undefined) {
    super(message, 500, errors ?? []);
  }
}
