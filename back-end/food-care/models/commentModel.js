const mongoose = require("mongoose");


const commentSchema = new mongoose.Schema({
  text: { type: String, required: true },
  commenter: { type: String, required: true }, // make sure required is set to true
  commenterId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  date: { type: Date, default: Date.now },
});


module.exports = mongoose.model("Comment", commentSchema);