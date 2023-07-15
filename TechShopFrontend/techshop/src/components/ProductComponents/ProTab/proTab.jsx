import React from "react";
import "./_proTab.scss";
import { Col } from "reactstrap";
function ProTab(props) {
  const { tagName, changeTab, activeTab, tagContent } = props;
  return (
    <Col
      xs="6"
      sm="3"
      md="3"
      lg="3"
      className={`pro-tab ${activeTab === tagName ? "active" : ""}`}
      onClick={() => {
        changeTab(tagName);
      }}
    >
      {tagContent}
    </Col>
  );
}

ProTab.propTypes = {};

export default ProTab;
