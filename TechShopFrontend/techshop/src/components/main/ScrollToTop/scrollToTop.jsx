import React from "react";
import { useState, useEffect } from "react";
import "./_scrollToTop.scss";

function ScrollToTop() {
  const [isVisible, setIsVisible] = useState(false);

  const toggleVisibility = () => {
    if (window.pageYOffset > 100) {
      setIsVisible(true);
    } else {
      setIsVisible(false);
    }
  };

  const scrollToTop = () => {
    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  useEffect(() => {
    // add function for scroll event
    window.addEventListener("scroll", toggleVisibility);
  }, []);

  return (
    <div className="scroll-to-top">
      {isVisible ? (
        <div onClick={scrollToTop}>
          <i className="fa fa-arrow-circle-up"></i>
        </div>
      ) : (
        ""
      )}
    </div>
  );
}

export default ScrollToTop;
