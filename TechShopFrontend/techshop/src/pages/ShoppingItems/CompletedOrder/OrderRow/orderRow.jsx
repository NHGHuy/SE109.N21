import React from "react";
import PropTypes from "prop-types";
import "./_orderRow.scss";
import { NavLink } from "react-router-dom";
import handlePrice from "helpers/formatPrice";
function OrderRow(props) {
  const {invoice} = props
  return (
    <tr className="table-item order-row">
      <td className="order-ID">
        <NavLink to={`/completed-order/${invoice.invoiceID}`}>{invoice.invoiceID}</NavLink>
      </td>
      <td className="">{invoice.invoiceDate}</td>
      {/* <td>Apple watch series 5</td> */}
      <td className="">{handlePrice(invoice.totalCost)} <u>đ</u></td>
      <td className="">COMPLETED</td>
    </tr>
  );
}

OrderRow.propTypes = {
  invoice: PropTypes.object
};
OrderRow.default = {
  invoice: {}
};

export default OrderRow;
