import image from "assets/images/city_7.jpg";
import ProductRating from "components/common/ProductRating/productRating";
import formatDate from "helpers/formatDate";
import React from "react";
import "./_review.scss";

function Review(props) {
  const { review } = props;
  return (
    <div className="review">
      <div className="review-title d-flex">
        <div className="reviewer d-flex">
          <img src={image} alt="avatar" />
          <div className="reviewer-info">
            <div>{review.fullname}</div>
            <div className="date">{formatDate(review.reviewDate)}</div>
          </div>
        </div>
        <div className="rating d-flex">
          <ProductRating rate={review.rate} />
          <div className="authen-tag mt-1">
            Bought from <i className="fas fa-check-circle"></i>TechShop
          </div>
        </div>
      </div>
      <div className="review-body">
        <div className="review-content mb-2">{review.reviewContent}</div>
        <div className="reply-review">
          <button className="btn-reply">
            <i className="fa fa-reply"></i>
          </button>
          <button className="btn-reply">
            <i className="far fa-comment"></i> 8
          </button>
        </div>
      </div>
    </div>
  );
}

Review.propTypes = {};

export default Review;
