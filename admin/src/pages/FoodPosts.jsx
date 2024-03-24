import React, { useEffect } from "react";
import { Layout } from "../components";
import { FoodPost } from "../components/foodPost/FoodPost";
import { useFetchData } from "../hooks/useFetchData";
import { CircularProgress } from "@mui/material";
import AnimationNoData from "../utils/Animation";
const FoodPosts = () => {
  const { error, fetchData, data, isLoading } = useFetchData("foods");

  const handleFoodDelete = () => {
    _getFoods();
  };

  useEffect(() => {
    _getFoods();
  }, []);

  const _getFoods = async () => {
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
          <AnimationNoData/>
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
      <div className="flex-col place-content-center">
        {data.map((post) => (
          <div className="mb-4" key={post.id}>
            <div className=" shadow-xl rounded-xl justify-center items-center flex p-2">
              <FoodPost post={post} onFoodDelete={handleFoodDelete} />
            </div>
          </div>
        ))}
      </div>
    </Layout>
  );
};

export default FoodPosts;
