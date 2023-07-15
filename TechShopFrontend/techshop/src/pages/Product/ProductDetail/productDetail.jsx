import ProductApi from "api/productApi";
import React, { useEffect, useState } from "react";
import { useDispatch } from "react-redux";
import { useParams } from "react-router-dom";
import { Col, Spinner } from "reactstrap";
import { DEFAULT_REVIEW_PAGE, REVIEWS_PER_PAGE } from "utilities/Constant";
import {
  addNewBreadcrumb,
  removeLastBreadcrumb,
} from "utilities/slices/breadcrumbSlice";
import SingleProInfo from "./SingleProInfo/singleProInfo";
import SingleProTab from "./SingleProTab/singleProTab";
import ReviewApi from 'api/reviewApi';

function ProductDetail() {
  const dispatch = useDispatch();
  const { id } = useParams();

  const [product, setProduct] = useState(null);
  const [relatedCategoryProducts, setRelatedCategoryProducts] = useState(null);
  const [relatedBrandProducts, setRelatedBrandProducts] = useState(null);
  const [firstReviews, setFirstReviews] = useState(null);

  useEffect(() => {
    const fetchProduct = async () => {
      let response = await ProductApi.getDetailedProduct(id);
      dispatch(
        addNewBreadcrumb({
          name: response.productName,
          slug: "",
        })
      );
      setProduct(response);
    };

    let fetchRelatedCategoryProduct = async () => {
      let response = await ProductApi.getRelatedCategoryPro(id);
      setRelatedCategoryProducts(response);
    };

    let fetchRelatedBrandProduct = async () => {
      let response = await ProductApi.getRelatedBrandPro(id);
      setRelatedBrandProducts(response);
    };

    let fetchFirstReviews = async () => {
      let response = await ReviewApi.getReviewsByProductIDByPagination(
        id,
        DEFAULT_REVIEW_PAGE,
        REVIEWS_PER_PAGE
      );
      setFirstReviews(response);
    };

    fetchProduct();
    fetchRelatedBrandProduct();
    fetchRelatedCategoryProduct();
    fetchFirstReviews();

    // Promise.all([
    //   fetchProduct(),
    //   fetchRelatedCategoryProduct(),
    //   fetchRelatedBrandProduct(),
    // ]).then(function ([
    //   product,
    //   relatedCategoryProducts,
    //   relatedBrandProducts,
    // ]) {
    //   setLoading(false);
    //   setAllProductInfo({
    //     product,
    //     relatedCategoryProducts,
    //     relatedBrandProducts,
    //   });
    // });

    return () => {
      dispatch(removeLastBreadcrumb());
    };
  }, [dispatch, id]);

  const renderProductDetail = () => {
    if (product === null) {
      return (
        <Col xs="12" sm="12" md="12" lg="12" className="text-center">
          <Spinner color="primary" />
        </Col>
      );
    }
    return (
      <React.Fragment>
        <SingleProInfo product={product} />
        <SingleProTab
          product={product}
          relatedCategoryProducts={relatedCategoryProducts}
          relatedBrandProducts={relatedBrandProducts}
          firstReviews={firstReviews}
        />
      </React.Fragment>
    );
  };

  return <React.Fragment>{renderProductDetail()}</React.Fragment>;
}

//ProductDetail.propTypes = {};

export default ProductDetail;
