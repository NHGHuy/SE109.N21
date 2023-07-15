import { nanoid } from "nanoid";
import React, { useEffect, useState } from "react";
import { Row } from "reactstrap";
import ProductApi from "api/productApi";
import HeaderSection from "components/common/HeaderSection/headerSection";
import FilterTopProduct from "components/HomeComponents/FilterTopProduct/filterTopProduct";
import TopProduct from "./topProduct";
import "./_topProduct.scss";

function TopProductCarousel() {
  const [topProducts, setTopProducts] = useState([]);
  const [filterTopProduct, setFilterTopProduct] = useState("10");

  const TOP_PRODUCT_NUMBER_PER_GROUP = 3;

  // get top purchased prods from DB depending on filterTopProd
  useEffect(() => {
    const fetchTopPurchasedProduct = async (filterTopProduct) => {
      let response = await ProductApi.getTopPurchasedProducts(filterTopProduct)
      setTopProducts(response)
    }
    fetchTopPurchasedProduct(filterTopProduct)
    
  }, [filterTopProduct]);

  const showCarouselIndicators = (length) => {
    let result = [];
    if (length === 0) return result;

    for (let i = 0; i < length; i++) {
      result.push(
        <li
          data-target="#top-dashboard"
          data-slide-to={i}
          className={i === 0 ? "active" : ""}
          key={nanoid()}
        ></li>
      );
    }
    return result;
  };

  const showCarouselItems = (items, productPerGroup) => {
    let tempArr = [];
    // the quantity of page
    let pageNumber = Math.ceil(items.length / productPerGroup);

    for (let i = 0; i < pageNumber; i++) {
      if (productPerGroup * (i + 1) <= items.length)
        tempArr.push(
          items.slice(productPerGroup * i, productPerGroup * (i + 1))
        );
      else tempArr.push(items.slice(productPerGroup * i));
    }

    let res = "";

    res = tempArr.map((arr, index) => {
      return (
        <div
          className={`carousel-item ${index === 0 ? "active" : ""}`}
          key={nanoid()}
        >
          <Row className="top-group">
            {arr.length !== 0
              ? arr.map((element, index) => {
                  return (
                    <div
                      className={`col-sm-${12 / productPerGroup}`}
                      key={index}
                    >
                      <TopProduct product={element} />
                    </div>
                  );
                })
              : ""}
          </Row>
        </div>
      );
    });
    return res;
  };

  const changeTypeTopProduct = (e) => {
    let parent = e.target.parentElement;
    let buttons = parent.querySelectorAll("button");
    buttons.forEach((btn) => {
      if (btn.classList.contains("active")) {
        btn.classList.remove("active");
      }
    });

    let filter = e.target.name;
    e.target.classList.add("active");
    setFilterTopProduct(filter);
  };

  return (
    <React.Fragment>
      <div className="header-top-dashboard">
        <HeaderSection content="Top Purchased Products" />
        <FilterTopProduct changeTypeTopProduct={changeTypeTopProduct} />
      </div>
      <div
        id="top-dashboard"
        className="top-row carousel slide mt-4"
        data-ride="carousel"
        data-interval="false"
      >
        <ul className="carousel-indicators">
          {showCarouselIndicators(
            Math.ceil(topProducts.length / TOP_PRODUCT_NUMBER_PER_GROUP)
          )}
        </ul>
        <div className="carousel-inner">
          {showCarouselItems(topProducts, TOP_PRODUCT_NUMBER_PER_GROUP)}
        </div>
      </div>
    </React.Fragment>
  );
}


export default TopProductCarousel;
