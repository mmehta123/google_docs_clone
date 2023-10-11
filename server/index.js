const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");
const morgan=require("morgan")
const authRoute = require("./routes/user.route");

dotenv.config();
const app = express();
app.use(cors());
app.use(express.json());
app.use(morgan("dev"));

app.use(authRoute);

const PORT = process.env.PORT || 3001;

app.listen(PORT, "0.0.0.0", () => {
  connectDB();
  console.log("server is connected on ", PORT);
});

const connectDB = async () => {
  try {
    await mongoose.connect(process.env.DB_URL);
    console.log("mongoDB connected");
  } catch (error) {
    console.log("something went wrong DB not connected", e);
  }
};
