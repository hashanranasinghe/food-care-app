const express = require("express");
const {
  registerUser,
  loginUser,
  currentUser,
  getUser,
  getUsers,
  updateUser,
  verifyUser,
  postForgetPassowrd,
  postResetPassowrd,
  requestFood,
  updatePermission,
  foodPost,
  forum,
  getRequestsFood,
} = require("../controllers/userController");
const upload = require("../middleware/uploadProfileImage");
const validateToken = require("../middleware/validateTokenHandler");
const router = express.Router();

router.post("/register", upload.single("imageUrl"), registerUser);

router.post("/login", loginUser);

router.get("/current", validateToken, currentUser);
router.put("/update/:id", validateToken, updateUser);
router.get("/user/:id", getUser);
router.get("/verify/:id", verifyUser);
router.get("/users", getUsers);
router.put("/request",validateToken, getRequestsFood);
router.put("/requestfood", requestFood);
router.put("/permissionfood", updatePermission);
router.put("/upload",validateToken,foodPost);
router.put("/upload",validateToken,forum);
router.post("/forgetpassword", postForgetPassowrd);
router.put("/resetpassword/:id/:token", postResetPassowrd);
module.exports = router;
