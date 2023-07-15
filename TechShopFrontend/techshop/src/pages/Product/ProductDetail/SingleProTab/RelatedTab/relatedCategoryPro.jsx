import ProductCard from "pages/Product/common/ProductCard/productCard";
import React from "react";
import { Col, Row } from "reactstrap";

function RelatedCategoryPro(props) {
  const { productList } = props;
  

  const renderProductList = (products) => {
    return (
      <Row>
        {products.length !== 0
          ? products.map((product, index) => {
              if (index >= 4) return "";
              return (
                <Col key={index} xs="6" sm="6" md="3" lg="3">
                  <ProductCard product={product} />
                </Col>
              );
            })
          : ""}
      </Row>
    );
  };
  return <React.Fragment>{renderProductList(productList)}</React.Fragment>;
}

export default React.memo(RelatedCategoryPro);
