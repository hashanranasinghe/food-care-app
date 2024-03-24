const asyncHandler = require("express-async-handler");
const Report = require("../models/reportModel");

//get all reports======================================================================
const getReports = asyncHandler(async (req, res) => {
  const reports = await Report.find();
  res.status(200).json(reports);
});

//get own all forums======================================================================
const getOwnReports = asyncHandler(async (req, res) => {

  const reports = await Report.find({ user_id: req.user.id });
  res.status(200).json(reports);
});

//create forum======================================================================
const createReport = asyncHandler(async (req, res) => {
  if (!req.body.description) {
    res.status(400);
    throw new Error("Description is required.");
  }

  const report = new Report({
    user_id: req.user.id,
    description: req.body.description,
    post: {
      id: req.body.post.id,
      type: req.body.post.type,
    },
    action: req.body.action,
  });

  try {
    const savedReport = await report.save();
    res.json({
      message: "Report uploaded.",
      report: savedReport, // Optionally send back the saved report data
    });
  } catch (error) {
    res.status(500).json({
      message: "Error uploading report.",
      error: error.message,
    });
  }
});

//delete report================================================================
const deleteReport = asyncHandler(async (req, res) => {
  const report = await Report.findOne({
    _id: req.params.id,
  });

  if (!report) {
    res.status(404);
    throw new Error("report not found");
  }

  await report.remove();

  res.status(200).json({
    message: "report deleted successfully",
    report: report,
  });
});

//update a action======================================================================

const getAction = asyncHandler(async (req, res) => {
  try {
    const report = await Report.findById(req.params.id);
    if (report.action === "YES") {
      report.action = "NO";
      await report.save();
      res.status(200).json("The action has been updated to 'NO'.");
    } else {
      report.action = "YES";
      await report.save();
      res.status(200).json("The action has been updated to 'YES'.");
    }
  } catch (err) {
    res.status(500).json("An error occurred.");
  }
});

module.exports = {
  getReports,
  getOwnReports,
  createReport,
  deleteReport,

  getAction,
};
