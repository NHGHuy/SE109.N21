import React, { useState, useRef } from "react";
import "./_coupon.scss";
import CouponApi from "api/couponApi";
function Coupon() {
  const [coupon, setCoupon] = useState("");
  const [couponStatus, setCouponStatus] = useState(null);
  const typingTimeoutRef = useRef(null);

  const handleChangeCoupon = (e) => {
    const value = e.target.value;
    setCoupon(value);

    if (typingTimeoutRef.current) {
      clearTimeout(typingTimeoutRef.current);
    }
    typingTimeoutRef.current = setTimeout(() => {
      submitCoupon(value);
    }, 300);
  };

  const submitCoupon = async (id) => {
    // TODO: solve when status code is 404
    let response = await CouponApi.getCouponById(id);
    if (response !== null) setCouponStatus("available");
    else setCouponStatus("unavailable");
  };

  const renderCouponStatus = (status) => {
    return status !== null ? (
      <span className={`alert ${status}`}>Your coupon is {status}</span>
    ) : (
      ""
    );
  };

  return (
    <div className="coupon">
      <div>
        <h4>Coupon Discount</h4>
      </div>
      <p>Enter your coupon code if you have one!</p>
      <div>
        <input
          placeholder="Enter your code here"
          value={coupon}
          onChange={handleChangeCoupon}
        />
        {renderCouponStatus(couponStatus)}
      </div>
    </div>
  );
}

export default Coupon;
