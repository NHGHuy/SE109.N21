import { cookiesService } from "helpers/cookiesService";
import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { useHistory, useLocation } from "react-router-dom";
import { register, updateLoggedInStatus } from "utilities/slices/userSlice";
import "./_register.scss";


function Register() {
  const location = useLocation();
  const history = useHistory();
  const [info, setInfo] = useState({});
  const { isRegisted, error } = useSelector((state) => state.user.data);
  const dispatch = useDispatch();
  const [passwordShown, setPasswordShown] = useState(false);
  const handleChangeInputText = (e) => {
    let name = e.target.name;
    let value = e.target.value;
    setInfo({ ...info, [name]: value });
  };
  const togglePassword = () => {
    setPasswordShown(!passwordShown);
    console.log(passwordShown)
  };
  const handleSubmit = (e) => {
    e.preventDefault();

    async function submitToRegister() {
      await dispatch(register(info));
    }
    submitToRegister();
  };

  

  useEffect(() => {
    const checkRegistedStatus = () => {
      const status = cookiesService.getCookies("user");
      if (status === undefined && isRegisted)
        dispatch(updateLoggedInStatus({ isRegisted: false }));
    };
    checkRegistedStatus();

    if (isRegisted) {
      if (location.state?.referrer.pathname) {
        history.push(location.state.referrer.pathname);
      } else history.push("/home");
    }
  }, [isRegisted, history, location, dispatch]);

  

  return (
    <div className="row">
      <div className="col-6 register-background"></div>
      <div className="col-6 register-wrapper">
        <div className="register-wrapper-content">
          <div className="register-title">Welcome to TechShop</div>
          <form>
            <p>Email</p>
            <input
              name="email"
              onChange={handleChangeInputText}
              required
              placeholder="Enter your email"
            />
            <p>Password</p>
            <div className="pass-cointainer"> <input
              name="pswd"
              onChange={handleChangeInputText}
              required
              type={passwordShown ? "text" : "password"} 
              placeholder="Enter your password"
            />
            <input type="checkbox" id="check" onChange={togglePassword} /></div>
                       
            <p>Confirm Password</p>
            <div className="pass-cointainer"> <input
              name="cfpswd"
              onChange={handleChangeInputText}
              required
              type={passwordShown ? "text" : "password"} 
              placeholder="Enter your password"
            />
            <input type="checkbox" id="check" onChange={togglePassword} /></div>
           
            <p>Already have an account? <a href="/login"> Log In </a></p>


            
            <div className="text-center">
              <button onClick={handleSubmit} className="btn">
                Sign Up
              </button>
            </div>
          </form>
          <div>{error}</div>
        </div>
      </div>
    </div>
    // <div className="login-wrapper">
    //   <div className="container">
    //     <div className="screen">
    //       <div className="screen__content">
    //         <form className="login">
    //           <div className="login__field">
//             <i className="login__icon fas fa-user"></i>
    //             <input
    //               name="email"
    //               onChange={handleChangeInputText}
    //               required
    //               type="text"
    //               className="login__input"
    //               placeholder="User name / Email"
    //             />
    //           </div>
    //           <div className="login__field">
    //             <i className="login__icon fas fa-lock"></i>

    //             <input
    //               name="pswd"
    //               onChange={handleChangeInputText}
    //               required
    //               type="password"
    //               className="login__input"
    //               placeholder="Password"
    //             />
    //           </div>
    //           <button className="button login__submit" onClick={handleSubmit}>
    //             <span className="button__text">Log In Now</span>
    //             <i className="button__icon fas fa-chevron-right"></i>
    //           </button>
    //         </form>
    //         <div className="social-login">
    //           <h3>log in via</h3>
    //           <div className="social-icons">
    //             <a href="#" className="social-login__icon fab fa-instagram"></a>
    //             <a href="#" className="social-login__icon fab fa-facebook"></a>
    //             <a href="#" className="social-login__icon fab fa-twitter"></a>
    //           </div>
    //         </div>
    //       </div>
    //       <div className="screen__background">
    //         <span className="screen__background__shape screen__background__shape4"></span>
    //         <span className="screen__background__shape screen__background__shape3"></span>
    //         <span className="screen__background__shape screen__background__shape2"></span>
    //         <span className="screen__background__shape screen__background__shape1"></span>
    //       </div>
    //     </div>
    //   </div>
    // </div>
  );
}

export default Register;