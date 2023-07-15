import HeaderSection from "components/common/HeaderSection/headerSection";
import Banner from "components/HomeComponents/Banner/banner";
import Subscription from "components/HomeComponents/Subs/subscription";
import React from "react";
import BrandGroup from "./BrandGroup/brandGroup";
import TopProductCarousel from "./TopProductGroup/topProductCarousel";
import TrendingProductList from "./TrendingProduct/trendingProductList";
import "./_home.scss";

function Home() {
  //console.log('home')
  return (
    <React.Fragment>
      <Banner />
      <div className="wrapper-dashboard">
        {/* Trending products*/}
        <div className="trending-dashboard mt-5">
          <HeaderSection content="Trending Products" />
          <div className="trending-row mt-4">
            <TrendingProductList />
          </div>
        </div>

        {/* Top purchased products */}
        <div className="trending-dashboard mt-5">
          <TopProductCarousel />
        </div>

        {/* Hot proposes */}
        {/* <div className="trending-dashboard mt-5">
          <div className="header-hot-proposes">
            <HeaderSection content="Hot Proposes" />
            <div>
              <a
                className=""
                href="#hot-proposes"
                role="button"
                data-slide="prev"
              >
                <i className="fa fa-arrow-left"></i>
              </a>

              <a
                className=""
                href="#hot-proposes"
                role="button"
                data-slide="next"
              >
                <i className="fa fa-arrow-right"></i>
              </a>
            </div>
          </div>
          <ProposedProductList />
        </div> */}

        {/* Subscription */}
        <div className="subscription mt-5">
          <Subscription />
        </div>

        {/* Our supported brands */}
        <div className="supported-brand mt-5">
          <div className="content">
            <div className="sub-header">OUR SUPPORTED BRANDS</div>
            <h1 className="header">BEST OF THE BEST</h1>
            <div className="title-deco">
              <span></span>
            </div>
            <div className="brands m-5">
              <BrandGroup />
            </div>
          </div>
        </div>
     
      </div>
    </React.Fragment>
  );
}

export default React.memo(Home);
