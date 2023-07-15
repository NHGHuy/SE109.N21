import { Cookies } from "react-cookie";

const cookies = new Cookies();

export const cookiesService = {
  setCookies,
  getCookies,
  getRefreshToken,
  updateAccessToken,
  removeCookies,
};
function setCookies(name, value, hours) {
  var expires = new Date();

  if (hours) {
    expires.setTime(expires.getTime() + hours * 60 * 60 * 1000);
  }
  if (name === "user") {
    cookies.set(name, value, {
      path: "/",
      expires: expires,
      secure: true,
      //httpOnly: true,
      sameSite: "lax",
    });
  } else
    cookies.set(name, value, {
      path: "/",
      expires: expires,
    });
}
function getCookies(name) {
  return cookies.get(name);
}
function getRefreshToken() {
  let refreshToken = cookies.get("user")["refresh_token"];

  return refreshToken;
}
function updateAccessToken({ access_token }) {
  let newCookies = cookies.get("user");
  newCookies["access_token"] = access_token;
  setCookies("user", newCookies, 2);
  //console.log(cookies.get("user")["access_token"])
}
function removeCookies(name) {
  return cookies.remove(name);
}
