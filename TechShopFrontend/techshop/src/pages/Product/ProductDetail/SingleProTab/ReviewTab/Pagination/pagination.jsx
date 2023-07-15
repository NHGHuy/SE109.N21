import React from "react";
import "./_pagination.scss";
import { REVIEWS_PER_PAGE } from "utilities/Constant";

function Pagination(props) {
  const { totalReviews, changeCurrentPage } = props;
  const renderPagination = () => {
    let pageNumbers = Math.ceil(totalReviews / REVIEWS_PER_PAGE);
    let result = [];
    for (let i = 1; i <= pageNumbers; i++) {
      result.push(
        <li className="page-item" key={i}>
          <button className="page-link" onClick={() => changeCurrentPage(i)}>
            {i}
          </button>
        </li>
      );
    }
    return result;
  };
  return (
    <div>
      <ul className="pagination">{renderPagination()}</ul>
    </div>
  );
}

Pagination.propTypes = {};

export default React.memo(Pagination);
