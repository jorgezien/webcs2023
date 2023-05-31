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
        </style>
    </head>
    <body>
        <button onclick="history.go(-1)" class="back-button">Atrás</button>

        <h1>Dashboard</h1>
        <h1>Bienvenido, <%= session.getAttribute("username") %></h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Acciones</th>
            </tr>
            <%-- Obtener los datos de la tabla "empresa" --%>
            <%!
            // Datos de conexión a la base de datos
            String url = "jdbc:mysql://localhost:3306/rrhh";
            String usuarioBD = "root";
            String contrasenaBD = "webcs";
            %>
            <%-- Obtener los datos de las tablas y mostrarlos en la tabla HTML --%>
            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs_empresa = null;
            PreparedStatement ps_insert_empresa = null;
            PreparedStatement ps_delete_empresa = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
                stmt = conn.createStatement();
                String query_empresa = "SELECT * FROM empresa";

                rs_empresa = stmt.executeQuery(query_empresa);

                while (rs_empresa.next()) {
                    int id = rs_empresa.getInt("id_empresa");
                    String nombre = rs_empresa.getString("nombre_empresa");
                    Empresa empresa = new Empresa(id, nombre);
            %>
            <tr>
                <td><%= empresa.getId_empresa() %></td>
                <td><%= empresa.getNombre_empresa() %></td>
                <td>
                    <form method="POST" onsubmit="return confirm('¿Estás seguro de eliminar esta empresa?')">
                        <input type="hidden" name="empresa_id" value="<%= empresa.getId_empresa() %>">
                        <input class="delete-button" type="submit" value="Borrar">
                    </form>
                </td>
            </tr>
            <%
            }

                    // ...

                // Procesar el formulario para eliminar empresas
                if (request.getParameter("empresa_id") != null) {
                    int empresa_id = Integer.parseInt(request.getParameter("empresa_id"));

                    // Validar el ID de la empresa según tus necesidades

                    try {
                        // Verificar si existen proyectos relacionados con la empresa
                        String check_query = "SELECT COUNT(*) AS count FROM proyectos WHERE id_empresa = ?";
                        PreparedStatement ps_check_proyectos = conn.prepareStatement(check_query);
                        ps_check_proyectos.setInt(1, empresa_id);
                        ResultSet rs_proyectos = ps_check_proyectos.executeQuery();
                        rs_proyectos.next();
                        int proyectosCount = rs_proyectos.getInt("count");
                        ps_check_proyectos.close();

                        if (proyectosCount > 0) {
                            // Eliminar los proyectos asociados a la empresa
                            String delete_proyectos_query = "DELETE FROM proyectos WHERE id_empresa = ?";
                            PreparedStatement ps_delete_proyectos = conn.prepareStatement(delete_proyectos_query);
                            ps_delete_proyectos.setInt(1, empresa_id);
                            ps_delete_proyectos.executeUpdate();
                            ps_delete_proyectos.close();
                        }

                        // Eliminar la empresa
                        String delete_query = "DELETE FROM empresa WHERE id_empresa = ?";
                        ps_delete_empresa = conn.prepareStatement(delete_query);
                        ps_delete_empresa.setInt(1, empresa_id);
                        ps_delete_empresa.executeUpdate();
                    } catch (SQLException e) {
                        e.printStackTrace();
                        // Manejo de errores
                    }

                    // Redirigir a la página actual para actualizar la tabla
                    response.sendRedirect(request.getRequestURI());
                }

                // Procesar el formulario para añadir empresas
                if (request.getParameter("nombre_empresa") != null) {
                    String nombre_empresa = request.getParameter("nombre_empresa");

                    try {
                        // Insertar la empresa en la base de datos
                        String insert_query = "INSERT INTO empresa (nombre_empresa) VALUES (?)";
                        ps_insert_empresa = conn.prepareStatement(insert_query);
                        ps_insert_empresa.setString(1, nombre_empresa);
                        ps_insert_empresa.executeUpdate();
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
                if (rs_empresa != null) {
                    try {
                        rs_empresa.close();
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
                if (ps_insert_empresa != null) {
                    try {
                        ps_insert_empresa.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (ps_delete_empresa != null) {
                    try {
                        ps_delete_empresa.close();
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
                    <form method="POST">
                        <input type="text" name="nombre_empresa" placeholder="Nombre de la empresa" required>
                        <input type="submit" value="Añadir">
                    </form>
                </td>
                <td></td>
                <td></td>
            </tr>

        </table>
