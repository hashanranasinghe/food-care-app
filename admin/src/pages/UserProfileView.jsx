import { useParams } from "react-router-dom";
import User from "../assests/user.png";
import { Layout } from "../components";
import { useFetchIdData } from "../hooks/useFetchIdData";
import { useEffect } from "react";
import { CircularProgress } from "@mui/material";
import { useFetchData } from "../hooks/useFetchData";
import { useState } from "react";
import { imageUrl } from "../utils/imageUrl";

export default function UserProfileView() {
  const { id } = useParams();
  const [forumCount, setForumCount] = useState(0);
  const [foodCount, setFoodCount] = useState(0);
  const {
    error: userError,
    fetchData: fetchUser,
    data: userData,
    isLoading: userIsLoading,
  } = useFetchIdData("user", id);

  const {
    error: forumError,
    fetchData: fetchForumsData,
    data: forumsData,
    isLoading: isForumsLoading,
  } = useFetchData("forums");
  const {
    error: foodError,
    fetchData: fetchFoodData,
    data: foodsData,
    isLoading: isFoodsLoading,
  } = useFetchData("foods");

  const _getUser = async () => {
    await fetchUser();
  };
  const _getForums = async () => {
    await fetchForumsData();
  };
  const _getFoods = async () => {
    await fetchFoodData();
  };
  const _getForumCount = async () => {
    const filteredForums = forumsData.filter((forum) => forum.user_id === id);
    setForumCount(filteredForums.length);
  };
  const _getFoodCount = async () => {
    const filteredFoods = foodsData.filter((food) => food.user_id === id);
    setFoodCount(filteredFoods.length);
  };

  useEffect(() => {
    _getUser();
    _getForums();
    _getFoods();
    _getFoodCount();
  }, []);

  useEffect(() => {
    _getForumCount();
  }, [forumsData]);

  useEffect(() => {
    _getFoodCount();
  }, [foodsData]);

  if (userIsLoading) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <CircularProgress />
        </div>
      </Layout>
    );
  }

  if (userError) {
    return (
      <Layout>
        <div className="flex flex-col items-center w-full justify-center">
          <p>{userError}</p>
        </div>
      </Layout>
    );
  }

  return (
    <Layout>
      <div className="w-full mx-auto px-20">
        <div className="flex flex-wrap justify-center mt-20 bg-gray-50 shadow-xl rounded-lg pb-10">
          {/* First Column */}
          <div className="w-full lg:w-4/12 px-4 lg:order-1">
            <div className="flex justify-center py-4 lg:pt-4 pt-8">
              <div className="mr-4 p-3 text-center">
                <span className="text-xl font-bold block text-gray-700">
                  {forumCount}
                </span>
                <span className="text-sm text-gray-500">Community</span>
              </div>
              <div className="mr-4 p-3 text-center">
                <span className="text-xl font-bold block text-gray-700">
                  {foodCount}
                </span>
                <span className="text-sm text-gray-500">Food Posts</span>
              </div>
            </div>
            <div className="flex justify-center py-4 lg:pt-4 pt-8">
              <div className="mr-4 p-3 text-center">
                <span className="text-xl font-bold block text-gray-700">
                  {userData?.deviceToken.length}
                </span>
                <span className="text-sm text-gray-500">Device count</span>
              </div>
            </div>
          </div>

          {/* Middle Column */}
          <div className="lg:w-4/12 lg:order-2 flex justify-center flex-col items-center relative">
            <div className="absolute -top-16">
              {userData?.imageUrl ? (
                <img
                  src={imageUrl() + userData.imageUrl}
                  alt={`${userData?.name}'s Profile`}
                  className="shadow-xl rounded-full h-[150px] w-[150px] object-cover"
                />
              ) : (
                <img
                  src={User} // Replace this with the correct path to user.png
                  alt={`${userData?.name}'s Profile`}
                  className="shadow-xl rounded-full h-[150px] w-[150px] object-cover"
                />
              )}
            </div>
            {/* Profile Information */}
            <div className="text-center  mt-20">
             
              <h3 className="text-4xl uppercase font-semibold leading-normal text-gray-800 mb-2">
                {userData?.name}
              </h3>
              <div className="text-sm leading-normal mt-0 text-gray-500 font-bold uppercase">
                <i className="fas fa-map-marker-alt mr-2 text-lg text-gray-500"></i>{" "}
                {userData?.address}
              </div>
              <div className="text-gray-700 pt-5">{userData?.email}</div>
              <div className="text-gray-700">
                <i className="fas fa-university mr-2 text-lg text-gray-500"></i>
                {userData?.phone}
              </div>
            </div>
          </div>

        
          {/* Last Column */}
          <div className="w-full h-full lg:w-4/12 px-4 lg:order-3 flex flex-col justify-between lg:self-start">
            <div className="pt-5 flex flex-col ">
            {userData?.isVerify ? <button
                className="bg-green-600 uppercase text-white font-bold  shadow text-xs px-4 py-2 mb-10 rounded outline-none focus:outline-none"
                type="button"
                style={{ transition: "all .15s ease" }}
              >
                Verified
              </button>: <button
                className="bg-green-600 uppercase text-white font-bold  shadow text-xs px-4 py-2 rounded outline-none focus:outline-none pb-10"
                type="button"
                style={{ transition: "all .15s ease" }}
              >
                Not verified
              </button>}
              <button
                className="bg-blue-300 hover:bg-blue-600 uppercase text-white font-bold hover:shadow-md shadow text-xs px-4 py-2 rounded outline-none focus:outline-none"
                type="button"
                style={{ transition: "all .15s ease" }}
              >
                Contact
              </button>
              
              
            </div>
          </div>
        </div>
      </div>
    </Layout>
  );
}
