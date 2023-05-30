<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Usuario" %>
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
        <title>Trabajadores</title>
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
        <h1>Trabajadores</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Nombre de usuario</th>
                <th>DNI</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Fecha de alta</th>
                <th>Fecha de baja</th>
                <th>Tipo de usuario</th>
                <th>Acciones</th>
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
            ResultSet rs_usuario = null;
            PreparedStatement ps_delete_usuario = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                stmt = conn.createStatement();
                String query_usuario = "SELECT * FROM usuarios";

                rs_usuario = stmt.executeQuery(query_usuario);

                while (rs_usuario.next()) {
                    int id = rs_usuario.getInt("id_user");
                    String username_ = rs_usuario.getString("username");
                    String dni = rs_usuario.getString("dni");
                    String nombre = rs_usuario.getString("nombre");
                    String password = rs_usuario.getString("password");
                    String apellidos = rs_usuario.getString("apellidos");
                    String fecha_alta = rs_usuario.getString("fecha_alta");
                    String fecha_baja = rs_usuario.getString("fecha_baja");
                    String tipo_usuario = rs_usuario.getString("tipo_usuario");
                    
                    // Reemplazar valores "null" por "No determinado"
                    if (fecha_alta == null) {
                        fecha_alta = "No determinado";
                    }
                    if (fecha_baja == null) {
                        fecha_baja = "No determinado";
                    }
                    
                    if (tipo_usuario == null) {
                        tipo_usuario = "No determinado";
                    } else if (tipo_usuario.equals("A")) {
                        tipo_usuario = "Admin";
                    } else if (tipo_usuario.equals("U")) {
                        tipo_usuario = "Usuario";
                    }
                    
             
                    // Usar la clase Usuario (si existe) o reemplazarla por el código apropiado
                    Usuario usuario = new Usuario(id, username_, password, dni, nombre, apellidos, fecha_alta, fecha_baja, tipo_usuario);
            %>
            <tr>
                <td><%= usuario.getId_user() %></td>
                <td><%= usuario.getUsername() %></td>
                <td><%= usuario.getDni() %></td>
                <td><%= usuario.getNombre() %></td>
                <td><%= usuario.getApellidos() %></td>
                <td><%= usuario.getFecha_alta() %></td>
                <td><%= usuario.getFecha_baja() %></td>
                <td><%= usuario.getTipo_usuario() %></td>
                <td>
                    <form method="POST" onsubmit="return confirm('¿Estás seguro de eliminar este usuario?')">
                        <input type="hidden" name="usuario_id" value="<%= usuario.getId_user() %>">
                        <input class="delete-button" type="submit" value="Borrar">
                    </form>
                </td>
            </tr>
            <%
            }

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
