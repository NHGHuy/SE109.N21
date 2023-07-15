import React, { useEffect } from "react";
import { useDispatch, useSelector } from "react-redux";
import {
  addNewBreadcrumb,
  removeLastBreadcrumb,
} from "utilities/slices/breadcrumbSlice";
import EmptyItem from "components/ShoppingItemsComponents/EmptyItem/emptyItem";
import WishItem from "./wishItem";

function WishList(props) {
  const productsInWishList = useSelector((state) => state.wishList);
  const dispatch = useDispatch();
  useEffect(() => {
    dispatch(
      addNewBreadcrumb({
        name: "Wish List",
        slug: "/wish-list",
      })
    );

    return () => {
      dispatch(removeLastBreadcrumb());
    };
  }, [dispatch]);

  const renderWishList = (list) => {
    return list.products.length !== 0 ? (
      <table>
        <thead>
          <tr>
            <th className="">Product</th>
            <th className="">Price</th>
            <th className="">Stock Status</th>
            <th className="">Add To Cart</th>
            <th className="">Remove</th>
          </tr>
        </thead>
        <tbody>
          {list.products.map((product, index) => {
            return <WishItem key={index} productInWishList={product} />;
          })}
        </tbody>
      </table>
    ) : (
      <EmptyItem title="wish list" />
    );
  };

  return (
    <div className="table-wrapper">
      <div className="table-content">{renderWishList(productsInWishList)}</div>
    </div>
  );
}

export default WishList;
