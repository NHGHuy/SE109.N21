import ProTab from "components/ProductComponents/ProTab/proTab";
import { PropTypes } from "prop-types";
import React, { useEffect, useState } from "react";
import DescriptionTab from "./DescriptionTab/descriptionTab";
import ReviewTab from "./ReviewTab/reviewTab";
import RelatedTab from "./RelatedTab/relatedTab";
import SpecsTab from "./SpecsTab/specsTab";
import "./_singleProTab.scss";

function SingleProTab(props) {
  //console.log("hi");
  const {
    product,
    relatedCategoryProducts,
    relatedBrandProducts,
    firstReviews,
  } = props;
  const [tabContent, setTabContent] = useState(null);
  const [activeTab, setActiveTab] = useState("description");

  const changeTab = (tagName) => {
    setActiveTab(tagName);
  };

  useEffect(() => {
    switch (activeTab) {
      case "description":
        setTabContent(<DescriptionTab longDescrip={product.longDescrip} />);
        break;
      case "review":
        setTabContent(
          <ReviewTab
            rate={product.productRate}
            id={product.productID}
            totalReviews={product.totalReviews}
            firstReviews={firstReviews}
          />
        );
        break;
      case "related":
        setTabContent(
          <RelatedTab
            relatedCategoryProducts={relatedCategoryProducts}
            relatedBrandProducts={relatedBrandProducts}
          />
        );
        break;
      case "specs":
        let generalInfo = {
          brandName: product.brandName,
          warranty: product.warranty,
        };
        setTabContent(
          <SpecsTab specs={product.specs} generalInfo={generalInfo} />
        );
        break;
      default:
        setTabContent(<DescriptionTab longDescrip={product.longDescrip} />);
        break;
    }
  }, [
    activeTab,
    product,
    relatedCategoryProducts,
    relatedBrandProducts,
    firstReviews,
  ]);

  return (
    <div className="single-pro-tab mt-4 container-fluid">
      <div className="row">
        <ProTab
          tagName="specs"
          changeTab={changeTab}
          activeTab={activeTab}
          tagContent="Specs"
        />

        <ProTab
          tagName="description"
          changeTab={changeTab}
          activeTab={activeTab}
          tagContent="Description"
        />

        <ProTab
          tagName="related"
          changeTab={changeTab}
          activeTab={activeTab}
          tagContent="Related Products"
        />

        <ProTab
          tagName="review"
          changeTab={changeTab}
          activeTab={activeTab}
          tagContent="Review"
        />
      </div>

      <div className="row">
        <div className="tab-content">
          {tabContent}
          {/* {tabContent === null ? (
            <ProDescription longDescrip={product.longDescrip} />
          ) : (
            tabContent
          )} */}
        </div>
      </div>
    </div>
  );
}

SingleProTab.propTypes = {
  product: PropTypes.object,
};
SingleProTab.defaultProps = {
  product: {},
};

export default SingleProTab;
