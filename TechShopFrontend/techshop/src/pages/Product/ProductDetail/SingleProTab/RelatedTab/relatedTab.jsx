import PropTypes from "prop-types";
import React from "react";
import { useSelector } from "react-redux";
import HeaderSection from "components/common/HeaderSection/headerSection";
import ProductModal from "components/common/ProductModal/productModal";
import RelatedCategoryPro from "./relatedCategoryPro";

function RelatedTab(props) {
  const { relatedCategoryProducts, relatedBrandProducts } = props;
  
  const stateProductModal = useSelector((state) => state.productModal);

  return (
    <React.Fragment>
      <HeaderSection content="Related Products" />
      <RelatedCategoryPro productList={relatedCategoryProducts} />

      <HeaderSection content="Same Brand Products" />
      <RelatedCategoryPro productList={relatedBrandProducts} />

      <ProductModal product={stateProductModal.data} />
    </React.Fragment>
  );
}

RelatedTab.propTypes = {
  category: PropTypes.string,
  brand: PropTypes.string,
};
RelatedTab.defaultProps = {
  category: "",
  brand: "",
};

export default RelatedTab;
