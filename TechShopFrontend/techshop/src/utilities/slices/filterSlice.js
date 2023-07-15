import { createSlice } from "@reduxjs/toolkit";

const filter = createSlice({
  name: "filter",
  initialState: {
    filter: "asc",
  },
  reducers: {
    updateFilterType: (state, action) => {
      state.filter = action.payload;
    },
  },
});
export const { updateFilterType } = filter.actions;
export default filter.reducer;
