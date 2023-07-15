import { cookiesService } from "helpers/cookiesService";
import * as UrlConstant from "utilities/UrlConstant";
import axiosClient from "./axiosClient";
import axiosClientAuthen from "./axiosClientAuthen";
/**
 *
 * TODO: modify url of GET_USER_SHIPPING_INFO: dont have to sent userID (/1)
 */
const UserApi = {
  login: async (params) => {
    let { email, pswd } = params;
    const url = `${UrlConstant.LOGIN}`;
    const data = JSON.stringify({ email, pswd });

    return axiosClient
      .post(url, data)

      .then((response) => {
        cookiesService.setCookies("user", JSON.stringify(response), 98);
        return response;
      })
      .catch((error) => {
        //console.log(error);
        return Promise.reject(error);
      });
  },
  getShippingInfo: async () => {
    const url = `${UrlConstant.GET_USER_SHIPPING_INFO}`;
    return axiosClientAuthen
      .get(url)
      .then((response) => {
        return response;
      })
      .catch((error) => {
        //console.log(error.response);
        return Promise.reject(error);
      });
  },
  
};
export default UserApi;
