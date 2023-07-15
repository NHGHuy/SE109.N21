import React, { useState } from "react";
import "./_btn.scss";
import { useDispatch } from "react-redux";
import { addToCart } from "utilities/slices/cartSlice";

function BtnAdd(props) {
  const { product } = props;
  
  const dispatch = useDispatch();
  const [content, setContent] = useState("Add to cart");
  const [loading, setLoading] = useState(false);

  let timer = null;

  const alert = () => {
    window.clearTimeout(timer);
    setContent("Added");
    setLoading(true);
    timer = window.setTimeout(function () {
      setContent("Add to cart");
      setLoading(false);
    }, 300);
  };
  const handleAddToCart = (product) => {
    dispatch(
      addToCart({
        id: product.id,
        quantity: 1,
        name: product.name,
        price: product.price,
      })
    );
    alert();
  };
  return (
    <button
      disabled={loading}
      className="btn-main btn-tranform btn-add"
      onClick={() => {
        handleAddToCart(product);
      }}
    >
      <span className="name">{content}</span>
      {/* <span className="icon">
        <i className="fa fa-shopping-cart"></i>
      </span> */}
    </button>
  );
}

export default BtnAdd;
