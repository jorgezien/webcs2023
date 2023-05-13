<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Empresa" %>
<%@ page import="Modelo.Proyecto" %>

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
        </style>
    </head>
    <body>
        <h1>Dashboard</h1>
        <h1>Bienvenido, <%= session.getAttribute("username") %></h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
            </tr>
            <%-- Obtener los datos de la tabla "empresa" --%>
            <%!
                // Datos de conexión a la base de datos
                String url = "jdbc:mysql://localhost:3333/rrhh";
                String usuarioBD = "root";
                String contrasenaBD = "";
            %>
            <%-- Obtener los datos de las tablas y mostrarlos en la tabla HTML --%>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs_empresa = null;
                
            
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
            </tr>

            <%
                    }
                    // ...
                    // Cierre de las conexiones y liberación de recursos
                    // ...
                } catch (Exception e) {
                    e.printStackTrace();
                    // Manejo de errores
                } finally {
                    // ...
                    // Cierre de las conexiones y liberación de recursos en caso de ser necesario
                    // ...
                }
            %>
        </table>
    </body>
</html>
