import MenuItem from "@mui/material/MenuItem";
import React, { useEffect } from "react";
import { useFetchIdData } from "../../hooks/useFetchIdData";
import CircularProgress from "@mui/material/CircularProgress";
export default function RequestItem({ handleClose, requestId }) {
  const { error, fetchData, data, isLoading } = useFetchIdData(
    "user",
    requestId
  );

  useEffect(() => {
    _getUser();
  }, []);
  const _getUser = async () => {
    await fetchData();
  };

  if (isLoading) {
    return (
      <MenuItem onClick={handleClose}>
        <CircularProgress />
      </MenuItem>
    );
  }
  if (error) {
    return <p>Error: {error.message}</p>;
  }
  return <MenuItem onClick={handleClose}>{data?.name}</MenuItem>;
}
