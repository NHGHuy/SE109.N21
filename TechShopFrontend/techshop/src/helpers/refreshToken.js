import axiosClient from "api/axiosClient";
import { cookiesService } from "helpers/cookiesService";
import * as UrlConstant from "utilities/UrlConstant";

export async function refreshToken(refreshTokenRequest) {
  const url = `${UrlConstant.REFRESH_TOKEN}`;
  const refresh_token = cookiesService.getRefreshToken();
  const data = JSON.stringify({ refresh_token });
  console.log("refresh");
  return axiosClient
    .post(url, data)
    .then((response) => {
      //console.log("res", response);
      cookiesService.updateAccessToken(response);
    })
    .catch((error) => {
      console.log("error", error.response.data.message);
      cookiesService.removeCookies("user");
      window.location.href = "/login";
      return  Promise.reject(error);
    });
}
