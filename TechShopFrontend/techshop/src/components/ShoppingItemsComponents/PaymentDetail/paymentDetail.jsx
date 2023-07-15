import React from "react";
import { PropTypes } from "prop-types";
import handlePrice from "helpers/formatPrice";

function PaymentDetail(props) {
    const { product } = props;
    //console.log(product.id)
  return (
    <tr className="payment-detail">
      <td>{product.name}</td>
      <td className="price">{handlePrice(product.price * product.quantity)} <u>đ</u></td>
    </tr>
  );
}

PaymentDetail.propTypes = {
  product: PropTypes.object,
};

export default React.memo(PaymentDetail);
