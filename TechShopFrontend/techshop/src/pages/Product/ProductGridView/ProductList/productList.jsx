import React, { useEffect, useState } from "react";
import { useSelector } from "react-redux";
import { useLocation, useParams } from "react-router-dom";
import { Col, Row } from "reactstrap";
import ProductApi from "api/productApi";
import ProductCard from "pages/Product/common/ProductCard/productCard";
import ProductModal from "components/common/ProductModal/productModal";
import { Spinner } from 'reactstrap';

function ProductList() {
  const [products, setProducts] = useState([]);
  const stateProductModal = useSelector((state) => state.productModal);

  const { filter } = useSelector((state) => state.filter);
  /**
   * Firstly, I use {slug} to get params => filter of useEffect is a string.
   * But if filter is a string, when click repeatedly in 1 category,
   * useEffect is not fired to get new data
   * => I HAVE TO use params as an object.
   */

  const params = useParams();
  const location = useLocation();
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    async function fetchProduct() {
      setLoading(true);
      let response = [];
      if (params.slug === undefined) {
        let searchTerm = new URLSearchParams(location.search).get("keyword");
        if (searchTerm === null) {
          response = await ProductApi.getAllProducts({
            order: filter,
          });
        } else {
          response = await ProductApi.searchProductsIncludeFilter({
            keyword: searchTerm,
            order: filter,
          });
        }
      } else {
        response = await ProductApi.getProductsByCategory({
          category: params.slug,
          order: filter,
        });
      }
      setProducts(response);
      setLoading(false);
    }
    fetchProduct();
  }, [params, filter, location]);

  const renderProductCards = (products) => {
    if(loading) {
      return <Col xs="12" sm="12" md="12" lg="12"className='text-center'>
        <Spinner color="primary" />
      </Col>
    } else 
    return products.length !== 0
      ? products.map((product, index) => (
          <Col key={index} xs="12" sm="6" md="4" lg="4">
            <ProductCard product={product} />
          </Col>
        ))
      : "";
  };
  return (
    <React.Fragment>
      <Row>{renderProductCards(products)}</Row>
      <ProductModal product={stateProductModal.data} />
    </React.Fragment>
  );
}

export default ProductList;
