/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Logger;

/**
 * Servlet que procesa el inicio de sesión de un usuario.
 */
public class LoginProcess extends HttpServlet {
    public static Logger logger = Logger.getLogger("web");

    /**
     * Procesa tanto las solicitudes HTTP GET como POST.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de E/S
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO escribir tu página aquí. Puedes usar el siguiente código de ejemplo. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginProcess</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginProcess en " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Maneja las solicitudes HTTP GET.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de E/S
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Maneja las solicitudes HTTP POST.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException si ocurre un error específico del servlet
     * @throws IOException si ocurre un error de E/S
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        logger.info("Iniciando sesión...");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String dbURL = "jdbc:mysql://localhost:3306/rrhh";
        String dbUser = "root";
        String dbPassword = "webcs";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            String query = "SELECT tipo_usuario, id_user FROM usuarios WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, username);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();
            logger.info("Sesión iniciada, redirigiendo...");

            if (resultSet.next()) {
                // Autenticación exitosa
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                // Almacena el id_user en la sesión
                String idUser = resultSet.getString("id_user");
                session.setAttribute("id_user", idUser);
                
                // Redirecciona al sujeto a la página correspondiente dependiendo si es Admin o Usuario.
                String tipo_usuario = resultSet.getString("tipo_usuario");
                if ("A".equals(tipo_usuario)) {
                    response.sendRedirect("bienvenido_admin.jsp");
                } else if ("U".equals(tipo_usuario)) {
                    response.sendRedirect("bienvenido_usuario.jsp");
                }
            } else {
                logger.severe("Se ha producido un error al iniciar sesión.");
                // Autenticación fallida
                response.sendRedirect("error.jsp");
            }

            resultSet.close();
            statement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
            // Manejo de error
            response.sendRedirect("error.jsp");
        }
    }

    /**
     * Retorna una descripción corta del servlet.
     *
     * @return una cadena que contiene la descripción del servlet
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
