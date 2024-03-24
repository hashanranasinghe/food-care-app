import React from "react";
import {
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  Button,
} from "@mui/material";
function DeleteModal({ onClose,onDelete }) {
  const [deleteConfirmationVisible, setDeleteConfirmationVisible] =
    React.useState(false);
  const handleDeleteCancel = () => {
    setDeleteConfirmationVisible(false);
  };

  const handleDeleteConfirm = () => {
    onDelete();
    setDeleteConfirmationVisible(false);
  };

  return (
    <Dialog open={true} onClose={handleDeleteCancel}>
      <DialogTitle>Are you sure you want to delete this Feedback?</DialogTitle>
      <DialogContent>
        {/* You can add more content to the dialog if needed */}
      </DialogContent>
      <DialogActions>
        <Button onClick={onClose} color="primary">
          Cancel
        </Button>
        <Button
          onClick={() => {
            // onDeleteClick();
            handleDeleteConfirm();
          }}
          color="secondary"
        >
          Delete
        </Button>
      </DialogActions>
    </Dialog>
  );
}

export default DeleteModal;
