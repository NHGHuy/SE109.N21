import React, { useEffect, useState } from "react";
import { Col, Row } from "reactstrap";
import BrandApi from "api/brandApi";
import image from "assets/images/razer.png";
import "./_brandGroup.scss";

function BrandGroup() {
  const [brands, setBrands] = useState([]);
  useEffect(() => {
    const fetchBrands = async () => {
      let response = await BrandApi.getBrands();
      setBrands(response);
    };
    fetchBrands();
  }, []);
  const renderBrandGroup = (brands) => {
    return brands.length !== 0
      ? brands.map((brand, index) => (
          <Col key={index} xs="4" sm="4" md="3" lg="3">
            <div className="brand-info">
              <div className="brand-img">
                <img src={image} alt={brand.brandName} />
              </div>
              <div className="brand-img">
                <img src={image} alt={brand.brandName} />
              </div>
            </div>
          </Col>
        ))
      : "";
  };
  return <Row>{renderBrandGroup(brands)}</Row>;
}

export default BrandGroup;
