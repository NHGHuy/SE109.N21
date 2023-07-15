import { configureStore } from "@reduxjs/toolkit";
import reducerBreadcrumb from "utilities/slices/breadcrumbSlice";
import reducerCategory from "utilities/slices/categorySlice";
import reducerFilter from "utilities/slices/filterSlice";
import reducerProductModal from "utilities/slices/productModalSlice";
import reducerProduct from "utilities/slices/productSlice";
import reducerCart from "utilities/slices/cartSlice";
import reducerWishList from "utilities/slices/wishListSlice";
import reducerUser from "utilities/slices/userSlice";

const rootReducer = {
  productModal: reducerProductModal,
  category: reducerCategory,
  product: reducerProduct,
  filter: reducerFilter,
  breadcrumb: reducerBreadcrumb,
  cart: reducerCart,
  wishList: reducerWishList,
  user: reducerUser,
};
const store = configureStore({
  reducer: rootReducer,
});
export default store;
