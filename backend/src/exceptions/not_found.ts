import { HttpException } from "./root";

export class NotFoundException extends HttpException {
  constructor(message: string, errors: any[] | undefined) {
    super(message, 404, errors ?? []);
  }
}
