import React from "react";
import PropTypes from "prop-types";

function FilterTopProduct(props) {
  const { changeTypeTopProduct } = props;
  return (
    <div>
      <button
        type="button"
        className="btn btn-outline-secondary active"
        name="10"
        onClick={changeTypeTopProduct}
      >
        Smart Phone
      </button>
      <button
        type="button"
        className="btn btn-outline-secondary"
        name="9"
        onClick={changeTypeTopProduct}
      >
        Keyboard
      </button>
      <button
        type="button"
        className="btn btn-outline-secondary"
        name="5"
        onClick={changeTypeTopProduct}
      >
        Mouse
      </button>
      <button
        type="button"
        className="btn btn-outline-secondary"
        name="8"
        onClick={changeTypeTopProduct}
      >
        Monitor
      </button>
    </div>
  );
}

FilterTopProduct.propTypes = {
  changeTypeTopProduct: PropTypes.func,
};

export default FilterTopProduct;
