<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.Date,java.text.SimpleDateFormat" %>
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
    <title>Marcar Entrada y Salida</title>
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

        .button-green {
            background-color: #63cdda;
        }

        .button-red {
            background-color: #ff6b6b;
        }

        .button-container button:hover {
            opacity: 0.8;
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


        .messageE.success {
            color: #63cdda;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }
        .messageS.success {
            color: #ff6b6b;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }

        .message.error {
            color: #ff6b6b;
        }
    </style>
</head>
<body>
<a href="http://localhost:8080/WebCS/bienvenido_usuario.jsp" class="back-button">Atrás</a>
<h1>Bienvenido, <%= session.getAttribute("username") %></h1>
<h1>Marcar Entrada y Salida</h1>

<h3>Tu ID de usuario es <%= session.getAttribute("id_user") %></h3>

<form method="POST" action="marcar.jsp">
    <div class="button-container">
        <button class="button-green" type="submit" name="entrada">Marcar Entrada</button>
        <button class="button-red" type="submit" name="salida">Marcar Salida</button>
    </div>
</form>

<%
    // Datos de conexión a la base de datos
    String url = "jdbc:mysql://localhost:3333/rrhh";
    String usuarioBD = "root";
    String contrasenaBD = "";

    // ID del usuario (esto debe ser ajustado de acuerdo a tu manejo de sesión)
    String id_usuario = String.valueOf(session.getAttribute("id_user"));
    int id = Integer.valueOf(id_usuario);
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String fecha = formatter.format(new Date());

    Connection conn = null;
    PreparedStatement ps_marcaje = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);
        String query_marcaje = "INSERT INTO marcajes (fecha, tipo_marcaje, id_usuario) VALUES (?, ?, ?)";

        ps_marcaje = conn.prepareStatement(query_marcaje);

        if (request.getParameter("entrada") != null) {
            ps_marcaje.setString(1, fecha);
            ps_marcaje.setString(2, "E");
            ps_marcaje.setInt(3, id);
            ps_marcaje.executeUpdate();

            %>
            <div class="messageE success">Entrada marcada a las <%= fecha %></div>
            <%
        }

        if (request.getParameter("salida") != null) {
            ps_marcaje.setString(1, fecha);
            ps_marcaje.setString(2, "S");
            ps_marcaje.setInt(3, id);
            ps_marcaje.executeUpdate();

            %>
            <div class="messageS success">Salida marcada a las <%= fecha %></div>
            <%
        }

    } catch (Exception e) {
        e.printStackTrace();
        // Manejo de errores
        %>
        <div class="message error">Error al marcar la entrada o salida.</div>
        <%
    } finally {
        // Cierre de las conexiones y liberación de recursos
        if (ps_marcaje != null) {
            try {
                ps_marcaje.close();
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
</body>
</html>