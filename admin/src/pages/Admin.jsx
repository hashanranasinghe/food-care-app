 import React from 'react';
import Layout from "../components/Layout";
import AdminCard from '../components/AdminCard';

const Admin = () => {
  const adminsData = [
    {
      name: "Chathura Janaka",
      email: "chathura@example.com",
      phoneNumber: "123-456-7890",
      address: "123 Main Street, City, Country",
    },
    {
      name: "Hashan ",
      email: "hashan@example.com",
      phoneNumber: "222-456-7890",
      address: "123 Main Street, City, Kandy",
    },
    // Add more admins as needed
    {
      name: "John Doe",
      email: "john.doe@example.com",
      phoneNumber: "555-123-4567",
      address: "456 Elm Street, Town, Country",
    },
    // Add more admins as needed
  ];

  return (
    <Layout>
      {adminsData.map((admin, index) => (
        <AdminCard key={index} admins={[admin]} />
      ))}
    </Layout>
  );
};

export default Admin;

