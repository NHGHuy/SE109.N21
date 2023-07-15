import image from "assets/images/footer.jpeg";
import image1 from "assets/images/white.png";
import React from "react";
import "./_descriptionTab.scss";

const DescriptionTab = (props) => {
  const { longDescrip } = props;

  const renderDescrips = (descrips) => {
    if(descrips !== undefined) {

        var description = '[' + descrips.slice(1,-1) + ']';
        description = JSON.parse(description);
        
        console.log(description);

        return description.map((item, index) => (
            <React.Fragment key={index}>
            <h4>{item.header}</h4>
            <p>{item.content}</p>
            </React.Fragment>
        ));
    };
    return "";
  };


  return (
    <div className="row pro-descrip">
      <div className="col-lg-7 pro-descrip-pic">
        <img src={image} alt="apple-watch" />
        <img src={image1} alt="apple-watch" className="white-line" />
      </div>
      <div className="col-lg-5"></div>
      <div className="pro-descrip-content">
        {renderDescrips(longDescrip)}
      </div>
    </div>
  );
};

export default React.memo(DescriptionTab);
