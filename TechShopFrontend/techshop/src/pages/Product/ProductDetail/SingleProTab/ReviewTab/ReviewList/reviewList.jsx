import ReviewApi from "api/reviewApi";
import Pagination from "pages/Product/ProductDetail/SingleProTab/ReviewTab/Pagination/pagination";
import React, { useEffect, useState } from "react";
import { Col, Row } from "reactstrap";
import { REVIEWS_PER_PAGE } from "utilities/Constant";
import Review from "./review";
import "./_reviewList.scss";

function ReviewList(props) {
  const { id, totalReviews, firstReviews } = props;
  const [currentPage, setCurrentPage] = useState(1);
  const [reviews, setReviews] = useState(firstReviews);

  useEffect(() => {
    // totalReviews = 0 => no comment for this product =>  no need to call api
    // current page = 1 => get review from props => no need to call api
    if (totalReviews === 0 || currentPage === 1) {
      setReviews(firstReviews);
      return;
    }

    // call api to get review suitable with current page
    const fetchReviews = async (id, currentPage) => {
      let pageInDB = currentPage - 1;
      let response = await ReviewApi.getReviewsByProductIDByPagination(
        id,
        pageInDB,
        REVIEWS_PER_PAGE
      );
      setReviews(response);
    };

    fetchReviews(id, currentPage);
  }, [currentPage, totalReviews, id, firstReviews]);

  const changeCurrentPage = (page) => {
    if (page === currentPage) return;
    setCurrentPage(page);
  };

  const renderReviewPage = (reviewList) => {
    if (reviewList === null) return "";
    if (totalReviews === 0) return <div>Ko tồn tại review nào</div>;
    return (
      <React.Fragment>
        <Row>
          {reviewList.map((review, index) => (
            <Col
              xs="12"
              sm="12"
              md="6"
              lg="6"
              className="col-review"
              key={index}
            >
              <Review key={index} review={review} />
            </Col>
          ))}
        </Row>
        <Pagination
          totalReviews={totalReviews}
          changeCurrentPage={changeCurrentPage}
        />
      </React.Fragment>
    );
  };
  return <div className="review-list">{renderReviewPage(reviews)}</div>;
}

ReviewList.propTypes = {};

export default ReviewList;
