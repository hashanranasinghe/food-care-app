import React, { useContext } from "react";
import {
  Dialog,
  DialogHeader,
  DialogBody,
  DialogFooter,
} from "@material-tailwind/react";
import { AuthContext } from "../../contexts/authContext/AuthContext";
import { logout } from "../../contexts/authContext/AuthActions";
export function SignoutModal({ onClose }) {
  const { dispatch } = useContext(AuthContext);
  return (
    <Dialog
      open={true} // Since this modal is controlled from the Navbar, always keep it open
      animate={{
        mount: { scale: 1, y: 0 },
        unmount: { scale: 0.9, y: -100 },
      }}
    >
      <DialogHeader>Sign Out</DialogHeader>
      <DialogBody>Are you sure you want to sign out?</DialogBody>
      <DialogFooter>
        <div className="flex justify-end gap-5">

        <button
          onClick={onClose}
          className="px-4 py-2 text-sm text-gray-700 bg-gray-200 rounded-md hover:bg-gray-400"
          >
          Cancel
        </button>
        <a
          onClick={() => {
              localStorage.removeItem("user");
              dispatch(logout());
            }}
            href="/"
            className="px-4 py-2 text-sm text-white bg-red-400 rounded-md hover:bg-red-600"
            >
          Sign out
        </a>
            </div>
      </DialogFooter>
    </Dialog>
  );
}
