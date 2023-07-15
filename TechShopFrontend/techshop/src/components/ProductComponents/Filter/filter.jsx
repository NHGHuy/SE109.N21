import React from "react";
import { useDispatch } from "react-redux";
import "./_filter.scss";
import {updateFilterType} from 'utilities/slices/filterSlice'
const Filter = () => {
  
  const dispatch = useDispatch();

  const handleFilterChange = (e) => {
    dispatch(updateFilterType(e.target.value))
  };

  return (
    <div className="product-heading filter">
      <div className="title">Sort By:</div>
      <select
        className="form-select"
        aria-label="Default select example"
        onChange={handleFilterChange}
      >
        <option value="asc">Price Low to High</option>
        <option value="desc">Price High to Low</option>
      </select>
    </div>
  );
};


export default Filter;
