import React, { useEffect } from "react";
import { Layout } from "../components";
import Post from "../components/Post";
import CircularProgress from "@mui/material/CircularProgress"; // Import CircularProgress
import { useFetchData } from "../hooks/useFetchData";
import AnimationNoData from "../utils/Animation";

const Community = () => {
  const { error, fetchData, data, isLoading } = useFetchData("forums");

  const handleForumDelete = () => {
    _getFormus();
  };

  useEffect(() => {
    _getFormus();
  }, []);

  const _getFormus = async () => {
    await fetchData();
  };

  if (isLoading) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <CircularProgress />
        </div>
      </Layout>
    );
  }

  if (data.length === 0) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <AnimationNoData />
        </div>
      </Layout>
    );
  }

  if (error) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <p>{error}</p>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="flex flex-col items-center">
        {data.map((forum, index) => (
          <Post forum={forum} key={index} onForumDelete={handleForumDelete} /> // Added key prop
        ))}
      </div>
    </Layout>
  );
};

export default Community;
