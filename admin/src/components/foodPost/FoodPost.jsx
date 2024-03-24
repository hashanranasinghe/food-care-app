import React, { useState, useEffect } from "react";
import TimeFormatComponent from "../../utils/convertor";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import Popover from "@mui/material/Popover";
import { Button, capitalize } from "@mui/material";
import IconButton from "@mui/material/IconButton";
import { useFetchIdData } from "../../hooks/useFetchIdData";
import User from "../../assests/user.png";
import Snackbar from "@mui/material/Snackbar";
import Alert from "@mui/material/Alert";
import DeleteModal from "../modals/DeleteModal";
import FP from "../../assests/data/Foods/FP1.jpeg";

import RequestRow from "./RequestRow";
import useFetchFunction from "../../hooks/useFetchFunction";
import { Link } from "react-router-dom";

export const FoodPost = ({ post, onFoodDelete }) => {
  const [anchorEl, setAnchorEl] = useState(null);
  const [snackbarOpen, setSnackbarOpen] = useState(false);

  const { error, fetchData, data, isLoading } = useFetchIdData(
    "user",
    post.user_id
  );
  const { fetchFunction } = useFetchFunction("deleteFoods", post._id, "DELETE");

  useEffect(() => {
    _getUser();
  }, []);

  const _getUser = async () => {
    await fetchData();
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

  const [deleteConfirmationVisible, setDeleteConfirmationVisible] =
    useState(false);
  const _deleteFood = async () => {
    await fetchFunction();
    setDeleteConfirmationVisible(false);
    setSnackbarOpen(true);
  };
  const handleSnackbarClose = (event, reason) => {
    if (reason === "clickaway") {
      return;
    }

    setSnackbarOpen(false);
    onFoodDelete();
  };

  const Slideshow = () => {
    const [currentSlide, setCurrentSlide] = useState(0);
    const nextSlide = () => {
      setCurrentSlide((prevSlide) => (prevSlide + 1) % post.imageUrls.length);
    };

    useEffect(() => {
      const intervalId = setInterval(nextSlide, 3000);
      return () => clearInterval(intervalId);
    }, []);
    if (post.imageUrls.length === 0) {
      return (
        <div className="slideshow-container">
          <div className="slide block">
            <img
              src={FP}
              alt="Default"
              className="object-cover rounded-xl"
              style={{ width: "500px", height: "500px" }}
            />
          </div>
        </div>
      );
    }
    return (
      <div className="slideshow-container">
        {post.imageUrls.map((image, index) => (
          <div
            key={index}
            className={`slide ${index === currentSlide ? "block" : "hidden"}`}
          >
            <img
              src={image}
              alt={image.imgAlt}
              className="object-cover rounded-xl"
              style={{ width: "500px", height: "500px" }}
            />
          </div>
        ))}
      </div>
    );
  };

  const DetailsSection = () => {
    return (
      <div className="flex-1 md:max-w-3xl ">
        <div className="flex w-full justify-between">
          <div className="flex">
            <div className="mt-5 ">
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
            </div>
            <div className="mb-4 mt-5 ml-5">
              <Link
                className="cursor-pointer block font-semibold hover:underline"
                to={`/UserProfileView/${post.user_id}`}
              >
                {capitalize(post.author)}
              </Link>
              <TimeFormatComponent timestamp={[post.createdAt]} />
            </div>
          </div>
        </div>
        <div className="mb-4 mt-5">
          <label htmlFor="Title" className="block font-semibold">
            Title
          </label>
          <h1 className="text-gray-700 pl-3">{capitalize(post.title)}</h1>
          <h1 className="block font-semibold mt-5">Quantity</h1>

          <h1 className="text-gray-700 pl-3">{post.quantity}</h1>
        </div>
        <div className="mb-4">
          <h1 className="block font-semibold mt-5 ">Category</h1>
          <div className="px-3 py-2 mx-2 bg-green-900 w-fit rounded-xl">
            <p className="text-base text-white text-justify">{post.category}</p>
          </div>
        </div>
        <div className="mb-4 flex justify-between">
          <div>
            <label htmlFor="UploadTime" className="block font-semibold">
              Post uploadTime
            </label>
            <h1 className="text-gray-700 pl-3">
              {post.availableTime.startTime}
            </h1>
          </div>
          <div className="mr-3">
            <label htmlFor="EndTime" className="block font-semibold">
              Post end time
            </label>
            <h1 className="text-gray-700 pl-3 ">
              {" "}
              {post.availableTime.endTime}
            </h1>
          </div>
        </div>
        <div className="mb-4">
          <label htmlFor="Description" className="block font-semibold">
            Post description
          </label>
          <p className="text-gray-700 pl-3 text-justify">{post.description}</p>
        </div>

        <div className="flex justify-between">
          <div className="mb-4">
            <RequestRow requestIds={post.requests} title={"Requests"} />
          </div>
          <div className="mb-4">
            <RequestRow
              requestIds={post.acceptRequests}
              title={"Accepted Request"}
            />
          </div>
        </div>
      </div>
    );
  };

  return (
    <>
      <Slideshow />
      <div className="w-1/2 pl-4">
        <div className="flex w-full h-full justify-end">
          <IconButton
            aria-label="settings"
            className="rounded-lg"
            onClick={handleMoreVertClick}
            ref={anchorEl}
          >
            <MoreVertIcon />
          </IconButton>

          <Popover
            id={popoverId}
            open={openMoreVert}
            anchorEl={anchorEl}
            onClose={handleMoreVertClose}
            anchorOrigin={{
              vertical: "bottom",
              horizontal: "right",
            }}
            transformOrigin={{
              vertical: "top",
              horizontal: "right",
            }}
          >
            <Button
              className="text-black rounded-xl"
              onClick={handleDeleteButtonClick}
            >
              Delete
            </Button>
          </Popover>
        </div>
        <DetailsSection />

        {deleteConfirmationVisible && (
          <DeleteModal
            onClose={() => setDeleteConfirmationVisible(false)}
            onDelete={async () => await _deleteFood()}
          />
        )}
        <Snackbar
          open={snackbarOpen}
          autoHideDuration={3000}
          onClose={handleSnackbarClose}
        >
          <Alert onClose={handleSnackbarClose} severity="success">
            Food post deleted successfully!
          </Alert>
        </Snackbar>
      </div>
    </>
  );
};
