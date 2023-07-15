/**
 * create action & reducer for product list
 * thunk for async function
 */
/**
 * TAM THOI CHUA DUNG DEN
 */
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import ProductApi from "api/productApi";

// 'product/getListProduct' is prefix
export const getListProductByCategory = createAsyncThunk(
  "product/getListProductByCategory",
  async (params, thunkAPI) => {
    const listProduct = await ProductApi.getProductsByCategory(params);
    return listProduct;
  }
);

export const getAllProducts = createAsyncThunk(
  "product/getAllProducts",
  async (params, thunkAPI) => {
    const listProduct = await ProductApi.getAllProducts(params);
    console.log("listProduct", listProduct);
    return listProduct;
  }
);

const product = createSlice({
  name: "product",
  initialState: {
    data: [],
  },
  reducers: {},
  extraReducers: {
    [getListProductByCategory.pending]: (state) => {
      //console.log('pending fetching list')
    },
    [getListProductByCategory.fulfilled]: (state, action) => {
      //console.log('fetching successfully')
      state.data = action.payload;
    },
    [getListProductByCategory.rejected]: (state) => {
      //console.log('false fetching list')
    },
    [getAllProducts.pending]: (state) => {
      //console.log('pending fetching list')
    },
    [getAllProducts.fulfilled]: (state, action) => {
      //console.log('fetching successfully')
      state.data = action.payload;
    },
    [getAllProducts.rejected]: (state) => {
      //console.log('false fetching list')
    },
  },
});
//export const { getProducts } = product.actions;
export default product.reducer;
