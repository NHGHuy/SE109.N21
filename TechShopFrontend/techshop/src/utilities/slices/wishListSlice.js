import { createSlice } from "@reduxjs/toolkit";
import { cookiesService } from "helpers/cookiesService";
/**
 * payload of actions is ID OF PRODUCTS
 */

export const initialStateWishList = () => {
  let result = cookiesService.getCookies("wishList");
  return result === undefined ? [] : result;
};

const wishList = createSlice({
  name: "wishList",
  initialState: {
    products: initialStateWishList(),
  },
  reducers: {
    editWishList: (state, action) => {
      state.products =
        cookiesService.getCookies("wishList") === undefined
          ? []
          : [...cookiesService.getCookies("wishList")];
      let isExisted = false;
      let newProdutcs = state.products.filter((product) => {
        if (product !== action.payload) {
          return product;
        } else {
          isExisted = true;
          return null;
        }
      });
      if (!isExisted) state.products.push(action.payload);
      else state.products = [...newProdutcs];

      cookiesService.setCookies("wishList", JSON.stringify(state.products), {
        path: "/",
      });
    },
  },
});
export default wishList.reducer;
export const { editWishList } = wishList.actions;
