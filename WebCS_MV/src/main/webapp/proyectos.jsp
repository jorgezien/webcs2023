<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Empresa" %>
<%@ page import="Modelo.Proyecto" %>
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

            .add-project-form {
                display: grid;
                grid-template-columns: 1fr 1fr auto;
                gap: 10px;
                align-items: center;
            }

            .add-project-form input[type="text"],
            .add-project-form input[type="number"] {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 5px;
                font-size: 14px;
            }

            .add-project-form input[type="submit"] {
                background-color: #4285f4;
                color: #ffffff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 4px;
            }

            .add-project-form input[type="submit"]:hover {
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
                <th>ID Proyecto</th>
                <th>Nombre</th>
                <th>ID Empresa</th>
                <th>Acciones</th>
            </tr>
            <%!
            // Datos de conexión a la base de datos
            String url = "jdbc:mysql://localhost:3306/rrhh";
            String usuarioBD = "root";
            String contrasenaBD = "webcs";
            %>
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs_proyecto = null;
            PreparedStatement ps_insert_proyecto = null;
            PreparedStatement ps_delete_proyecto = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                stmt = conn.createStatement();
                String query_proyecto = "SELECT * FROM proyectos";

                rs_proyecto = stmt.executeQuery(query_proyecto);

                while (rs_proyecto.next()) {
                    int id_proyecto = rs_proyecto.getInt("id_proyecto");
                    String nombre = rs_proyecto.getString("nombre");
                    int id_empresa = rs_proyecto.getInt("id_empresa");
                    Proyecto proyecto = new Proyecto(id_proyecto, nombre, id_empresa);
            %>
            <tr>
                <td><%= proyecto.getId_proyecto() %></td>
                <td><%= proyecto.getNombre() %></td>
                <td><%= proyecto.getId_empresa() %></td>
                <td>
                    <form method="POST" onsubmit="return confirm('¿Estás seguro de eliminar este proyecto?')">
                        <input type="hidden" name="proyecto_id" value="<%= proyecto.getId_proyecto() %>">
                        <input class="delete-button" type="submit" value="Borrar">
                    </form>
                </td>
            </tr>
            <%
            }

                    // ...

                // Procesar el formulario para eliminar proyectos
                if (request.getParameter("proyecto_id") != null) {
                    int proyecto_id = Integer.parseInt(request.getParameter("proyecto_id"));

                    // Validar el ID del proyecto según tus necesidades

                    try {
                        // Eliminar el proyecto
                        String delete_query = "DELETE FROM proyectos WHERE id_proyecto = ?";
                        ps_delete_proyecto = conn.prepareStatement(delete_query);
                        ps_delete_proyecto.setInt(1, proyecto_id);
                        ps_delete_proyecto.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        // Manejo de errores
                    }

                    // Redirigir a la página actual para actualizar la tabla
                    response.sendRedirect(request.getRequestURI());
                }

                // Procesar el formulario para añadir proyectos
                if (request.getParameter("nombre_proyecto") != null && request.getParameter("id_empresa") != null) {
                    String nombre_proyecto = request.getParameter("nombre_proyecto");
                    int id_empresa = Integer.parseInt(request.getParameter("id_empresa"));
                    String last_id_query = "SELECT MAX(id_proyecto) as max_id FROM proyectos";
                    ResultSet rs_max = stmt.executeQuery(last_id_query);
                    int new_id_proyecto = 1;  // Inicializar a 1 para el primer registro
                    if (rs_max.next()) {
                        new_id_proyecto = rs_max.getInt("max_id") + 1;
                    }
                    try {
                        // Insertar el proyecto en la base de datos
                        String insert_query = "INSERT INTO proyectos (id_proyecto, nombre, id_empresa) VALUES (?, ?, ?)";
                        ps_insert_proyecto = conn.prepareStatement(insert_query);
                        ps_insert_proyecto.setInt(1, new_id_proyecto);
                        ps_insert_proyecto.setString(2, nombre_proyecto);
                        ps_insert_proyecto.setInt(3, id_empresa);
                        ps_insert_proyecto.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        // Manejo de errores
                    }

                    // Redirigir a la página actual para actualizar la tabla
                    response.sendRedirect(request.getRequestURI());
                }

            } catch (Exception e) {
                e.printStackTrace();
                // Manejo de errores
            } finally {
                // Cierre de las conexiones y liberación de recursos en caso de ser necesario
                if (rs_proyecto != null) {
                    try {
                        rs_proyecto.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (stmt != null) {
                    try {
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (ps_insert_proyecto != null) {
                    try {
                        ps_insert_proyecto.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (ps_delete_proyecto != null) {
                    try {
                        ps_delete_proyecto.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }

            %>

            <tr>
                <td>
                    <form class="add-project-form" method="POST">
                        <input type="text" name="nombre_proyecto" placeholder="Nombre del proyecto" required>
                        <input type="number" name="id_empresa" placeholder="ID de la empresa" required>
                        <input type="submit" value="Añadir">
                    </form>
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>

        </table>
    </body>
</html>
