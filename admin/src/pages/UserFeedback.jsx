import React, { useEffect } from "react";
import { Layout } from "../components";
import FeedbackCard from "../components/FeedbackCard";
import CircularProgress from "@mui/material/CircularProgress";
import { useFetchData } from "../hooks/useFetchData";
import AnimationNoData from "../utils/Animation";

export default function UserFeedback() {
  const { error, fetchData, data, isLoading } = useFetchData("reports");

  useEffect(() => {
    _getReports();
  }, []);
  const _getReports = async () => {
    await fetchData();
  };

  const handleReportDelete = () => {
    _getReports();
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
      <div>
        {data.map((report) => (
          <FeedbackCard
            className="shadow-2xl"
            report={report}
            onReportDelete={handleReportDelete}
          />
        ))}
      </div>
    </Layout>
  );
}
