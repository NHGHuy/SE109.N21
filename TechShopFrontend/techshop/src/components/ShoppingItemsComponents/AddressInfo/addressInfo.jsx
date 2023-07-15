import { PropTypes } from "prop-types";
import React from "react";
import "./_addressInfo.scss";
import { Spinner } from 'reactstrap';

function AddressInfo(props) {
  const { info, confirm } = props;
  //console.log("address info");
  const renderConfirmTag = (confirm) => {
    return confirm ? (
      <div className="basic-info confirm">Confirmed Address</div>
    ) : (
      ""
    );
  };
  const renderAddressInfo = (info) => {
    console.log(info)
    if (Object.keys(info).length === 0) {
      return (
        <div className="text-center">
          <Spinner color="primary" />
        </div>
      );
    }
    return (
      <React.Fragment>
        <div className="name">{info.fullname}</div>
        <div className="basic-info">Address: {info.address}</div>

        <div className="basic-info">Phone: {info.phone}</div>
        {renderConfirmTag(confirm)}
      </React.Fragment>
    );
  };
  return (
    <div className="shipping-info">
      {renderAddressInfo(info)}
    </div>
  );
}

AddressInfo.propTypes = {
  info: PropTypes.object,
};

export default React.memo(AddressInfo);
