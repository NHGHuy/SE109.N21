
import CartIcon from "components/main/Footer/Header/CartIcon/cartIcon";
import React from "react";


import UserIcon from "./userIcon";
import "./_info.scss";

function Info() {
  //const status = cookiesService.getCookies("user");

  return (
    <div className="info-group d-flex">
      <CartIcon />
      <UserIcon />
    </div>
  );
}

export default Info;
