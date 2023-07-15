import { createSlice } from "@reduxjs/toolkit";
import { cookiesService } from "helpers/cookiesService";
import * as ExpireHours from "utilities/Constant";

/**
 * payload of ADD TO CART action is {
 * id: ID OF PRODUCT,
 * quantity: QUANTITY OF PRODUCT,
 * name: NAME OF PRODUCT
 * }
 *
 * payload of actions is {
 * id: ID OF PRODUCT,
 * quantity: QUANTITY OF PRODUCT
 * }
 */

export const initialStateCart = () => {
  let result = cookiesService.getCookies("cart");
  return result === undefined ? [] : result;
};

const cart = createSlice({
  name: "cart",
  initialState: {
    products: initialStateCart(),
  },
  reducers: {
    addToCart: (state, action) => {
      state.products =
        cookiesService.getCookies("cart") === undefined
          ? []
          : [...cookiesService.getCookies("cart")];

      let existedProduct = state.products.find(
        (product) => product.id === action.payload.id
      );
      if (existedProduct === undefined) {
        state.products.push(action.payload);
      } else {
        existedProduct.quantity += action.payload.quantity;
      }
      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    },
    removeFromCart: (state, action) => {
      if (
        JSON.stringify(cookiesService.getCookies("cart")) !==
        JSON.stringify(state.products)
      )
        state.products = [...cookiesService.getCookies("cart")];
      let existedProduct = state.products.filter(
        (product) => product.id !== action.payload.id
      );
      state.products = [...existedProduct];

      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    },
    updateQuantity: (state, action) => {
      state.products.find((product) => {
        if (product.id === action.payload.id)
          product.quantity = action.payload.quantity;
        return "";
      });
      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    },
    increaseQuantity: (state, action) => {
      if (
        JSON.stringify(cookiesService.getCookies("cart")) !==
        JSON.stringify(state.products)
      )
        state.products = [...cookiesService.getCookies("cart")];

      //console.log(state.products);
      state.products.find((product) => {
        if (product.id === action.payload.id) product.quantity++;
        return "";
      });

      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    },
    decreaseQuantity: (state, action) => {
      if (
        JSON.stringify(cookiesService.getCookies("cart")) !==
        JSON.stringify(state.products)
      )
        state.products = [...cookiesService.getCookies("cart")];
      state.products.find((product) => {
        if (product.id === action.payload.id) product.quantity--;
        return "";
      });
      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    },
    clearAll: (state, action) => {
      state.products.splice(0,state.products.length)
      cookiesService.setCookies(
        "cart",
        JSON.stringify(state.products),
        ExpireHours.CART_EXPIRE_HOURS
      );
    }
  },
});
export default cart.reducer;
export const {
  addToCart,
  removeFromCart,
  updateQuantity,
  increaseQuantity,
  decreaseQuantity,
  clearAll,
} = cart.actions;
