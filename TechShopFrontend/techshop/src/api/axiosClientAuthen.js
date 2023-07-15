/**
 * This instance is used to send axios request with access token in header
 */

import axios from "axios";
import { authHeader } from "helpers/authHeader";
import { refreshToken } from "helpers/refreshToken";
import queryString from "query-string";

const axiosClientAuthen = axios.create({
  baseURL: process.env.REACT_APP_API_URL,
  headers: {
    "content-type": "application/json",
  },
  paramsSerializer: (params) => queryString.stringify(params),
});

axiosClientAuthen.interceptors.request.use(async (config) => {
  // handle token
  //console.log("send request");
  config.headers.Authorization = authHeader();
  return config;
});

let refreshTokenRequest = null;
axiosClientAuthen.interceptors.response.use(
  (response) => {
    if (response && response.data) {
      return response.data;
    }
    return response;
  },
  (error) => {
    return new Promise(async (resolve, reject) => {
      if (error.response.data.message === "Token expired") {
        refreshTokenRequest = refreshTokenRequest
          ? refreshTokenRequest
          : refreshToken(refreshTokenRequest);
        await refreshTokenRequest;
        refreshTokenRequest = null;
        let res = await axiosClientAuthen(error.config);
        resolve(res);
      }
      return Promise.reject(error);
    });
  }
);

export default axiosClientAuthen;
