import React, { useEffect, useState } from "react";
import "./_existedBrand.scss";

function ExistedBrand() {
  //console.log('brands')
  const [brands, setBrands] = useState([]);

  // get brands
  useEffect(() => {
    let brandList = [
      {
        quantityProduct: 11,
        name: "Asus",
      },
      {
        quantityProduct: 10,
        name: "Apple",
      },
      {
        quantityProduct: 15,
        name: "HP",
      },
      {
        quantityProduct: 19,
        name: "Razer",
      },
      {
        quantityProduct: 19,
        name: "Dell",
      },
      {
        quantityProduct: 20,
        name: "Asus",
      },
      {
        quantityProduct: 10,
        name: "Apple",
      },
    ];
    setBrands(brandList);
  }, []);

  const renderListBrand = (brands) => {
    let res = "";
    if (brands.length === 0) return res;
    res = brands.map((brand, index) => {
      let randomColor = Math.floor(Math.random() * 16777215).toString(16);
      return (
        <li key={index}>
          <i
            className="fas fa-square-full"
            style={{ color: `#${randomColor}` }}
          ></i>
          <span>{brand.name}</span>
          <span>{brand.quantityProduct}</span>
        </li>
      );
    });
    return res;
  };
  return (
    <div className="option-table">
      <div className="option-table-heading">BRANDS</div>
      <div className="option-table-content brand-table">
        <ul>{renderListBrand(brands)}</ul>
      </div>
    </div>
  );
}

export default ExistedBrand;
