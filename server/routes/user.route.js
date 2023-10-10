const express = require("express");
const { signIn, signUp } = require("../controller/user.controller");

const authRoute = express.Router();

authRoute.post("/api/signin", signIn);
authRoute.post("/api/signup", signUp);
module.exports = authRoute;
