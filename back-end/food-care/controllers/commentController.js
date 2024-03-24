const asyncHandler = require("express-async-handler");
const Forum = require("../models/forumModel");
const Comment = require("../models/commentModel");

//get all comments of post========================================================================
const getAllCommentsInForum = asyncHandler(async (req, res) => {
  const forumId = req.params.id;

  try {
    // Find the forum post by ID and populate the comments field
    const forumPost = await Forum.findById(forumId).populate("comments");

    if (!forumPost) {
      return res.status(404).send({ message: "Forum post not found" });
    }

    // Extract the comments from the forum post and send them in the response
    const comments = forumPost.comments;
    res.send({ comments });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "Internal server error" });
  }
});

// Add a new comment to a forum post==================================================================
const addComment = asyncHandler(async (req, res) => {
  const forumId = req.params.id;



  try {
    // Check if the forum post exists
    const forumPost = await Forum.findById(forumId);
    if (!forumPost) {
      return res.status(404).send({ message: "Forum post not found" });
    }

    // Create a new comment and save it to the database
    const newComment = new Comment({
      text: req.body.text,
      commenter: req.body.commenter,
      commenterId: req.user.id, // assumes the authenticated user is making the comment
    });

    await newComment.save();

    // Add the comment to the forum post and save it to the database
    forumPost.comments.push(newComment);
    await forumPost.save();

    res.status(201).send({ message: "Comment added successfully", comment: newComment });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: error });
  }
});


//update comment============================================================================================
const updateComment = asyncHandler(async (req, res) => {
  const forumId = req.params.forumId;
  const commentId = req.params.commentId;
  const { text } = req.body;

  try {
    // Check if the forum post exists
    const forumPost = await Forum.findById(forumId);
    if (!forumPost) {
      return res.status(404).send({ message: "Forum post not found" });
    }

    // Find the comment and update it
    const comment = forumPost.comments.id(commentId);
    if (!comment) {
      return res.status(404).send({ message: "Comment not found" });
    }
    comment.text = text;
    await forumPost.save();

    res.send({ message: "Comment updated successfully", comment: comment });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "Internal server error" });
  }
});

// Delete a comment from a forum post======================================================================
const deleteComment = asyncHandler(async (req, res) => {
  const { forumId, commentId } = req.params;

  try {
    // Check if the forum post exists
    const forumPost = await Forum.findById(forumId);
    if (!forumPost) {
      return res.status(404).send({ message: "Forum post not found" });
    }

    // Find the comment to delete
    const commentToDelete = forumPost.comments.find(
      (comment) => comment._id == commentId
    );
    if (!commentToDelete) {
      return res.status(404).send({ message: "Comment not found" });
    }

    // Check if the authenticated user is the author of the comment
    if (commentToDelete.commentor.toString() !== req.user.id.toString()) {
      return res
        .status(401)
        .send({ message: "You are not authorized to delete this comment" });
    }

    // Remove the comment from the forum post and save it to the database
    forumPost.comments = forumPost.comments.filter(
      (comment) => comment._id != commentId
    );
    await forumPost.save();

    // Delete the comment from the database
    await Comment.findByIdAndDelete(commentId);

    res.send({ message: "Comment deleted successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).send({ message: "Internal server error" });
  }
});

module.exports = {
  addComment,
  updateComment,
  deleteComment,
  getAllCommentsInForum,
};
