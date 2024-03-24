import React, { useContext, useEffect, useState } from "react";
import Box from "@mui/material/Box";
import Alert from "@mui/material/Alert";
import IconButton from "@mui/material/IconButton";
import Collapse from "@mui/material/Collapse";
import CloseIcon from "@mui/icons-material/Close";
import { AuthContext } from "../../contexts/authContext/AuthContext";

export default function ErrorModal() {
  const { error } = useContext(AuthContext);
  
  // State to manage the visibility of the modal
  const [open, setOpen] = useState(false);

  // Whenever the 'error' changes, reset the 'open' state
  useEffect(() => {
    setOpen(!!error); // Set 'open' to true if 'error' is truthy
  }, [error]);

  return (
    <div className={`${error ? "block" : "hidden"}`}>
      <Box sx={{ width: "100%" }}>
        <Collapse in={open}>
          <Alert
            severity="error"
            action={
              <IconButton
                aria-label="close"
                color="error"
                size="small"
                onClick={() => {
                  setOpen(false);
                }}
              >
                <CloseIcon fontSize="inherit" />
              </IconButton>
            }
            sx={{ mb: 2 }}
          >
            Invalid Email or Password!
          </Alert>
        </Collapse>
      </Box>
    </div>
  );
}
