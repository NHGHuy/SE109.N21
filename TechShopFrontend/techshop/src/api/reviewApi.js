import * as UrlConstant from "utilities/UrlConstant";
import axiosClientAuthen from "./axiosClientAuthen";
import axiosClient from "./axiosClient"
const ReviewApi = {
    
    getReviewsByProductIDByPagination: async (id, page, reviewsPerPage) => {
        const url = `${UrlConstant.GET_ALL_REVIEWS_BY_PRODUCTID}/${id}?limit=${reviewsPerPage}&page=${page}`;
        return axiosClient.get(url);
    },
    addReview: async (params) => {
        const url = `${UrlConstant.ADD_REVIEW}`;
        const body = JSON.stringify(params);
    
        return axiosClientAuthen
          .post(url, body)
    
          .then((response) => {
            return response;
          })
          .catch((error) => Promise.reject(error));
      },
}
export default ReviewApi;