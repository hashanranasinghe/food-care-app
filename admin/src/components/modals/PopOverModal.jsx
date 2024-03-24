import React, { useState } from "react";
import MoreVertIcon from "@mui/icons-material/MoreVert";
import Popover from "@mui/material/Popover";
import { Button } from "@mui/material";
import IconButton from "@mui/material/IconButton";
export default function PopOverModal({ onDelete }) {
  const [anchorEl, setAnchorEl] = useState(null);
  const handleMoreVertClick = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMoreVertClose = () => {
    setAnchorEl(null);
  };

  const openMoreVert = Boolean(anchorEl);

  const popoverId = openMoreVert ? "simple-popover" : undefined;

  const handleDeleteButtonClick = () => {
    onDelete();
    handleMoreVertClose();
  };

  return (
    <>
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
    </>
  );
}
