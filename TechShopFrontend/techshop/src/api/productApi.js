import * as UrlConstant from "utilities/UrlConstant";
import axiosClient from "./axiosClient";
const ProductApi = {
  getAllProducts: async (params) => {
    //let { order } = params;
    const url = `${UrlConstant.GET_ALL_PRODUCTS}`;
    return axiosClient.get(url);
  },
  getProductsByCategory: async (params) => {
    let { category } = params;
    const url = `${UrlConstant.GET_PRODUCTS_BY_CATEGORY}/category/${category}`;
    return axiosClient.get(url);
  },
  getTrendingProducts: async () => {
    const url = `${UrlConstant.GET_TRENDING_PRODUCTS}`;
    //console.log("call api get trending product");
    return axiosClient.get(url);
  },
  getTopPurchasedProducts: async (filterTopProduct) => {
    const url = `${UrlConstant.GET_TOP_PURCHASED_PRODUCTS}/${filterTopProduct}`;
    //console.log("call api get top purchased product");
    return axiosClient.get(url);
  },

  getDetailedProduct: async (id) => {
    const url = `${UrlConstant.GET_DETAILED_PRODUCT}/${id}`;
    return axiosClient.get(url);
  },
  getRelatedCategoryPro: async (id) => {
    const url = `${UrlConstant.GET_RELATED_CATEGORY_PRODUCT}/${id}`;
    return axiosClient.get(url);
  },
  getRelatedBrandPro: async (id) => {
    const url = `${UrlConstant.GET_RELATED_BRAND_PRODUCT}/${id}`;
    return axiosClient.get(url);
  },
  


  getSpecsPro: async (id) => {
    const url = `${UrlConstant.GET_SPECS_PRODUCT}/${id}`;
    return axiosClient.get(url);
  },
  getFullDescriptionPro: async (id) => {
    const url = `${UrlConstant.GET_FULL_DESCRIP_PRODUCT}/${id}`;
    return axiosClient.get(url);
  },
  searchProducts: async (info) => {
    const url = `${UrlConstant.SEARCH_PRODUCTS}?q=${info}`;
    return axiosClient.get(url);
  },
  searchProductsIncludeFilter: async (params) => {
    let { keyword, order } = params;
    const url = `${UrlConstant.SEARCH_PRODUCTS}?q=${keyword}&sortOrder=${order}`;
    return axiosClient.get(url);
  },
  getProposedProducts: async () => {
    const url = `${UrlConstant.GET_PROPOSED_PRODUCTS}`;
    return axiosClient.get(url);
  },
};
export default ProductApi;
