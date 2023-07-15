import React from "react";
import { NavLink } from "react-router-dom";
import "./_cartIcon.scss";
import { useSelector } from "react-redux";

function CartIcon() {
  const itemQuantity = useSelector((state) => state.cart.products.length);
  const renderCartQuantity = (quantity) => {
    return itemQuantity === 0 ? (
      ""
    ) : (
      <span className="cart-items-count">{itemQuantity}</span>
    );
  };
  return (
    <NavLink
      activeClassName="active"
      to="/shopping-cart"
      className="cart-items"
    >
      <i className="fas fa-shopping-cart">{renderCartQuantity(itemQuantity)}</i>
    </NavLink>
  );
}

export default CartIcon;
