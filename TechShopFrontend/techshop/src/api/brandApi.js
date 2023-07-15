import * as UrlConstant from "utilities/UrlConstant";
import axiosClient from "./axiosClient";
const BrandApi = {
  getBrands: async () => {
    const url = `${UrlConstant.GET_ALL_BRANDS}`;
    //console.log('call api get all brands')
    return axiosClient.get(url)
  }
};
export default BrandApi;
