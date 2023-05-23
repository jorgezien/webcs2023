<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Bienvenido</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 20px;
            }

            h1 {
                text-align: center;
                margin-top: 0;
            }
            h3 {
                text-align: center;
                margin-top: 0;
            }

            .button-container {
                display: flex;
                justify-content: center;
                margin-top: 50px;
            }

            .button-container button {
                margin: 0 10px;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                color: #fff;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .button-blue {
                background-color: #70a1ff;
            }

            .button-green {
                background-color: #63cdda;
            }

            .button-red {
                background-color: #ff6b6b;
            }

            .button-purple {
                background-color: #FF80FF;
            }

            .button-container button:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <h1>Bienvenido, <%= session.getAttribute("username") %>🧑</h1>
        <h3>ID: <%= session.getAttribute("id_user") %></h3>

        <div class="button-container">
            <button class="button-blue" onclick="location.href = 'marcar.jsp'">Marcajes</button>
            <button class="button-green" onclick="location.href = 'informacion_empresa.jsp'">Información de la empresa</button>
        </div>
    </body>
</html>