const express = require("express");
const { createMessage, getMessages } = require("../controllers/chatController");
const router = express.Router();
const validateToken = require("../middleware/validateTokenHandler");
router.use(validateToken);
 
router.route("/").post(createMessage);
router.route("/:conversationId").get(getMessages);

module.exports = router;