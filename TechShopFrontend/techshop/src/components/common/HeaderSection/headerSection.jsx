import React from "react";
import PropTypes from "prop-types";
import './_headerSection.scss'

function HeaderSection(props) {
  const { content } = props;
  return <h4>{content}</h4>;
}

HeaderSection.propTypes = {
  content: PropTypes.string.isRequired,
};

export default React.memo(HeaderSection);
