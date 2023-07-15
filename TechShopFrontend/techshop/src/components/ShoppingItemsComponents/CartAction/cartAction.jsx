import React from "react";
import { useDispatch } from "react-redux";
import "./_cartAction.scss";
import {
  updateQuantity,
  decreaseQuantity,
  increaseQuantity,
} from "utilities/slices/cartSlice";

function CartAction(props) {
  const { stockQuantity, productInCart } = props;

  const dispatch = useDispatch();

  const updateQuantityInStore = (quantity) => {
    dispatch(
      updateQuantity({
        id: productInCart.id,
        quantity: quantity
      })
    );
  };

  return (
    <div className="cart-action-wrapper">
      <div className="cart-action">
        <div
          className="quantity-btn flex"
          onClick={() => {
            if (productInCart.quantity > 1)
              dispatch(decreaseQuantity({ id: productInCart.id }));
          }}
        >
          <i className="fa fa-minus"></i>
        </div>
        <input
          type="number"
          className="flex"
          value={productInCart.quantity}
          onChange={(e) => {
            updateQuantityInStore(e.target.value);
          }}
          onBlur={(e) => {
            if (e.target.value > stockQuantity || e.target.value < 1)
              updateQuantityInStore(1);
          }}
        />
        <div
          className="quantity-btn flex"
          onClick={() => {
            if (productInCart.quantity < stockQuantity)
              dispatch(increaseQuantity({ id: productInCart.id }));
          }}
        >
          <i className="fa fa-plus"></i>
        </div>
      </div>
    </div>
  );
}

CartAction.propTypes = {};

export default CartAction;
