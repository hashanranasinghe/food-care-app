const asyncHandler = require("express-async-handler");
const Forum = require("../models/forumModel");
const fs = require("fs");
const path = require('path');

//get all forums======================================================================
const getForums = asyncHandler(async (req, res) => {
  const forums = await Forum.find();
  res.status(200).json(forums);
});

//get a forum======================================================================
const getForum = asyncHandler(async (req, res) => {
  const forum = await Forum.findById(req.params.id);
  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }
  res.status(200).json(forum);
});

//get own all forums======================================================================
const getOwnForums = asyncHandler(async (req, res) => {

  const forums = await Forum.find({ user_id: req.user.id });
  res.status(200).json(forums);
});

//get a own forum======================================================================
const getOwnForum = asyncHandler(async (req, res) => {
  const forum = await Forum.findOne({
    _id: req.params.id,
    user_id: req.user.id,
  });

  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }

  res.status(200).json(forum);
});

//create forum======================================================================
const createForum = asyncHandler(async (req, res, next) => {

  if (!req.body.title || !req.body.description) {
    res.status(400);
    throw new Error("Title and Description are required.");
  }
  const forum = new Forum({
    user_id: req.user.id,
    title: req.body.title,
    description: req.body.description,
    author: req.body.author,
    category:req.body.category,
  });
  if (req.file) {
    forum.imageUrl = req.file.path;
  }

 
  forum
    .save()
    .then((response) => {
      res.json({
        message: "Forum uploaded.",
      });
    })
    .catch((error) => {
      res.json({
        message: error,
      });
    });
});

//update a forum======================================================================
const updateForum = asyncHandler(async (req, res) => {
  const forum = await Forum.findOne({
    _id: req.params.id,
    user_id: req.user.id,
  });

  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }

  if (req.file) {
    forum.imageUrl = req.file.path;
  }

  forum.title = req.body.title || forum.title;
  forum.description = req.body.description || forum.description;
  forum.author = req.body.author || forum.author;
  forum.category = req.body.category || forum.category;

  forum.updatedAt = Date.now();
  const updatedForum = await forum.save();

  res.status(200).json({
    message: "Forum updated successfully",
    forum: updatedForum,
  });
});

//like post===============================================================================
const likeForum = asyncHandler(async (req, res) => {
 
  try {
    const forum = await Forum.findById(req.params.id);
    if (!forum.likes.includes(req.user.id)) {
      await forum.updateOne({ $push: { likes: req.user.id } });
      res.status(200).json("The forum has been liked.");
    } else {
      await forum.updateOne({ $pull: { likes: req.user.id } });
      res.status(200).json("The forum has been disliked.");
    }
  } catch (err) {}
});

//delete a forum======================================================================
const deleteForum = asyncHandler(async (req, res) => {
  const forum = await Forum.findOne({
    _id: req.params.id,
    user_id: req.user.id,
  });

  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }

  if (forum.imageUrl) {
    // Remove the image file from the file system
    fs.unlink(forum.imageUrl, (err) => {
      if (err) {
        console.error(err);
      }
    });
  }

  await forum.remove();

  res.status(200).json({
    message: "Forum deleted successfully",
    forum: forum,
  });
});

//delete a forum by admin======================================================================
const deleteForumAdmin = asyncHandler(async (req, res) => {
  const forum = await Forum.findOne({
    _id: req.params.id,
  });

  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }

  if (forum.imageUrl) {
    // Remove the image file from the file system
    fs.unlink(forum.imageUrl, (err) => {
      if (err) {
        console.error(err);
      }
    });
  }

  await forum.remove();

  res.status(200).json({
    message: "Forum deleted successfully",
    forum: forum,
  });
});

//delete only image===================================================================
const deleteImageForum = asyncHandler(async (req, res) => {
  const forum = await Forum.findOne({
    _id: req.params.id,
    user_id: req.user.id,
  });

  if (!forum) {
    res.status(404);
    throw new Error("Forum not found");
  }

  if (forum.imageUrl) {
    // Remove the image file from the file system
    const imagePath = path.join(__dirname, '..', forum.imageUrl);
    fs.unlink(imagePath, (err) => {
      if (err) {
        console.error(err);
      }
    });

    // Clear the imageUrl field in the Forum document
    forum.imageUrl = null;
    await forum.save();
  }

  res.status(200).json({
    message: "Forum image deleted successfully",
    forum: forum,
  });
});




module.exports = {
  getForums,
  getOwnForums,
  getOwnForum,
  createForum,
  getForum,
  updateForum,
  likeForum,
  deleteForum,
  deleteImageForum,
  deleteForumAdmin
};
