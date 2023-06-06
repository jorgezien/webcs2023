<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%  
    String username = (String)session.getAttribute("username");
    String id_user = (String)session.getAttribute("id_user");
    if(username == null || id_user == null){
        response.sendRedirect("error_autenticacion.jsp"); // Redirigir a la página de error
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Dashboard</title>
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

            table {
                width: 80%;   /* Change to suit your needs */
                border-collapse: collapse;
                margin: 20px auto; /* This will center the table */
                margin-bottom: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #f2f2f2;
                font-weight: bold;
            }

            .back-button {
                position: absolute;
                top: 10px;
                left: 10px;
                background-color: #4285f4;
                color: #ffffff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
            }

            .back-button:hover {
                opacity: 0.8;
            }

            .form-container {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
                background-color: #ffffff;
                border: 1px solid #ddd;
                border-radius: 4px;
            }

            .form-container input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .form-container input[type="submit"] {
                background-color: #4285f4;
                color: #ffffff;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 4px;
            }

            .form-container input[type="submit"]:hover {
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <button onclick="history.go(-1)" class="back-button">Atrás</button>

        <h1>Dashboard</h1>
        <h1>Bienvenido, <%= session.getAttribute("username") %></h1>
        <table>
            <tr>
                <th>Nombre Empresa</th>
                <th>Nombre Proyecto</th>
                <th>ID Usuario</th>
                <th>Usuario</th>
            </tr>
            <%!
            String url = "jdbc:mysql://localhost:3306/rrhh";
            String usuarioBD = "root";
            String contrasenaBD = "webcs";
            %>
            <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                // Tomar información de los trabajadores
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                String query = "SELECT empresa.nombre_empresa, proyectos.nombre AS nombre_proyecto, usuarios.id_user AS id_usuario, usuarios.username AS usuario " +
                               "FROM empresa " +
                               "INNER JOIN proyectos ON empresa.id_empresa = proyectos.id_empresa " +
                               "INNER JOIN usuarios_proyectos ON proyectos.id_proyecto = usuarios_proyectos.id_proyecto " +
                               "INNER JOIN usuarios ON usuarios_proyectos.id_user = usuarios.id_user ";
                              
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String nombre_empresa = rs.getString("nombre_empresa");
                    String nombre_proyecto = rs.getString("nombre_proyecto");
                    int id_usuario = rs.getInt("id_usuario");
                    String usuario = rs.getString("usuario");
            %>
            <tr>
                <td><%= nombre_empresa %></td>
                <td><%= nombre_proyecto %></td>
                <td><%= id_usuario %></td>
                <td><%= usuario %></td>
            </tr>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
            %>
        </table>

        <div class="form-container">
            <h2>Asignar Proyecto</h2>
            <form action="AsignarProyecto" method="POST">
                <label for="workerId">ID de Trabajador:</label>
                <input type="text" id="trabajadorId" name="workerId" required><br>

                <label for="projectId">ID del Proyecto:</label>
                <input type="text" id="proyectoId" name="projectId" required><br>

                <input type="submit" value="Asignar Proyecto">
            </form>
        </div>
    </body>
</html>
