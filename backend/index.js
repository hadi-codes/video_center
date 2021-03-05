const port = process.env.PORT || 3000;
const express = require("express");
const { handleError, ErrorHandler } = require("./helpers/error");
const bodyParser = require("body-parser");
var cors = require('cors')

const app = express();

const Address = require("./models/Address");
const Kunde = require("./models/Kunde");
const Video = require("./models/Video");

// const login = require("./routes/user/login");
const kundeController = require("./routes/kunde");
const videoController = require("./routes/video");

// const logout = require("./routes/user/logout")
// const token = require("./routes/user/token")
// const emailConfomation = require("./routes/user/emailConfirmtion")
// const forgotPassword = require("./routes/user/forgotPassword")
// const resetPassword = require("./routes/user/resetPassword")
app.use(cors())

app.get("/error", (req, res) => {
  throw new ErrorHandler(500, "Internal server error");
});

app.use(express.json());
app.use(bodyParser.json());

app.use("/kunde/", kundeController);
app.use("/video/", videoController);

// app.use("/user/signup/", signup);
// app.use("/user/logout", logout)
// app.use("/user/token", token)
// app.use("/user/email-confomation/:token", emailConfomation)
// app.use("/user/forgot-password", forgotPassword)
// app.use("/user/reset-password/:token", resetPassword)

app.get("/", (req, res) => {
  res.send("hello world");
});
app.use((err, req, res, next) => {
  handleError(err, res);
});

async function init() {
  app.listen(port);
  console.log(`listing on port ${port}`);

}

init();
