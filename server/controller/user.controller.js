const User = require("../model/user.model");

const signUp = async (req, res) => {
  const { name, email, profilePic } = req.body;
  try {
    const user = await User.findOne({ email });
    if (!user) {
      const newUser = new User(req.body);
      await newUser.save();
      return res.status(200).json({ user: newUser });
    }
    return res
      .status(400)
      .json({error: "User Already Exists" });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
};

const signIn = async (req, res) => {};

module.exports = { signIn, signUp };
