import ReviewApi from "api/reviewApi";
import starIcon from "assets/images/review.jpeg";
import React, { useEffect, useState } from "react";
import { Spinner } from "reactstrap";
import "./_reviewModal.scss";

function ReviewModal(props) {
  const { productModalInfo, updateReviewStatus } = props;
  
  const [review, setReview] = useState({
    reviewContent: "",
    rating: 0,
  });
  const [isReviewed, setIsReviewed] = useState(false);
  const [loading, setLoading] = useState(false);
  useEffect(() => {
    setIsReviewed(false);
    setReview({
      reviewContent: "",
      rating: 0,
    });
  }, [productModalInfo]);

  const rate = (rate) => {
    //console.log(rate);
    let stars = document.getElementById("rate").querySelectorAll("svg");
    for (let index = 4; index >= 0; index--) {
      if (index >= rate)
        stars[index]
          .querySelector("path")
          .setAttribute("fill", "rgb(253, 216, 53)");
      else stars[index].querySelector("path").setAttribute("fill", "none");
    }
    setReview({
      reviewContent: review.reviewContent,
      rating: 5 - rate,
    });
    //setRating(5 - rate);
  };

  const submitReview = (productID, orderID) => {
    // call api post review
    // productID, orderID, review Content, rate
    let body = {
      orderID,
      productID,
      reviewContent: review.reviewContent,
      rate: review.rating,
    };
    const addReview = async (data) => {
      console.log(data);
      setLoading(true);
      return ReviewApi.addReview(data)
        .then((res) => {
          //console.log(res);
          setLoading(false);
        })
        .catch((err) => {
          console.log(err);
        });
    };
    addReview(body);
    updateReviewStatus(productID);
    setIsReviewed(true);
  };
  const renderReviewBtn = (loading, productModalInfo) => {
    if (loading) {
      return (
        <div className="text-center loading-review">
          <Spinner color="primary" />
        </div>
      );
    }
    return (
      <button
        disabled={review.rating === 0 ? true : false}
        onClick={() =>
          submitReview(productModalInfo.productID, productModalInfo.orderID)
        }
      >
        Submit your review
      </button>
    );
  };
  const renderReviewArea = () => {
    return isReviewed ? (
      <div className="modal-body reviewed-modal-body">
        <img src={starIcon} alt="" srcSet="" />
        <div className="response">
          <div className="thank-you">Thank you for your valuable review!</div>
          <div>
            We really appreciate you taking the time to share your rating with
            us. We look forward to seeing you again soon
          </div>
        </div>
        <button data-dismiss="modal" onClick={() => setIsReviewed(false)}>
          OK
        </button>
      </div>
    ) : (
      <React.Fragment>
        <div className="modal-header">
          <div className="review-modal-header">
            <img src={productModalInfo.productImage} alt="product" />
            <div>
              <div className="product-name">{productModalInfo.productName}</div>
              <div className="supplier">Provided by TechShop</div>
            </div>
          </div>
          <button
            type="button"
            className="close"
            data-dismiss="modal"
            aria-label="Close"
          >
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div className="modal-body review-modal-body">
          <div className="rate-area">
            <div>Vui lòng đánh giá</div>
            <div className="rate-star" id="rate">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="36"
                height="36"
                viewBox="0 0 32 32"
                onClick={() => rate(0)}
              >
                <path
                  fill="none"
                  fillRule="evenodd"
                  stroke="#FFB500"
                  strokeWidth="1.5"
                  d="M16 1.695l-4.204 8.518-9.401 1.366 6.802 6.631-1.605 9.363L16 23.153l8.408 4.42-1.605-9.363 6.802-6.63-9.4-1.367L16 1.695z"
                ></path>
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="36"
                height="36"
                viewBox="0 0 32 32"
                onClick={() => rate(1)}
              >
                <path
                  fill="none"
                  fillRule="evenodd"
                  stroke="#FFB500"
                  strokeWidth="1.5"
                  d="M16 1.695l-4.204 8.518-9.401 1.366 6.802 6.631-1.605 9.363L16 23.153l8.408 4.42-1.605-9.363 6.802-6.63-9.4-1.367L16 1.695z"
                ></path>
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="36"
                height="36"
                viewBox="0 0 32 32"
                onClick={() => rate(2)}
              >
                <path
                  fill="none"
                  fillRule="evenodd"
                  stroke="#FFB500"
                  strokeWidth="1.5"
                  d="M16 1.695l-4.204 8.518-9.401 1.366 6.802 6.631-1.605 9.363L16 23.153l8.408 4.42-1.605-9.363 6.802-6.63-9.4-1.367L16 1.695z"
                ></path>
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="36"
                height="36"
                viewBox="0 0 32 32"
                onClick={() => rate(3)}
              >
                <path
                  fill="none"
                  fillRule="evenodd"
                  stroke="#FFB500"
                  strokeWidth="1.5"
                  d="M16 1.695l-4.204 8.518-9.401 1.366 6.802 6.631-1.605 9.363L16 23.153l8.408 4.42-1.605-9.363 6.802-6.63-9.4-1.367L16 1.695z"
                ></path>
              </svg>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="36"
                height="36"
                viewBox="0 0 32 32"
                onClick={() => rate(4)}
              >
                <path
                  fill="none"
                  fillRule="evenodd"
                  stroke="#FFB500"
                  strokeWidth="1.5"
                  d="M16 1.695l-4.204 8.518-9.401 1.366 6.802 6.631-1.605 9.363L16 23.153l8.408 4.42-1.605-9.363 6.802-6.63-9.4-1.367L16 1.695z"
                ></path>
              </svg>
            </div>
          </div>
          <textarea
            rows="5"
            placeholder="Your review"
            value={review.reviewContent}
            onChange={(e) => {
              setReview({
                reviewContent: e.target.value,
                rating: review.rating,
              });
            }}
          ></textarea>
          <div>
            <div className="btn-review">
              {renderReviewBtn(loading, productModalInfo)}
            </div>
          </div>
        </div>
      </React.Fragment>
    );
  };
  return (
    <div
      className="modal fade"
      id="reviewModal"
      tabIndex="-1"
      role="dialog"
      aria-labelledby="menuModalLabel"
      aria-hidden="true"
    >
      <div
        className="reviewModal modal-dialog modal-lg modal-dialog-centered"
        role="document"
      >
        <div className="modal-content">{renderReviewArea()}</div>
      </div>
    </div>
  );
}

ReviewModal.propTypes = {};
ReviewModal.defaultProps = {};

export default React.memo(ReviewModal);
