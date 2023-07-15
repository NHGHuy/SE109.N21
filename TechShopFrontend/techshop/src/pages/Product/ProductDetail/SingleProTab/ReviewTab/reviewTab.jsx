import React from "react";
import ReviewList from "./ReviewList/reviewList";
import "./_reviewTab.scss";

function ReviewTab(props) {
  //console.log("review");
  const { rate, id, totalReviews, firstReviews } = props;
  return (
    <div className="review-tab">
      <div className="review-tab-title d-flex">
        <i className="fas fa-star"></i>
        <span className="rate ml-2">
          {Math.round(rate * 100) / 100} ({totalReviews} reviews)
        </span>
      </div>
      <div className="review-tab-content">
        <ReviewList
          totalReviews={totalReviews}
          id={id}
          firstReviews={firstReviews}
        />
      </div>
    </div>
  );
}

ReviewTab.propTypes = {};

export default ReviewTab;
