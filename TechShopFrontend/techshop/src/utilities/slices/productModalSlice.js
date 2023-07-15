import { createSlice } from "@reduxjs/toolkit";

const productModal = createSlice({
    name: 'productModal',
    initialState: {
        data: {}
    },
    reducers: {
        getProductModal: (state,action) => {
            state.data = action.payload
        }
    }
})
export const {getProductModal} = productModal.actions
export default productModal.reducer