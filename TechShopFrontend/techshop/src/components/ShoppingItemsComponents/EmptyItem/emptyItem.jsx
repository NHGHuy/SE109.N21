import image from "assets/images/footer1.jpeg";
import image1 from "assets/images/white.png";
import { PropTypes } from "prop-types";
import React from "react";
import { Link } from "react-router-dom";
import "./_emptyItem.scss";

EmptyItem.propTypes = {
  title: PropTypes.string.isRequired,
};
EmptyItem.defaultProps = {
  title: "cart",
};

const showHeadingStatement = (title) => {
  let result = "";
  switch (title) {
    case "check-out":
      result = "Adding at least one product to complete your order process";
      break;
    case "order-complete":
      result = "Your order history is empty. Place order now.";
      break;
    default:
      result = `Your ${title} is empty`;
      break;
  }
  return result;
};

function EmptyItem(props) {
  const { title } = props;
  return (
    <React.Fragment>
      <div className="row empty-compo">
        <div className="col-lg-7 empty-compo-pic">
          <img src={image} alt="apple-watch" />
          <img src={image1} alt="apple-watch" className="white-line" />
        </div>
        <div className="col-lg-5"></div>
        <div className="empty-compo-content">
          <h4>{showHeadingStatement(title)}</h4>
          <div>
            <Link to="/products">Shop today's deals</Link>
          </div>
          <div>
            {/* <button className="btn-sign-in">
              <NavLink to="/login">Sign in to your account</NavLink>
            </button> */}
            {/* <button className="btn-sign-up">Sign up now </button> */}
          </div>
        </div>
      </div>
    </React.Fragment>
  );
}

export default EmptyItem;
