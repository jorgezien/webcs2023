<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      padding: 0;
      background-color: #f2f2f2;
    }
    
    h1 {
      text-align: center;
      margin-top: 50px;
    }
    
    form {
      max-width: 300px;
      margin: 50px auto;
      padding: 20px;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    }
    
    label {
      display: block;
      margin-bottom: 10px;
      font-weight: bold;
    }
    
    input[type="text"],
    input[type="password"] {
      width: 100%;
      padding: 10px;
      border: 2px solid #b2b2b2;
      background-color: #fff;
      border-radius: 4px;
      box-sizing: border-box;
      color: black;
    }
    
    input {
      width: 100%;
      padding: 10px;
      padding-top: 10px;
      
      background-color: #4CAF50;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
    }

    input[type="submit"] {
      margin-top: 15px;
    }

    
    
    input[type="submit"]:hover {
      background-color: #45a049;
    }
    
    .error-message {
      color: red;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <h1>Login</h1>
  <form action="LoginProcess" method="post">
    <label for="username">Username</label>
    <input type="text" id="username" name="username" required>
    <label for="password">Password</label>
    <input type="password" id="password" name="password" required>
    <input  type="submit" value="Log in">
  </form>
</body>
</html>
