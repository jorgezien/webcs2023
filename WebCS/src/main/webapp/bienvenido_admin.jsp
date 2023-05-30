<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String username = (String)session.getAttribute("username");
    String id_user = (String)session.getAttribute("id_user");
    if(username == null || id_user == null){
        response.sendRedirect("error.jsp"); // Redirigir a la página de error
        return;
    }
%>
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
            h3 {
                text-align: center;
                margin-top: 0;
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
            .logout-button {
                position: absolute;
                top: 10px;
                left: 10px;
                padding: 10px 20px;
                font-size: 16px;
                font-weight: bold;
                color: #fff;
                background-color: #ff4d4d;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
            }

            .logout-button:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <h1>Bienvenido, <%= session.getAttribute("username") %>👨‍🏭</h1>
        <h3>ID: <%= session.getAttribute("id_user") %></h3>
        <a class="logout-button" href="#" onclick="confirmLogout()">Cerrar sesión</a>

        <script>
            function confirmLogout() {
                var logout = confirm("¿Estás seguro de que quieres cerrar la sesión?");
                if (logout) {
                    window.location.href = "LogoutProcess";
                }
            }
        </script>
        <div class="button-container">
            <button class="button-blue" onclick="location.href = 'empresas.jsp'">Empresas</button>
            <button class="button-green" onclick="location.href = 'proyectos.jsp'">Proyectos</button>
            <button class="button-red" onclick="location.href = 'trabajadores.jsp'">Trabajadores</button>
            <button class="button-red" onclick="location.href = 'informacion_trabajadores.jsp'">Trabajadores y Proyectos</button>
            <button class="button-purple" onclick="location.href = 'marcajes.jsp'">Marcajes</button>
        </div>
    </body>
</html>
