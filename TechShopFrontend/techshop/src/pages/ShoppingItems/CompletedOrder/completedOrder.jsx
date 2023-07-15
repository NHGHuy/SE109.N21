import React, { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import {
  addNewBreadcrumb,
  removeLastBreadcrumb,
} from "utilities/slices/breadcrumbSlice";
import OrderRow from "./OrderRow/orderRow";
import "./_completedOrder.scss";
import DetailedOrder from "./DetailedOrder/detailedOrder";
import { Route } from "react-router-dom";
import EmptyItem from "components/ShoppingItemsComponents/EmptyItem/emptyItem";
import { Spinner } from 'reactstrap';

import OrderApi from 'api/orderApi';


function CompletedOrder(props) {
  const dispatch = useDispatch();
  const [loading, setLoading] = useState(false);
  const [orders, setOrders] = useState([]);
  useEffect(() => {
    dispatch(
      addNewBreadcrumb({
        name: "Completed Order",
        slug: "/completed-order",
      })
    );

    return () => {
      dispatch(removeLastBreadcrumb());
    };
  }, [dispatch]);

  useEffect(() => {
    async function getAllCompletedOrders () {
      setLoading(true);
      let response = [];
      response = await OrderApi.getAllCompletedOrders();
      setOrders(response);
      setLoading(false);
    };
    getAllCompletedOrders();
  }, []);

  const renderOrders = (orders) => {
    return orders.length !== 0
      ? orders.map((order) => {
          return <OrderRow key={order.invoiceID} invoice={order} />;
        })
      : null;
  };

  const renderCompletedOrder = (orders, loading) => {
    if(loading) {
      return <div className='text-center'>
        <Spinner color="primary" />
      </div>
    } else 
    return orders.length !== 0 ? (
      <React.Fragment>
        <div>
          <h4>Your Orders</h4>
        </div>
        <Route exact path="/completed-order">
          <div className="table-content">
            <table className="completed-order-table">
              <thead>
                <tr>
                  <th className="">Order ID</th>
                  <th className="">Order Date</th>
                  {/* <th className="">Product</th> */}
                  <th className="">Total</th>
                  <th className="">Status</th>
                </tr>
              </thead>
              <tbody>{renderOrders(orders)}</tbody>
            </table>
          </div>
        </Route>
        <Route path="/completed-order/:orderID">
          <DetailedOrder />
        </Route>
      </React.Fragment>
    ) : (
      <EmptyItem title="completed-order" />
    );
  };

  return <div className="table-wrapper completed-order">
    {renderCompletedOrder(orders, loading)}
  </div>;
}

CompletedOrder.propTypes = {};

export default CompletedOrder;

