/**
 * create action & reducer for category list
 * thunk for async function
 */

import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import CategoryApi from "api/categoryApi";

// thunk action to get list category
export const getCategories = createAsyncThunk(
  "category/getCategories",
  async () => {
    const listCategory = await CategoryApi.getAll();
    return listCategory;
  }
);

const category = createSlice({
  name: "category",
  initialState: {
    data: [],
  },
  reducers: {},
  extraReducers: {
    [getCategories.pending]: (state) => {
      //console.log('pending fetching list')
    },
    [getCategories.fulfilled]: (state, action) => {
      
      state.data = action.payload;
    },
    [getCategories.rejected]: (state) => {
      //console.log('false fetching list')
    },
  },
});
export default category.reducer;
