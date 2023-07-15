const formatDate = (dateString) => {
  let dateFormat = new Date(dateString);

  const month = dateFormat.toLocaleString("default", { month: "long" });
  const year = dateFormat.getFullYear();
  const date = dateFormat.getDate();
  return `${month} ${date}, ${year}`;
};
export default formatDate;
