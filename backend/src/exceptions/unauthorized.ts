import { HttpException } from "./root";

export class UnAuthorizedException extends HttpException {
  constructor(message: string, errors: any[] | undefined) {
    super(message, 401, errors ?? []);
  }
}
