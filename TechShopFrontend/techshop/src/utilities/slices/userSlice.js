/**
 * create action & reducer for user
 * thunk for async function
 * data: {
 * isLoggedIn:false}
 */

import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import UserApi from "api/userApi";
import { cookiesService } from "helpers/cookiesService";

// thunk action to login and get token
export const login = createAsyncThunk("user/login", async (params) => {
  const token = await UserApi.login(params);
  return token;
});

export const register = createAsyncThunk("user/register", async (params) => {
  const token = await UserApi.register(params);
  return token;
});



export const initialStateUseLoggedIn = () => {
  let result = cookiesService.getCookies("user");
  return result === undefined || result === null ? false : true;
};

const user = createSlice({
  name: "user",
  initialState: {
    data: { isLoggedIn: initialStateUseLoggedIn(), error: "" },
  },
  reducers: {
    updateLoggedInStatus: (state, action) => {
      state.data.isLoggedIn = action.payload.isLoggedIn;

    },
  },
  extraReducers: {
    [login.pending]: (state) => {
      //console.log("pending get token");
    },
    [login.fulfilled]: (state, action) => {
      state.data.isLoggedIn = true;
      state.data.error = "";
    },
    [login.rejected]: (state) => {
      console.log("login failed");
      state.data.error = "Username or password is incorrect";
    },
  },
});
export default user.reducer;
export const { updateLoggedInStatus } = user.actions;
