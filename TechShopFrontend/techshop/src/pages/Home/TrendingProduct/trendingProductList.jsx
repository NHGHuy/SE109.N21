import React, { useState, useEffect } from "react";
import { Row, Col } from "reactstrap";
import TrendingProduct from "components/HomeComponents/TrendingProduct/trendingProduct";
import ProductApi from "api/productApi";

function TrendingProductList() {
  const [trendingProducts, setTrendingProducts] = useState([]);

  useEffect(() => {
    const fetchTrendingProducts = async () => {
      let response = await ProductApi.getTrendingProducts();
      setTrendingProducts(response);
    };
    fetchTrendingProducts();
  }, []);

  const renderTrendingList = (list) => {
    return list.length !== 0
      ? list.map((product, index) => (
          <Col key={index} xs="6" sm="6" md="3" lg="3" className="mb-3">
            <TrendingProduct product={product} />
          </Col>
        ))
      : "";
  };

  return <Row>{renderTrendingList(trendingProducts)}</Row>;
}

export default TrendingProductList;
