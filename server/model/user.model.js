const mongoose = require("mongoose");

const userSchema =new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    unique: true,
    required: true,
  },
  profilePic: {
    type: String,
    required: true,
  },
},{timestamps:true,versionKey:false});

const UserModel = mongoose.model("user", userSchema);
module.exports = UserModel;
