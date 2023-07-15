const handlePrice = (price) => {
    if(price !== undefined){
      var priceFormat = "";
      while(price > 1000){
        if(price % 1000 !== 0){
            priceFormat = "." + price % 1000 + priceFormat;
        }
        else{
            priceFormat = ".000" + priceFormat;
        }
        price = Math.floor(price / 1000);
      }
      return price.toString().concat(priceFormat);
    }
    return "";
  }
  export default handlePrice;