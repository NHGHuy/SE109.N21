import React from "react";
import { Link } from "react-router-dom";

import { PropTypes } from "prop-types";
import { nanoid } from "nanoid";
import Result from "components/main/Footer/Header/Results/result";
import "./_results.scss";

function Results(props) {
  const { data } = props;
  //console.log(data);
  const { results, otherResults, searchTerm } = data;

  const arrangeResults = (results, otherResults, searchTerm) => {
    let res = "";
    if (results === null) return null;
    if (results.length === 0) {
      return (
        <div className="result justify-content-center">NO results found</div>
      );
    }

    if (otherResults <= 0) {
      res = results.map((result) => {
        return <Result product={result} key={result.id} />;
      });
    } else {
      res = results.map((result, index) => {
        if (index !== results.length - 1) {
          return <Result product={result} key={result.id} />;
        } else {
          return (
            <React.Fragment key={nanoid()}>
              <Result product={result} key={result.id} />
              <Link
                className="result justify-content-center"
                to={`/products?keyword=${searchTerm}`}
                key={nanoid()}
              >
                {otherResults} different results were found
              </Link>
            </React.Fragment>
          );
        }
      });
    }
    return res;
  };

  return (
    <React.Fragment>
      {results === null ? (
        <div></div>
      ) : (
        <div className="result-container">
          {arrangeResults(results, otherResults, searchTerm)}
        </div>
      )}
    </React.Fragment>
  );
}

Results.propTypes = {
  data: PropTypes.object.isRequired,
};

export default Results;
