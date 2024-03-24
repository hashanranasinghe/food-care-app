// Dashboard.js
import React from "react";
import { Layout } from "../components";
import { FoodPost } from "../components/foodPost/FoodPost";
import { useLocation } from "react-router-dom";
import RecipeReviewCard from "../components/Post";
export default function PostView() {
  const location = useLocation();
  return (
    <>
      <Layout>
        <div className="flex-col place-content-center h-">
          <div className="mb-4">
            <div className=" shadow-xl rounded-xl justify-center items-center flex p-2c">
              {location.state.type === "FOOD" ? (
                <FoodPost post={location.state.dataFood} />
              ) : (
                <RecipeReviewCard forum={location.state.dataFood} />
              )}
            </div>
          </div>
        </div>
      </Layout>
    </>
  );
}
