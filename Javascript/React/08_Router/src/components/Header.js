import React from "react";
import { useDispatch, useSelector } from "react-redux";
import { selectCurrentUser, logOut } from "../features/session/sessionSlice";

// Import the NavLink component.

import { NavLink } from 'react-router-dom';

export default function Header () {
  const currentUser = useSelector(selectCurrentUser);
  const dispatch = useDispatch();

  const handleLogout = e => {
    dispatch(logOut())
  }

  // Replace the 4 <a> tags with <NavLink> components
  return (
    <div className="header">
      <NavLink to="/about">About</NavLink>
      <NavLink to="/articles">Articles</NavLink> 
      <NavLink to="/categories">Categories</NavLink>
      {
        currentUser.username ?
          <>
            <a href="/profile">Profile</a>
            <button onClick={handleLogout} className="logout"> Log Out </button>
          </> : 
          <a href="/sign-up">Sign Up</a>
      }
    </div>
  )
}
