<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Usuario" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Registro</title>
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
            input[type="date"] { /* Agregamos la regla para los campos de tipo date */
                width: 100%;
                padding: 10px;
                border: 2px solid #b2b2b2;
                background-color: #fff;
                border-radius: 4px;
                box-sizing: border-box;
                color: black;
            }

            .error-message {
                color: red;
                margin-top: 10px;
            }

        </style>
    </head>
    <body>
        <h1>Registro 🚀</h1>
        <form action="RegisterProcess" method="post">
            <label for="username">Nombre de usuario</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required>
            <!-- otros campos -->
            <label for="dni">DNI</label>
            <input type="text" id="dni" name="dni" required>
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" required>
            <label for="apellidos">Apellidos</label>
            <input type="text" id="apellidos" name="apellidos" required>
            <label for="fecha_alta">Fecha de alta</label>
            <input type="date" id="fecha_alta" name="fecha_alta" required>
            <label for="fecha_baja">Fecha de baja</label>
            <input type="date" id="fecha_baja" name="fecha_baja">
            <label for="tipo_usuario">Tipo de usuario</label>
            <select id="tipo_usuario" name="tipo_usuario" required>
                <option value="A">A</option>
                <option value="U">U</option>
            </select>

            <input  type="submit" value="Registrarse">
        </form>
    </body>
</html>
