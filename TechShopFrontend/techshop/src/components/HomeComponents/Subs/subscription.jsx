import React from "react";
import './_subscription.scss'


function Subscription() {
  return (
    <div className="content">
      <div className="header-subs mb-4">
        <span>SPECIAL OFFERS</span> FOR SUBSCRIBERS
      </div>
      <h3>
        NEW OFFERS EVERY WEEK <span>+</span>{" "}
      </h3>
      <h3>
        DISCOUNT SYSTEM <span>+</span> BEST PRICES
      </h3>
      <div className="sub-content mt-4">
        Lorem ipsum dolor sit amet consectetur, adipisicing elit. Voluptates eos
        obcaecati, aliquam amet dolore enim ab dolorum. Debitis voluptate, nam
        corporis sit pariatur perferendis nobis iure soluta inventore, ipsum
        ratione.
      </div>
      <form className="subs-input mt-4">
        <input />
        <button type="button">Submit</button>
      </form>
    </div>
  );
}


export default Subscription;
