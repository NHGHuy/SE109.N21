import { cookiesService } from "helpers/cookiesService";

export function authHeader() {
  let token = cookiesService.getCookies("user");

  if (token) {
    return `Bearer ${token}`;
  } else {
    return {};
  }
}