const express = require("express");
const {
  getReports,
  getOwnReports,
  createReport,
  deleteReport,
  getAction,
} = require("../controllers/reportController");
const router = express.Router();
const validateToken = require("../middleware/validateTokenHandler");
router.use(validateToken);

router.route("/").get(getReports).post(createReport);

router.route("/ownReport").get(getOwnReports);

router.route("/adminreport/:id").delete(deleteReport).put(getAction);

module.exports = router;
