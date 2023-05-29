<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

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

            .button-purple {
                background-color: #FF80FF;
            }

            .button-container button:hover {
                opacity: 0.8;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                padding: 12px 16px;
                z-index: 1;
            }

            .dropdown:hover .dropdown-content {
                display: block;
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
        <h1>Bienvenido, <%= session.getAttribute("username") %>🧑</h1>
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
            <button class="button-blue" onclick="location.href = 'marcar.jsp'">Marcajes</button>
            <button class="button-green" onclick="location.href = 'informacion_empresa.jsp'">Información de la empresa</button>
            <div class="dropdown">
                <button class="button-purple">Información de usuario</button>
                <div class="dropdown-content">
                    <%
                        String username = (String) session.getAttribute("username");
                        String url = "jdbc:mysql://localhost:3333/rrhh";
                        String usuarioBD = "root";
                        String contrasenaBD = "";

                        Connection conn = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                            String query = "SELECT * FROM usuarios WHERE id_user = ?";
                            ps = conn.prepareStatement(query);
                            ps.setString(1, String.valueOf(session.getAttribute("id_user")));
                            rs = ps.executeQuery();

                            while(rs.next()){
                                out.println("<strong>ID: </strong>" + rs.getString("id_user") + "<br>");
                                out.println("<strong>Nombre: </strong>" + rs.getString("nombre") + "<br>");
                                out.println("<strong>Apellidos: </strong>" + rs.getString("apellidos") + "<br>");
                                out.println("<strong>Username: </strong>" + rs.getString("username") + "<br>");
                            }

                        } catch(Exception e) {
                            e.printStackTrace();
                        } finally {
                            if(rs != null) try { rs.close(); } catch(SQLException e) {}
                            if(ps != null) try { ps.close(); } catch(SQLException e) {}
                            if(conn != null) try { conn.close(); } catch(SQLException e) {}
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>
