import Footer from "components/main/Footer/footer";
import Header from "pages/Header/header";
import ScrollToTop from "components/main/ScrollToTop/scrollToTop";
import ScrollToTopRouter from "components/main/ScrollToTop/scrollToTopRouter";
import News from "components/news";
import PrivateRoute from "components/privateRoute";
import Sale from "components/sale";
import Home from "pages/Home/main";
import Login from "pages/Login/login";
import Register from "pages/Register/register";
import Product from "pages/Product/main";
import ShoppingCart from "pages/ShoppingItems/main";
import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import "./App.css";
import "./_app.scss";
import KommunicateChat from "components/main/chat";

function App() {
  console.log("app");
  return (
    <div className="wrapper">
      <div className="main-content">
        <Router>
          <Header />
          <div className="body-content">
            <ScrollToTop />
            <ScrollToTopRouter>
              <Switch>
                <Route exact path={["/home", "/"]}>
                  <Home />
                </Route>
                <Route path={["/shopping-cart", "/wish-list"]}>
                  <ShoppingCart />
                </Route>
                <Route path="/user-info">
                  <News />
                </Route>

                <Route path={["/products", "/products/:slug"]}>
                  <Product />
                </Route>

                <Route path="/contacts" component={News} />

                {/* <News />
                </Route> */}

                <Route path="/login">
                  <Login />
                </Route>
                
                <Route path="/register">
                  <Register />
                </Route>

                <Route path="/sales">
                  <Sale />
                </Route>
                <PrivateRoute path={["/check-out", "/completed-order"]}>
                  <ShoppingCart />
                </PrivateRoute>
              </Switch>
            </ScrollToTopRouter>
            
            <Footer />
          </div>
        </Router>
      </div>
    </div>
  );
}

export default App;
