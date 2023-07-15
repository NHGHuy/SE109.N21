import * as UrlConstant from "utilities/UrlConstant";
import axiosClient from "./axiosClient";
const CouponApi = {
  getCouponById: async (id) => {
    const url = `${UrlConstant.GET_COUPON_BY_ID}/${id}`;
    //console.log('call api get category')
    return await axiosClient
      .get(url)
      .then((res) => res)
      .catch(err => {
        return null;
      });
  },
};
export default CouponApi;
