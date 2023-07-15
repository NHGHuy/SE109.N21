import PaymentDetail from "components/ShoppingItemsComponents/PaymentDetail/paymentDetail";
import React, { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import "./_generalOrder.scss";
import handlePrice from "helpers/formatPrice";

function GeneralOrder() {
  const productsInCart = useSelector((state) => state.cart.products);

  const [totalPrice, setTotalPrice] = useState(0);

  useEffect(() => {
    if (productsInCart.length !== 0) {
      let price = productsInCart.reduce(
        (accumulator, currentValue) =>
          accumulator + currentValue.price * currentValue.quantity,
        0
      );
      //console.log(price)
      setTotalPrice(price);
    }
  }, [productsInCart]);

  

  const renderPaymentDetails = (productsInCart) => {
    return productsInCart.map((product, index) => {
      return <PaymentDetail key={product.id} product={product} />;
    });
  };
  return (
    <table className="table-payment">
      <tbody>
        {renderPaymentDetails(productsInCart)}
        {/* <tr className="payment-detail">
          <td>Coupon Discount</td>
          <td className="discount">-500.000</td>
        </tr> */}
      </tbody>
      <tfoot>
        <tr className="payment-detail">
          <td>Order Total</td>
          <td className="price">{handlePrice(totalPrice)} <u>đ</u></td>
        </tr>
      </tfoot>
    </table>
  );
}

export default GeneralOrder;
