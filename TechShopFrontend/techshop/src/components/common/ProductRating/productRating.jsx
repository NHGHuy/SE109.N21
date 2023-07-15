import React from "react";
import PropTypes from "prop-types";
import "./_productRating.scss";

ProductRating.propTypes = {
  rate: PropTypes.number,
};
ProductRating.defaultProps = {
  rate: 0,
};

function ProductRating(props) {
  const {rate} = props;
  const renderRateProduct = (rate) => {
    let result = [];

    let fullStar = Math.floor(rate);
    let restStar = (rate * 10) % 10;

    let total = 0;

    for (let i = 0; i < fullStar; i++) {
      result.push(<i key={total} className="fas fa-star"></i>);
      total++;
    }

    if (3 < restStar && restStar <= 7) {
      result.push(<i key={total} className="fas fa-star-half-alt"></i>);
      total++;
    } else if (restStar > 7) {
      result.push(<i key={total} className="fas fa-star"></i>);
      total++;
    }
    if (total < 5) {
      for (let i = 0; i < 5 - total; i++) {
        result.push(<i key={total + i} className="far fa-star"></i>);
      }
    }
    return result;
  };
  return <div className="product-rate">{renderRateProduct(rate)}</div>;
}



export default ProductRating;
