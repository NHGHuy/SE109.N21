import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import "./_productAction.scss";
import { useDispatch } from "react-redux";
import { addToCart } from "utilities/slices/cartSlice";

ProductAction.propTypes = {
  status: PropTypes.object,
};
ProductAction.defaultProps = {
  status: {},
};

function ProductAction(props) {
  const { stockStatus, stock, id, name, price } = props;
  const dispatch = useDispatch();

  const [quantity, setQuantity] = useState(1);

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

  const handleAddToCart = (id, name, loading, price) => {
    if (!loading) {
      dispatch(
        addToCart({
          id: id,
          quantity: quantity,
          name: name,
          price: price
        })
      );
      alert();
    }
  };
  useEffect(() => {
    setQuantity(1);
  }, [id]);
  return (
    <React.Fragment>
      <div className="stock-status">
        <p>
          Status:{" "}
          <span className={stockStatus}>
            {stockStatus === "in-stock" ? "In Stock" : "Out of Stock"}
          </span>
        </p>
        {stock > 0 ? (
          <p>
            Stock: <span>{stock}</span>
          </p>
        ) : (
          ""
        )}
      </div>
      <div className="product-quantity mt-4">
        <div
          className="quantity-btn flex"
          onClick={() => {
            if (quantity > 1) setQuantity(parseInt(quantity) - 1);
          }}
        >
          <i className="fa fa-minus"></i>
        </div>
        <input
          type="number"
          className="flex"
          value={quantity}
          onChange={(e) => {
            setQuantity(e.target.value);
          }}
          onBlur={(e) => {
            if (e.target.value > stock || e.target.value < 1) setQuantity(1);
          }}
        />
        <div
          className="quantity-btn flex"
          onClick={() => {
            if (quantity < stock) setQuantity(parseInt(quantity) + 1);
          }}
        >
          <i className="fa fa-plus"></i>
        </div>
      </div>

      <div
        className="product-actions mt-4"
        onClick={() => {
          handleAddToCart(id, name, loading, price);
        }}
      >
        {/* <i className="fas fa-cart-plus"></i> */}
        {content}
      </div>
    </React.Fragment>
  );
}

export default ProductAction;
