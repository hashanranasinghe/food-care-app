import React, { useState, useEffect } from "react";
import FavoriteIcon from "@mui/icons-material/Favorite";
import CommentIcon from "@mui/icons-material/Comment";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import IconButton from "@mui/material/IconButton";
import Popover from "@mui/material/Popover";
import Typography from "@mui/material/Typography";
import { Button, capitalize } from "@mui/material";
import DeleteModal from "./modals/DeleteModal";
import TimeFormatComponent from "../utils/convertor";
import { useFetchIdData } from "../hooks/useFetchIdData";
import User from "../assests/user.png";
import useFetchFunction from "../hooks/useFetchFunction";
import Snackbar from "@mui/material/Snackbar";
import Alert from "@mui/material/Alert";
import { Link } from "react-router-dom";
export default function RecipeReviewCard({ forum, onForumDelete }) {
  const [showComments, setShowComments] = useState(false);
  const [anchorEl, setAnchorEl] = useState(null);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const { error, fetchData, data, isLoading } = useFetchIdData(
    "user",
    forum.user_id
  );

  const { fetchFunction } = useFetchFunction(
    "deleteForums",
    forum._id,
    "DELETE"
  );

  useEffect(() => {
    _getUser();
  }, []);

  const _getUser = async () => {
    await fetchData();
  };

  const _deleteForum = async () => {
    await fetchFunction();
    setDeleteConfirmationVisible(false);
    setSnackbarOpen(true);
  };
  const [deleteConfirmationVisible, setDeleteConfirmationVisible] =
    useState(false);

  const handleSnackbarClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }

    setSnackbarOpen(false);
    onForumDelete();
  };
  const handleCommentToggle = () => {
    setShowComments(!showComments);
  };

  const handleMoreVertClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMoreVertClose = () => {
    setAnchorEl(null);
  };

  const openMoreVert = Boolean(anchorEl);

  const popoverId = openMoreVert ? "simple-popover" : undefined;

  const handleDeleteButtonClick = () => {
    setDeleteConfirmationVisible(true);
    handleMoreVertClose();
  };

  return (
    <div className="relative flex flex-col shadow-lg mb-6  w-1/2">
      <div className="p-4 flex items-center justify-between">
        <div className="w-full flex justify-between">
          <div className="bg-white rounded-lg flex items-center">
            {data?.imageUrl ? (
              <img
                src={data?.imageUrl}
                alt={`${data?.name}'s Profile`}
                className="h-10 w-10 rounded-full object-cover"
              />
            ) : (
              <img
                src={User} // Replace this with the correct path to user.png
                alt={`${data?.name}'s Profile`}
                className="h-10 w-10 rounded-full object-cover"
              />
            )}
            <div className="ml-3">
              <Link
                className="cursor-pointer font-semibold text-sm hover:underline"
                to={`/UserProfileView/${forum.user_id}`}
              >
                {capitalize(forum.author)}
              </Link>
              <TimeFormatComponent timestamp={[Date(forum.createdAt)]} />
            </div>
          </div>
          <IconButton aria-label="settings" onClick={handleMoreVertClick}>
            <MoreVertIcon />
          </IconButton>
        </div>
        <Popover
          id={popoverId}
          open={openMoreVert}
          anchorEl={anchorEl}
          onClose={handleMoreVertClose}
          anchorOrigin={{
            vertical: "bottom",
            horizontal: "center",
          }}
          transformOrigin={{
            vertical: "top",
            horizontal: "center",
          }}
        >
          <Typography sx={{ p: 1 }}>
            <Button
              className="text-black rounded-xl"
              onClick={handleDeleteButtonClick} // Use the new handler
            >
              Delete
            </Button>
          </Typography>
        </Popover>
      </div>
      {forum.imageUrl ? (
        <img
          src={forum.imageUrl}
          alt={`${forum.title}'s image`}
          className="h-100 w-full object-cover"
        />
      ) : (
        <img
          src={forum} // Replace this with the correct path to user.png
          alt={`${forum.title}'s Profile`}
          className="h-100 w-full object-cover"
        />
      )}
      <div className="p-4">
        <p className="font-bold text-xl text-center">
          {capitalize(forum.title)}
        </p>
      </div>

      <div className="p-4">
        <p className="text-base text-gray-700 text-justify">
          {forum.description}
        </p>
      </div>
      <div className="px-3 py-2 mx-2 bg-green-900 w-fit rounded-xl">
        <p className="text-base text-white text-justify">{forum.category}</p>
      </div>
      <div className="p-4 flex gap-2 items-center justify-between">
        <div className="flex items-center">
          <IconButton aria-label="add to favorites">
            <FavoriteIcon />
          </IconButton>
          <p className="text-gray-700 text-sm">{forum.likes.length} likes</p>
        </div>
        <div className="flex items-center gap-2">
          <button
            className="text-gray-700 transform transition-all duration-200"
            onClick={handleCommentToggle}
          >
            <CommentIcon />
          </button>
          <p className="text-gray-700 text-sm">
            {forum.comments.length} comments
          </p>
        </div>
      </div>
      {showComments && (
        <div className="p-4 bg-gray-100">
          <h2 className="text-lg font-semibold mb-4">Comments</h2>
          {forum.comments.map((comment, index) => (
            <div
              key={index}
              className="bg-white rounded-lg p-3 mb-2 flex items-center"
            >
              {data?.imageUrl ? (
                <img
                  src={data?.imageUrl}
                  alt={`${data?.name}'s Profile`}
                  className="h-10 w-10 rounded-full object-cover"
                />
              ) : (
                <img
                  src={User} // Replace this with the correct path to user.png
                  alt={`${data?.name}'s Profile`}
                  className="h-10 w-10 rounded-full object-cover"
                />
              )}
              <div className="ml-3">
                <p className="text-gray-700 font-semibold">
                  {comment.commenter}
                </p>
                <p>{comment.text}</p>
              </div>
            </div>
          ))}
        </div>
      )}
      {deleteConfirmationVisible && (
        <DeleteModal
          onClose={() => setDeleteConfirmationVisible(false)}
          onDelete={async () => await _deleteForum()}
        />
      )}

      <Snackbar
        open={snackbarOpen}
        autoHideDuration={3000}
        onClose={handleSnackbarClose}
      >
        <Alert onClose={handleSnackbarClose} severity="success">
          Forum deleted successfully!
        </Alert>
      </Snackbar>
    </div>
  );
}
