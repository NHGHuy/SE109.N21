import OrderApi from "api/orderApi";
import OrderItem from "pages/ShoppingItems/CompletedOrder/DetailedOrder/OrderItem/orderItem";
import React, { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { useParams } from "react-router";
import {
  addNewBreadcrumb,
  removeLastBreadcrumb,
} from "utilities/slices/breadcrumbSlice";
import "./_detailedOrder.scss";
import { Spinner } from "reactstrap";
import handlePrice from "helpers/formatPrice";
import ReviewModal from "components/ShoppingItemsComponents/ReviewModal/reviewModal";

function DetailedOrder(props) {
  const dispatch = useDispatch();
  const [detailedInfo, setDetailedInfo] = useState({});
  const [loading, setLoading] = useState(true);
  const [productModalInfo, setProductModalInfo] = useState(null);
  const { orderID } = useParams();
  const updateReviewStatus = (id) => {
    let info = { ...detailedInfo };
    for (let invoice of info.detailedInvoices) {
      if (invoice.productID === parseInt(id)) {
        invoice.isReviewed = true;
        break;
      }
    }
    setDetailedInfo(info);
  };
  const getProductModalInfo = (info) => {
    setProductModalInfo({
      orderID,
      productID: info.productID,
      productName: info.productName,
      productImage: info.productImage
    });
  };

  useEffect(() => {
    dispatch(
      addNewBreadcrumb({
        name: orderID,
        slug: "",
      })
    );

    return () => {
      dispatch(removeLastBreadcrumb());
    };
  }, [dispatch, orderID]);

  useEffect(() => {
    const getDetailedOrder = async () => {
      let response = await OrderApi.getDetailedOrder(orderID);
      console.log(response);
      setLoading(false);
      setDetailedInfo(response);
    };
    getDetailedOrder();
  }, [orderID]);

  const renderOrderItem = (detailedInvoices) => {
    if (detailedInvoices === undefined) return;
    return detailedInvoices.length !== 0
      ? detailedInvoices.map((detailedInvoice) => (
          <OrderItem
            getProductModalInfo={getProductModalInfo}
            key={detailedInvoice.productID}
            product={detailedInvoice}
          />
        ))
      : "";
  };

  const renderShippingAddress = (detailedInfo) => {
    if (loading) {
      return (
        <div className="text-center">
          <Spinner color="primary" />
        </div>
      );
    } else {
      return (
        <React.Fragment>
          <div className="name">{detailedInfo.shippingInfo?.fullname}</div>
          <div className="basic-info">
            Address: {detailedInfo.shippingInfo?.address}
          </div>

          <div className="basic-info">
            Phone: {detailedInfo.shippingInfo?.phone}
          </div>
        </React.Fragment>
      );
    }
  };

  const renderShippingMethod = (detailedInfo) => {
    if (loading) {
      return (
        <div className="text-center">
          <Spinner color="primary" />
        </div>
      );
    } else {
      return (
        <React.Fragment>
          <div className="basic-info">
            Shipping date: {detailedInfo.shippingDate}
          </div>
          <div className="basic-info">Freeship</div>
          <div className="basic-info">
            Invoice creation date: {detailedInfo.invoiceDate}
          </div>
        </React.Fragment>
      );
    }
  };

  return (
    <div className="detailed-order">
      <div className="row">
        <div className="col">
          <div className="title">Shipping Address</div>
          <div className="content">{renderShippingAddress(detailedInfo)}</div>
        </div>
        <div className="col">
          <div className="title">Shipping Method</div>
          <div className="content">{renderShippingMethod(detailedInfo)}</div>
        </div>
        <div className="col">
          <div className="title">Payment Method</div>
          <div className="content">
            <div className="basic-info">Cash On Delivery</div>
          </div>
        </div>
      </div>
      <div className="product-table mt-3">
        <table>
          <thead>
            <tr>
              <th className="">Product</th>
              <th className="">Price</th>
              <th className="">Quantity</th>
              <th className="">Total</th>
            </tr>
          </thead>
          <tbody>{renderOrderItem(detailedInfo.detailedInvoices)}</tbody>
          <tfoot>
            <tr>
              <td colSpan="3">
                <span>Total</span>
              </td>
              <td className="sum">
                <span>
                  {handlePrice(detailedInfo.totalPrice)} <u>đ</u>
                </span>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      {productModalInfo !== null ? (
        <ReviewModal
          productModalInfo={productModalInfo}
          updateReviewStatus={updateReviewStatus}
        />
      ) : (
        ""
      )}
    </div>
  );
}

DetailedOrder.propTypes = {};

export default DetailedOrder;
