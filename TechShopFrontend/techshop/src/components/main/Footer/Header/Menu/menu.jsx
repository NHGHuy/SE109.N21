import React from "react";
import { Link } from "react-router-dom";
import "./_menu.scss";

function Menu() {
  return (
    <div className="fluid-container menu">
      <div className="row">
        <div className="col">
          <Link className="shop-name" to="/home">
            TechShop
          </Link>
        </div>
      </div>
    </div>
  );
}

export default Menu;
