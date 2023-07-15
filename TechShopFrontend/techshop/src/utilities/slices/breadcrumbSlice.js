import { createSlice } from "@reduxjs/toolkit";

const breadcrumb = createSlice({
  name: "breadcrumb",
  initialState: {
    breadcrumb: [{
        name: 'home',
        slug: '/home'
    }],
  },
  reducers: {
    addNewBreadcrumb: (state, action) => {
      state.breadcrumb.push(action.payload);
    },
    removeLastBreadcrumb: (state, action) => {
      state.breadcrumb.pop();
    },
  },
});
export const { addNewBreadcrumb, removeLastBreadcrumb } = breadcrumb.actions;
export default breadcrumb.reducer;
