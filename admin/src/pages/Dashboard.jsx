// Dashboard.js
import React, { useEffect } from "react";
import { Layout, LineChart} from "../components";
import Card from "../components/Card";
import {PieChart} from "../components";
import { useFetchData } from "../hooks/useFetchData";


const Dashboard = () => {
  const stats = [];
  const {
    error,
    fetchData: fetchForumsData,
    data: forumsData,
    isLoading: isForumsLoading,
  } = useFetchData("forums");
  const {
    error: foodError,
    fetchData: fetchFoodsData,
    data: foodsData,
    isLoading: isFoodsLoading,
  } = useFetchData("foods");

  const {
    error: userError,
    fetchData: fetchAllUsers,
    data: allUsers,
    isLoading: userIsLoading,
  } = useFetchData("allUsers");

  useEffect(() => {
    _getFormus();
  }, []);

  const _getFormus = async () => {
    await fetchForumsData();
    await fetchFoodsData();
    await fetchAllUsers();
  };

  return (
    <>
      <Layout>
      
        <div className=" gap-4 ">
          {/* Cards */}
          <Card community={forumsData.length} food={foodsData.length} users={allUsers.length} />
          {/* Add more cards here as needed */}
          
          {/* Line Chart */}
          <div className=" flex mt-8">
            <LineChart />
           <PieChart community={forumsData.length} food={foodsData.length} users={allUsers.length}/>
          </div>
        </div>
        
      </Layout>
    </>
  );
};

export default Dashboard;
