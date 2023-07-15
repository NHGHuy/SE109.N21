import React from "react";
import "./_btn.scss";

function BtnMore() {
  return (
    <button className="btn-tranform btn-learn-more btn-main ">
      <span className="name">Learn more</span>
      <span className="icon">
        <i className="fa fa-long-arrow-alt-right"></i>
      </span>
    </button>
  );
}


export default BtnMore;
