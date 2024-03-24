const axios = require("axios");
const asyncHandler = require("express-async-handler");

const verificationEmail = asyncHandler(async function (
  email,
  verificationToken,
  name
) {
  const baseLink =
    "http://localhost:5001/api/users/verify/" + verificationToken;
  const apiKey = process.env.EMAIL_API;
  const url = process.env.EMAIL_URL;

  const headers = {
    accept: "application/json",
    "api-key": apiKey,
    "content-type": "application/json",
  };

  const data = JSON.stringify({
    sender: { name: "Food Care", email: process.env.FOODCARE_EMAIL },
    to: [{ email: email, name: name }],
    subject: "Food Care Account Verification",
    htmlContent: `<html><head></head><body><p>Hello,</p><a href="${baseLink}">Verify your Account</a><br></body></html>`,
  });

  try {
    const response = await axios.post(url, data, { headers });
    console.log("Email sent successfully");
  } catch (error) {
    console.error(`Failed to send email: ${error.message}`);
  }
});

const resetEmail = asyncHandler(async function (email, link) {
  const apiKey = process.env.EMAIL_API;
  const url = process.env.EMAIL_URL;

  const headers = {
    accept: "application/json",
    "api-key": apiKey,
    "content-type": "application/json",
  };

  const data = JSON.stringify({
    sender: { name: "Food Care", email: process.env.FOODCARE_EMAIL },
    to: [{ email: email, name: "hashan" }],
    subject: "Food Care Reset Password",
    htmlContent: `<html><head></head><body><p>Hello,</p><p>${link}</p><br></body></html>`,
  });

  try {
    const response = await axios.post(url, data, { headers });
    console.log("Email sent successfully");
  } catch (error) {
    console.error(`Failed to send email: ${error.message}`);
  }
});

module.exports = {
  verificationEmail,
  resetEmail,
};
