import BtnAdd from "components/common/Button/btnAdd";
import BtnMore from "components/common/Button/btnMore";
import handlePrice from "helpers/formatPrice";
import parseImages from "helpers/parseImages";
import PropTypes from "prop-types";
import React from "react";
import "./_topProduct.scss";

function TopProduct(props) {
  const { product } = props;
  let productData = {
    id: product.productID,
    name: product.productName,
    price: product.productPrice,
  };
  const images = parseImages(product.images);
  return (
    <div className="d-flex justify-content-center top-product">
      <div className="product-info">
        <img src={images[0]} alt={product.productName} />
        <div className="button">
          <BtnMore />
          <BtnAdd product={productData} />
        </div>
      </div>
      <div className="mt-2 product-name">
        <div className="name">{product.productName}</div>
        <div className="price">
          {handlePrice(product.productPrice)} <u>đ</u>
        </div>
      </div>
    </div>
  );
}

TopProduct.propTypes = {
  product: PropTypes.object.isRequired,
};

export default TopProduct;
