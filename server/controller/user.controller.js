const User = require("../model/user.model");

const signUp = async (req, res) => {
  const { name, email, profilePic } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) {
      const newUser = new User(req.body);
      await newUser.save();
      return res.status(200).json({ success: true, user:newUser });
    }
    return res
      .status(400)
      .json({ success: false, message: "User Already Exists" });
  } catch (error) {}
  return res.status(500).json({ success: false, message: error.message });
};

const signIn = async (req, res) => {};

module.exports = { signIn, signUp };
