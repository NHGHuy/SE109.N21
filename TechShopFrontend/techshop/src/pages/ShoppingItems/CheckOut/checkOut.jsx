import OrderApi from 'api/orderApi';
import EmptyItem from "components/ShoppingItemsComponents/EmptyItem/emptyItem";
import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useHistory } from "react-router-dom";
import { Spinner } from 'reactstrap';
import {
  addNewBreadcrumb,
  removeLastBreadcrumb
} from "utilities/slices/breadcrumbSlice";
import { clearAll } from "utilities/slices/cartSlice";
import BillingDetails from "./BillingDetails/billingDetails";
import Order from "./Order/order";
import "./_checkOut.scss";

function CheckOut(props) {
  const productsInCart = useSelector((state) => state.cart.products);
  const history = useHistory();
  const [loading, setLoading] = useState(false);
  const dispatch = useDispatch();
  useEffect(() => {
    dispatch(
      addNewBreadcrumb({
        name: "Check Out",
        slug: "/check-out",
      })
    );

    return () => {
      dispatch(removeLastBreadcrumb());
    };
  }, [dispatch]);

  const [shippingInfo, setShippingInfo] = useState(null);

  const updateShippingInfo = (info) => {
    setShippingInfo(info);
  };

  const placeOrder = (shippingInfo) => {
    let orderInfo = [];
    for (let product of productsInCart) {
      let tempProduct = {
        productID: product.id,
        quantity: product.quantity,
      };
      orderInfo.push(tempProduct);
    }
    let data = {
      detailedInvoices: orderInfo,
      shippingInfo: shippingInfo,
    };

    const placeOrder = async (data) => {
      setLoading(true);
      return OrderApi.placeOrder(data)
        .then((res) => {
          //console.log(res);
          setLoading(false)
          history.push("/completed-order");
          // clear all data in check out and cart
          dispatch(clearAll());
        })
        .catch((err) => {
          console.log(err);
        });
    };
    placeOrder(data);
  };

  const renderPayBtn = (loading) => {
    if (loading) {
      return (
        <div className="text-center">
          <Spinner color="primary" />
        </div>
      );
    }
    return (
      <button
        onClick={() => {
          placeOrder(shippingInfo);
        }}
      >
        Pay
      </button>
    );
  };
  const renderCheckOut = (productsInCart) => {
    return productsInCart.length !== 0 ? (
      <div className="row">
        <div className="col-lg-6">
          <BillingDetails updateShippingInfo={updateShippingInfo} />
        </div>
        <div className="col-lg-6 order">
          <Order />
          <div className="btn-pay">
            {/* <button
              onClick={() => {
                placeOrder(shippingInfo);
              }}
            >
              Pay
            </button> */}
            {renderPayBtn(loading)}
          </div>
        </div>
      </div>
    ) : (
      <EmptyItem title="check-out" />
    );
  };
  return (
    <div className="table-wrapper check-out">
      {renderCheckOut(productsInCart)}
    </div>
  );
}

CheckOut.propTypes = {};

export default CheckOut;
