const parseImages = (imagesString) => {
  if (imagesString !== undefined) {
    //var imagesArray = JSON.parse("[" + images.replace(/'/g, '"') + "]");
    //var images = imagesString.replace(/'/g, '"');
    var images = imagesString.replace('{', '[').replace('}', ']');
    console.log(images);
    images = JSON.parse(images);
    images = images.map((image) => `${process.env.REACT_APP_API_URL}${image}`);
    return images;
  }
  return "";
};
export default parseImages;
