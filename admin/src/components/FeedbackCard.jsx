import React, { useEffect, useState } from "react";
import { styled } from "@mui/material/styles";
import Card from "@mui/material/Card";
import CardHeader from "@mui/material/CardHeader";
import CardContent from "@mui/material/CardContent";
import Avatar from "@mui/material/Avatar";
import Typography from "@mui/material/Typography";
import MoreVertOutlinedIcon from "@mui/icons-material/MoreVertOutlined";
import IconButton from "@mui/material/IconButton";
import User from "../assests/user.png";
import { Button, capitalize } from "@mui/material";
import { useFetchIdData } from "../hooks/useFetchIdData";
import TimeFormatComponent from "../utils/convertor";
import Checkbox from "@mui/material/Checkbox";
import useFetchFunction from "../hooks/useFetchFunction";
import Popover from "@mui/material/Popover";
import Snackbar from "@mui/material/Snackbar";
import Alert from "@mui/material/Alert";
import DeleteModal from "./modals/DeleteModal";
import {Link, useNavigate} from 'react-router-dom';

const StyledCard = styled(Card)({
  maxWidth: 1600,
  width: 1000,
  maxHeight: 200,
  height: 150,
  marginLeft: 5,
  marginRight: 5,
  marginBottom: 20,
});

export default function FeedbackCard({ report, onReportDelete }) {
  const navigate = useNavigate();
  const [checked, setChecked] = React.useState(
    report.action == "YES" ? true : false
  );
  const { error, fetchData, data, isLoading } = useFetchIdData(
    "user",
    report.user_id
  );
  const { error:errorFood, fetchData:fetchFood, data:dataFood, isLoading:foodIsLoading } = useFetchIdData(
    "getfoodpost",
    report.post.id
  );
  const { error:errorForum, fetchData:fetchForum, data:dataForum, isLoading:forumIsLoading } = useFetchIdData(
    "getforumpost",
    report.post.id
  );
  const [anchorEl, setAnchorEl] = useState(null);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const { fetchFunction: fetchDelete } = useFetchFunction(
    "updateReport",
    report._id,
    "DELETE"
  );
  const { fetchFunction: fetchUpdate } = useFetchFunction(
    "updateReport",
    report._id,
    "PUT"
  );
const _getPost = async() =>{
  if(report.post.type === "FOOD"){
    await fetchFood();
  }else{
    await fetchForum();
  }
 
}
  const _update = async () => {
    await fetchUpdate();
  };
  const handleChange = (event) => {
    _update();
    setChecked(event.target.checked);
    console.log(checked);
  };
  useEffect(() => {
    _getUser();
    _getPost();
  }, []);

  const _getUser = async () => {
    await fetchData();
  };
  const _deleteReport = async () => {
    await fetchDelete();
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
    onReportDelete();
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
  const handleGoToPost = () => {
    
    navigate('/postview',{state:{dataFood:dataFood,type:report.post.type}});
    console.log(report.post.type);
  };
  return (
    <div>
      <StyledCard>
        <CardHeader
          avatar={
            <Avatar aria-label="feedback">
              {data?.imageUrl ? (
                <img
                  src={data?.imageUrl}
                  alt={`${data?.name}'s Profile`}
                  className="h-10 w-10 rounded-full object-cover"
                />
              ) : (
                <img
                  src={User}
                  alt={`${data?.name}'s Profile`}
                  className="h-10 w-10 rounded-full object-cover"
                />
              )}
            </Avatar>
          }
          action={
            <React.Fragment>
              <div className="flex items-center">
                <Button
                  className="text-black rounded-xl"
                  onClick={handleGoToPost} // Use the new handler
                >
                  Go to Post
                </Button>
                <Checkbox checked={checked} onChange={handleChange} />
                {checked ? <p className="text-green-700">Complete Action</p> : <p>Need a Action</p>}
                <IconButton aria-label="options">
                  <MoreVertOutlinedIcon onClick={handleMoreVertClick} />
                </IconButton>
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
            </React.Fragment>
          }
          title={
            <Link
              className="cursor-pointer block font-semibold hover:underline"
              to={`/UserProfileView/${report.user_id}`}
            >
              {data?.name}
            </Link>
          }
          subheader={<TimeFormatComponent timestamp={[report.createdAt]} />}
        />
        <CardContent>
          <Typography variant="body2" color="text.secondary">
            {report.description}
          </Typography>
        </CardContent>
      </StyledCard>
      {deleteConfirmationVisible && (
        <DeleteModal
          onClose={() => setDeleteConfirmationVisible(false)}
          onDelete={async () => await _deleteReport()}
        />
      )}

      <Snackbar
        open={snackbarOpen}
        autoHideDuration={3000}
        onClose={handleSnackbarClose}
      >
        <Alert onClose={handleSnackbarClose} severity="success">
          Report deleted successfully!
        </Alert>
      </Snackbar>
    </div>
  );
}
