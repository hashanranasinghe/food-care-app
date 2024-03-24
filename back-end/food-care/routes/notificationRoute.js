const express = require("express");
const { notification } = require("../controllers/notifiController");
const router = express.Router();

router.route("/").post(notification);

module.exports = router;