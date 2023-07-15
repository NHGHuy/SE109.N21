import * as UrlConstant from "utilities/UrlConstant";
import axiosClient from "./axiosClient";
const CategoryApi = {
  getAll: async () => {
    const url = `${UrlConstant.GET_ALL_CATEGORIES}`;
    //console.log('call api get category')
    return axiosClient.get(url)
  },
};
export default CategoryApi;
