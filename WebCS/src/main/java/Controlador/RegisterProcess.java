/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author newJo
 */
public class RegisterProcess extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterProcess</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterProcess at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String fecha_alta = request.getParameter("fecha_alta");
        String fecha_baja = request.getParameter("fecha_baja");
        String tipo_usuario = request.getParameter("tipo_usuario");

        // Aquí tienes que introducir tus datos de conexión a la base de datos
        String url = "jdbc:mysql://localhost:3333/rrhh";
        String usuarioBD = "root";
        String contrasenaBD = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);

            String insert_query = "INSERT INTO usuarios (username, password, dni, nombre, apellidos, fecha_alta, fecha_baja, tipo_usuario) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insert_query);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, dni);
            ps.setString(4, nombre);
            ps.setString(5, apellidos);
            ps.setString(6, fecha_alta);
            ps.setString(7, fecha_baja);
            ps.setString(8, tipo_usuario);
            ps.executeUpdate();
            String query = "SELECT id_user FROM usuarios WHERE username = ?";
            PreparedStatement query_ps = conn.prepareStatement(query);
            query_ps.setString(1, username);
            ResultSet resultSet = query_ps.executeQuery();
            
            out.print("Usuario registrado con éxito!");
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            if (resultSet.next()){
                session.setAttribute("id_user", resultSet.getString("id_user"));
            }
            if ("A".equals(tipo_usuario)) {
                response.sendRedirect("bienvenido_admin.jsp");
            } else if ("U".equals(tipo_usuario)) {
                response.sendRedirect("bienvenido_usuario.jsp");
            }
            ps.close();
            conn.close();

        } catch (Exception e) {
            out.println(e);
        }

        out.close();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
