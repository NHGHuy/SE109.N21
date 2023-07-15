import handlePrice from "helpers/formatPrice";
import parseImages from "helpers/parseImages";
import PropTypes from "prop-types";
import React from "react";
import { Link } from "react-router-dom";
import "./_orderItem.scss";

function OrderItem(props) {
  const { getProductModalInfo, product } = props;
  const images = parseImages(product.images);
  return (
    <tr className="order-item">
      <td className="product-info">
        <div>
          <img src={images[0]} alt="" className="" />
        </div>
        <div className="short-info d-flex">
          <p className="product-name">{product.productName}</p>
          <p className="authen-tag">
            <span>Provided by</span> <i className="fas fa-check-circle"></i>
            TechShop
          </p>
          <div className="action">
            {product.isReviewed ? (
              <div className="reviewed-tag">Reviewed</div>
            ) : (
              <button
                data-toggle="modal"
                data-target="#reviewModal"
                onClick={() => {
                  getProductModalInfo({
                    productID: product.productID,
                    productName: product.productName,
                    productImage: images[0],
                  });
                }}
              >
                Write your review
              </button>
            )}
            <Link to={`/products/${product.categorySlug}/${product.productID}`}><button>Buy it again</button></Link>
          </div>
        </div>
      </td>
      <td>
        {handlePrice(product.productPrice)} <u>đ</u>
      </td>
      <td>{product.quantity}</td>
      <td>
        {handlePrice(product.totalPrice)} <u>đ</u>
      </td>
    </tr>
  );
}

OrderItem.propTypes = {
  product: PropTypes.object,
};
OrderItem.defaultProps = {
  product: {},
};

export default OrderItem;
