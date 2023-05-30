<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Marcaje" %>
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
        <title>Marcajes</title>
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
                width: 100%;
                border-collapse: collapse;
                margin: 0 auto;
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

            .delete-button {
                background-color: #ff6b6b;
                color: #ffffff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
            }

            .delete-button:hover {
                opacity: 0.8;
            }

            .delete-button-container {
                text-align: right;
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
        </style>
    </head>
    <body>
        <a href="http://localhost:8080/WebCS/bienvenido_admin.jsp" class="back-button">Atrás</a>
        <h1>Marcajes</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Tipo de Marcaje</th>
                <th>ID de Usuario</th>
            </tr>
            <%!
            // Datos de conexión a la base de datos
            String url = "jdbc:mysql://localhost:3333/rrhh";
            String usuarioBD = "root";
            String contrasenaBD = "";
            %>
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs_marcaje = null;
            PreparedStatement ps_delete_marcaje = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                stmt = conn.createStatement();
                String query_marcaje = "SELECT * FROM marcajes";

                rs_marcaje = stmt.executeQuery(query_marcaje);

                while (rs_marcaje.next()) {
                    int id = rs_marcaje.getInt("id");
                    Timestamp timestamp = rs_marcaje.getTimestamp("fecha");
                    Date fecha = new Date(timestamp.getTime());
                    Time hora = new Time(timestamp.getTime());
                    
                    char tipo_marcaje = rs_marcaje.getString("tipo_marcaje").charAt(0);
                    int id_usuario = rs_marcaje.getInt("id_usuario");

                    Marcaje marcaje = new Marcaje(id, fecha, tipo_marcaje, id_usuario);
            %>
            <tr>
                <td><%= marcaje.getId() %></td>
                <td><%= marcaje.getFecha() %></td>
                <td><%= hora %></td>
                <td><%= marcaje.getTipo_marcaje() %></td>
                <td><%= marcaje.getId_usuario() %></td>

            </tr>
            <%
            }

            // ... (Código para eliminar y añadir marcajes) ...

            } catch (Exception e) {
                e.printStackTrace();
                // Manejo de errores
            } finally {
                // ... (Código para liberar recursos) ...
            }
            %>

        </table>
    </body>
</html>
