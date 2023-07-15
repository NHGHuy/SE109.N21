import { cookiesService } from "helpers/cookiesService";
import React from "react";
import { useDispatch, useSelector } from "react-redux";
import { Redirect, Route, useLocation } from "react-router-dom";
import { updateLoggedInStatus } from "utilities/slices/userSlice";
/**
 * restData like path, exact
 *
 * TODO: authentication to direct user to login or children component
 */
function PrivateRoute({ children, ...restData }) {
  const location = useLocation();
  const { isLoggedIn } = useSelector((state) => state.user.data);
  const dispatch = useDispatch();

  const status = cookiesService.getCookies("user");

  const checkLoggedInStatus = (status, isLoggedIn) => {
    if (status === undefined && isLoggedIn)
      dispatch(updateLoggedInStatus({ isLoggedIn: false }));
  };

  checkLoggedInStatus(status, isLoggedIn);
  
  const redirectRoute = (loginStatus, children, location) => {
    return loginStatus !== undefined ? (
      children
    ) : (
      <Redirect
        to={{
          pathname: "/login",
          state: { referrer: location },
        }}
      />
    );
  };
  return (
    <Route {...restData}>{redirectRoute(status, children, location)}</Route>
  );
}

PrivateRoute.propTypes = {};

export default PrivateRoute;
