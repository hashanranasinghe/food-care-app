const express = require("express");
const {
  getFoodPosts,
  createFoodPost,
  updateFoodPost,
  deleteFoodPost,
  getOwnFoods,
  getOwnFood,
  getFoodPost,
  deleteFoodPostImages,
  requestFood,
  acceptFood,
  rejectFood,
  deleteAdminFoodPost,
  completeFoodDonation,
  updateIsCompleteStatus,
  getRequestFood,
  getAcceptedFood,
  getCompletedFood,
} = require("../controllers/foodPostController");
const router = express.Router();
const validateToken = require("../middleware/validateTokenHandler");
const upload = require("../middleware/uploadFoodImage");
const authorizeRoles = require("../middleware/authorizeRoles");

router.use(validateToken);

router
  .route("/")
  .get(getFoodPosts)
  .post(upload.array("imageUrls", 5), createFoodPost);


router.route("/ownfood").get(getOwnFoods);


router.route("/:id").get(getFoodPost);
router.route("/:id/request").put(requestFood);
router.route("/accept").put(acceptFood);
router.route("/reject").put(rejectFood);
router.route("/completedonation").put(completeFoodDonation);
router
  .route("/ownfood/:id")
  .get(getOwnFood)
  .put(upload.array("imageUrls", 5), updateFoodPost)
  .delete(deleteFoodPost);
router.route("/complete/:id").put(updateIsCompleteStatus);
router.route("/adminfood/:id").delete(deleteAdminFoodPost);

//delete food posts by admin
router.route("/process/request").get(getRequestFood)




router.route("/process/accept").get(getAcceptedFood);
router.route("/process/complete").get(getCompletedFood);
router.route("/ownfood/:id/images").delete(deleteFoodPostImages);
module.exports = router;
