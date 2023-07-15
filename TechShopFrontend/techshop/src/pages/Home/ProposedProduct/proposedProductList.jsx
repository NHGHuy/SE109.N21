import React, { useState, useEffect } from "react";
import ProposedProduct from "./proposedProduct";
import { nanoid } from "nanoid";
import ProductApi from "api/productApi";

function ProposedProductList() {
  const [proposedProducts, setProposedProducts] = useState([]);
  useEffect(() => {
    const fetchProposedProducts = async () => {
      let response = await ProductApi.getProposedProducts();
      setProposedProducts(response);
    };
    fetchProposedProducts();
  }, []);
  const renderProductList = (list) => {
    return list.length !== 0
      ? list.map((product, index) => {
          return (
            <div
              className={`carousel-item ${index === 0 ? "active" : ""}`}
              key={nanoid()}
            >
              <ProposedProduct product={product} />
            </div>
          );
        })
      : "";
  };
  return (
    <div
      id="hot-proposes"
      className="carousel slide"
      data-ride="carousel"
      data-interval="false"
    >
      <div className="carousel-inner">
        {renderProductList(proposedProducts)}
      </div>
    </div>
  );
}

export default ProposedProductList;
