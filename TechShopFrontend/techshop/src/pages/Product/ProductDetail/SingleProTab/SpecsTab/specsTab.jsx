import HeaderSection from "components/common/HeaderSection/headerSection";
import React from "react";
import "./_specsTab.scss";
function SpecsTab(props) {
  const { specs, generalInfo } = props;

  const renderGeneralInfo = (generalInfo) => {
    return (
      <React.Fragment>
        <div className="d-flex gen-info">
          <div className="tag">Brand:</div>
          <div>{generalInfo.brandName}</div>
        </div>
        <div className="d-flex gen-info">
          <div className="tag">Warranty:</div>
          <div>{generalInfo.warranty} month(s)</div>
        </div>
      </React.Fragment>
    );
  };

  const renderSpecsInfo = (specsInfo) => {
    if (specsInfo !== undefined) {
      var specifications = '[' + specsInfo.slice(1,-1) + ']';
      specifications = JSON.parse(specifications);
      return specifications.map((item, index) => {
        if (index % 2 === 0) {
          return (
            <div className="row specs" key={index}>
              <div className="col-4 specs-tag">{item.tag}</div>
              <div className="col-8 specs-content">{item.content}</div>
            </div>
          );
        } else {
          return (
            <div className="row specs specs-deco" key={index}>
              <div className="col-4 specs-tag">{item.tag}</div>
              <div className="col-8 specs-content">{item.content}</div>
            </div>
          );
        }
      });
    }
    return "";
  };

  return (
    <div className="row">
      <div className="col-lg-5">
        <HeaderSection content="General Information" />
        {renderGeneralInfo(generalInfo)}
      </div>
      <div className="col-lg-7">
        <HeaderSection content="Product Specification" />
        {renderSpecsInfo(specs)}
      </div>
    </div>
  );
}

SpecsTab.propTypes = {};

export default SpecsTab;
