import * as React from "react";
import Button from "@mui/material/Button";
import Menu from "@mui/material/Menu";
import RequestItem from "./RequestItem";
import ArrowDropDownCircleIcon from "@mui/icons-material/ArrowDropDownCircle";
export default function RequestRow({ title, requestIds }) {
  const [anchorEl, setAnchorEl] = React.useState(null);
  const open = Boolean(anchorEl);
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  const handleClose = () => {
    setAnchorEl(null);
  };
  const Request = ({ requestId, index }) => {
    console.log(requestId);
    return <RequestItem handleClose={handleClose} requestId={requestId} />;
  };
  return (
    <div>
      <Button
        id="basic-button"
        aria-controls={open ? "basic-menu" : undefined}
        aria-haspopup="true"
        aria-expanded={open ? "true" : undefined}
        onClick={handleClick}
      >
        <div className="flex gap-2">
          <p className="text-black font-semibold">{title}</p>
          <ArrowDropDownCircleIcon style={{ color: '#000000' }}/>
        </div>
      </Button>
      <Menu
        id="basic-menu"
        anchorEl={anchorEl}
        open={open}
        onClose={handleClose}
        MenuListProps={{
          "aria-labelledby": "basic-button",
        }}
      >
        {requestIds.map((requestId, index) => (
          <Request requestId={requestId} />
        ))}
      </Menu>
    </div>
  );
}
