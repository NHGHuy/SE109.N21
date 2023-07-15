import React from "react";
import "assets/styles/_childBanner.scss";
import Breadcrumb from "components/common/Breadcrumb/breadcrumb";
import NavShopping from "components/ShoppingItemsComponents/NavShoppingItems/navShopping";
import "./_shoppingItems.scss";
import WishList from "./WishList/wishList";
import Cart from "./Cart/cart";
import { Route } from "react-router-dom";
import CheckOut from "./CheckOut/checkOut";
import CompletedOrder from './CompletedOrder/completedOrder';

function ShoppingItems(props) {
  //console.log("cart main");

  return (
    <div className="wrapper-dashboard shopping-cart-area">
      <div className="child-banner shopping-cart-banner">
        <div className="breadcrumb-nav container">
          <Breadcrumb />
        </div>
      </div>
      <div className="shopping-cart-view">
        <div className="container-fluid">
          <NavShopping />

          <div className="row">
            <Route path="/shopping-cart">
              <Cart />
            </Route>
            <Route path="/wish-list">
              <WishList />
            </Route>
            <Route path="/check-out">
              <CheckOut />
            </Route>
            <Route path="/completed-order">
              <CompletedOrder />
            </Route>

          </div>
        </div>
      </div>
    </div>
  );
}

ShoppingItems.propTypes = {};

export default React.memo(ShoppingItems);
