const mongoose = require("mongoose");
const Comment = require("../models/commentModel")

const forumSchema = new mongoose.Schema(
  {
    user_id: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "User",
    },
    title: { type: String, required: true },
    description: { type: String },
    category: { type: String },
    author: { type: String },
    imageUrl: { type: String },
    likes: {
      type: Array,
      default: [],
    },
    comments: [Comment.schema],
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model("Forum", forumSchema);
