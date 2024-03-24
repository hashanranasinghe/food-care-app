const express = require("express");
const {
  addComment,
  updateComment,
  getAllCommentsInForum,
} = require("../controllers/commentController");
const {
  getForums,
  createForum,
  getForum,
  updateForum,
  deleteForum,
  getOwnForums,
  getOwnForum,
  likeForum,
  deleteImageForum,
  deleteForumAdmin,
} = require("../controllers/forumController");
const router = express.Router();
const upload = require("../middleware/uploadForumImage");
const validateToken = require("../middleware/validateTokenHandler");

router.use(validateToken);
router.route("/").get(getForums).post(upload.single("imageUrl"),createForum);

router.route("/ownforums").get(getOwnForums);

router
  .route("/ownforums/:id")
  .get(getOwnForum)
  .put(upload.single("imageUrl"),updateForum)
  .delete(deleteForum).delete(deleteForumAdmin);

router.route("/ownforums/:id/image").delete(deleteImageForum); 
router.route("/:id").get(getForum);
router.route("/:id/like").put(likeForum);


router.route("/:id/comment").post(addComment).get(getAllCommentsInForum);
router.route("/:forumId/comment/:commentId").put(updateComment);

module.exports = router;
