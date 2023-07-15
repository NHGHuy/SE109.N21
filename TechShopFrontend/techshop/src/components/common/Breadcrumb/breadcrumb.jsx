import React from "react";
import "./_breadcrumb.scss";
import { useSelector } from "react-redux";
import { Link } from "react-router-dom";
function Breadcrumb() {
  const { breadcrumb } = useSelector((state) => state.breadcrumb);
  const renderBreadcrumb = (breadcrumb) => {
    return breadcrumb.length !== 0
      ? breadcrumb.map((element, index) =>
          index !== breadcrumb.length - 1 ? (
            <li key={index}>
              <Link to={element.slug}>{element.name}</Link>
            </li>
          ) : (
            <li key={index} className="active-breadcrumb">
              {element.name}
            </li>
          )
        )
      : "";
  };
  return <ul>{renderBreadcrumb(breadcrumb)}</ul>;
}

export default Breadcrumb;
