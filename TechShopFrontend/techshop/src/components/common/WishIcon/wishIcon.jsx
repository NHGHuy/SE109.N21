import React, { useState, useEffect } from "react";
import image1 from "assets/images/heart.png";
import image2 from "assets/images/heart1.png";
import "./_wishIcon.scss";
import { useDispatch, useSelector } from "react-redux";
import { editWishList } from "utilities/slices/wishListSlice";
import { PropTypes } from "prop-types";

function WishIcon(props) {
  const [image, setImage] = useState(image1);
  const wishList = useSelector((state) => state.wishList.products);

  const { id } = props;
  const dispatch = useDispatch();

  const editWishItem = (e) => {
    e.preventDefault();
    if (image === image1) setImage(image2);
    else setImage(image1);
    dispatch(editWishList(id));
  };

  useEffect(() => {
    wishList.find((product) => {
      if (product === id) {
        setImage(image2);
      }
      return null;
    });
  }, [wishList, id]);

  return (
    <div className="wish-icon" onClick={editWishItem}>
      <img src={image} alt="Apple watch" />
    </div>
  );
}
WishIcon.prototype = {
  id: PropTypes.string.isRequired,
};
WishIcon.defaultProps = {
  id: "",
};
export default WishIcon;
