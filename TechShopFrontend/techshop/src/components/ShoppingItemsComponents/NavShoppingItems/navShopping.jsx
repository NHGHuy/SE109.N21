import React from "react";
import { NavLink } from "react-router-dom";
import { Row } from "reactstrap";
import "./_navShopping.scss";

function NavShopping() {
  const nav = [
    {
      name: "Shopping Cart",
      slug: "/shopping-cart",
    },
    {
      name: "Wish List",
      slug: "/wish-list",
    },
    {
      name: "Check out",
      slug: "/check-out",
    },
    {
      name: "Completed Order",
      slug: "/completed-order",
    },
  ];

  return (
    <Row>
      {nav.map((element, index) => (
        <NavLink
          key={index}
          to={element.slug}
          activeClassName="active"
          className="nav-shopping col-lg-3 col-md-6 col-sm-6 col-xs-6 "
        >
          {element.name}
        </NavLink>
      ))}
    </Row>
  );
}

export default NavShopping;
