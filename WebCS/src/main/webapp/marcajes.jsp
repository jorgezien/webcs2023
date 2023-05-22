<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Modelo.Marcaje" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Marcajes</title>
        <!-- ... (Estilos CSS) ... -->
    </head>
    <body>
        <a href="http://localhost:8080/WebCS/bienvenido_admin.jsp" class="back-button">Atrás</a>
        <h1>Marcajes</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>Fecha</th>
                <th>Tipo de Marcaje</th>
                <th>ID Usuario</th>
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
                    Timestamp fecha = rs_marcaje.getTimestamp("fecha");
                    String tipo_marcaje = rs_marcaje.getString("tipo_marcaje");
                    int id_usuario = rs_marcaje.getInt("id_usuario");

                    // Usar la clase Marcaje (si existe) o reemplazarla por el código apropiado
                    Marcaje marcaje = new Marcaje(id, fecha, tipo_marcaje, id_usuario);
            %>
            <tr>
                <td><%= marcaje.getId() %></td>
                <td><%= marcaje.getFecha() %></td>
                <td><%= marcaje.getTipoMarcaje() %></td>
                <td><%= marcaje.getIdUsuario() %></td>
                <td>
                    <form method="POST" onsubmit="return confirm('¿Estás seguro de eliminar este marcaje?')">
                        <input type="hidden" name="marcaje_id" value="<%= marcaje.getId() %>">
                        <input class="delete-button" type="submit" value="Borrar">
                    </form>
                </td>
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

            <tr>
                <!-- Formulario para añadir marcajes -->
            </tr>
        </table>
    </body>
</html>
