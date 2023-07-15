import UserApi from "api/userApi";
import AddressInfo from "components/ShoppingItemsComponents/AddressInfo/addressInfo";
import React, { useEffect, useState } from "react";
import AnotherAddressForm from "./anotherAddressForm";
import "./_billingDetails.scss";

function BillingDetails(props) {
  const { updateShippingInfo } = props;
  const [stateNewAddress, setStateNewAddress] = useState("empty");
  const [content, setContent] = useState(" Add new one");
  const [confirmAddress, setConfirmAddress] = useState(true);
  const [defaultInfo, setDefaultInfo] = useState({});
  //console.log("info");

  const updateInfo = (additionalInfo) => {
    setConfirmAddress(false);

    updateShippingInfo(additionalInfo);
  };

  const showAddressForm = () => {
    if (stateNewAddress === "empty") {
      setStateNewAddress("add");
      setContent("");
    } else {
      updateShippingInfo(null);
      setStateNewAddress("empty");
      setConfirmAddress(true);
      setContent(" Add new one");
    }
  };

  useEffect(() => {
    // call api to get
    const fetchShippingInfo = async () => {
      return UserApi.getShippingInfo()
        .then((res) => {
          setDefaultInfo(res);
        })
        .catch((err) => console.log(err));
    };
    fetchShippingInfo();
  }, []);

  const renderAnotherAddress = (stateNewAddress) => {
    return stateNewAddress === "empty" ? (
      ""
    ) : (
      <AnotherAddressForm cancelAdd={showAddressForm} updateInfo={updateInfo} />
    );
  };

  

  return (
    <div className="billing-details">
      <div>
        <h4>Billing Details</h4>
      </div>
      <div className="mt-2">
        <div className="title-details">
          We will send your order in the address mentioned below
        </div>
        <AddressInfo info={defaultInfo} confirm={confirmAddress} />
        <div className="barrier">
          <span>or</span>
        </div>
        <div className="title-details">
          You would like to use another shipping address?
          <span className="new-address" onClick={showAddressForm}>
            {content}
          </span>
          {renderAnotherAddress(stateNewAddress)}
        </div>
      </div>
    </div>
  );
}

BillingDetails.propTypes = {};

export default BillingDetails;
