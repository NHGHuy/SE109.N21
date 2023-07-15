import BtnAdd from "components/common/Button/btnAdd";
import BtnMore from "components/common/Button/btnMore";
import Timer from "components/HomeComponents/Timer/timer";
import parseImages from 'helpers/parseImages';
import { PropTypes } from "prop-types";
import React from "react";
import "./_proposedProduct.scss";
ProposedProduct.propTypes = {
  product: PropTypes.object,
};
ProposedProduct.defaultProps = {
  products: {},
};

function ProposedProduct(props) {
  const { product } = props;
  let productData = {
    id: product.id,
    name: product.name,
    price: product.price,
  };
  const images = parseImages(product.images)
  return (
    <div className="proposed-product row">
      <div className="col-xs-12 col-sm-12 col-md-12 col-lg-8">
        <img src={images[0]} alt="Apple Watch" />
      </div>
      <div className="col-sm-12 proposed-product-content col-xs-12 col-md-12 col-lg-4">
        <h2>{product.name}</h2>
        <p className="price">
          Best price: <span>{product.price}</span>
        </p>
        <div className="count-down">
          <Timer EXP={product.EXP} />
        </div>
        <p className="description">{product.description}</p>
        <div className="d-flex">
          <BtnAdd product={productData} />

          <BtnMore />
        </div>
      </div>
    </div>
  );
}

export default ProposedProduct;
