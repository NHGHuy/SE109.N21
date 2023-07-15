import React, { useState, useEffect } from "react";
import PropTypes from "prop-types";
import "./_timer.scss";

Timer.propTypes = {
  EXP: PropTypes.string,
};
Timer.defaultProps = {
  EXP: "",
};

function Timer(props) {
  const { EXP } = props;
  const [duration, setDuration] = useState("");

  useEffect(() => {
    const timer = setInterval(() => {
      let productEXP = new Date(EXP);

      let milliSeconds = Math.abs(productEXP - new Date()) / 1000;
      //console.log(milliSeconds);

      let days = Math.floor(milliSeconds / 86400);
      milliSeconds -= days * 86400;

      let hours = Math.floor(milliSeconds / 3600) % 24;
      milliSeconds -= hours * 3600;

      let minutes = Math.floor(milliSeconds / 60) % 60;
      milliSeconds -= minutes * 60;

      let seconds = Math.floor(milliSeconds);

      setDuration({
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
      });
    }, 1000);
    return () => {
      clearInterval(timer);
    };
  }, [EXP]);
  return (
    <React.Fragment>
      <div className="count-down-element">
        <div className="count-down-content">
          <div>{duration.days}</div>
          <span>days</span>
        </div>
      </div>
      <div className="count-down-element">
        <div className="count-down-content">
          <div>{duration.hours}</div>
          <span>hours</span>
        </div>
      </div>
      <div className="count-down-element">
        <div className="count-down-content">
          <div>{duration.minutes}</div>
          <span>minutes</span>
        </div>
      </div>
      <div className="count-down-element">
        <div className="count-down-content">
          <div>{duration.seconds}</div>
          <span>seconds</span>
        </div>
      </div>
    </React.Fragment>
  );
}

export default Timer;
