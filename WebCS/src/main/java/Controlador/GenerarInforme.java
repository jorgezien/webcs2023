/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controlador;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author newJo
 */
public class GenerarInforme extends HttpServlet {

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
            out.println("<title>Servlet GenerarInforme</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerarInforme at " + request.getContextPath() + "</h1>");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id_user = request.getParameter("usuario_id");

        Connection conn = null;
        Statement stmt = null;
        Statement stmt2 = null;
        ResultSet rs_usuario = null;
        ResultSet rs_marcajes = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3333/rrhh", "root", "");
            stmt = conn.createStatement();
            String query_usuario = "SELECT * FROM usuarios WHERE id_user = " + id_user;
            String query_marcajes = "SELECT * FROM marcajes WHERE id_usuario = " + id_user;
            rs_usuario = stmt.executeQuery(query_usuario);
            stmt2 = conn.createStatement();
            rs_marcajes = stmt2.executeQuery(query_marcajes);

            if (rs_usuario.next()) {
                Usuario usuario = new Usuario(rs_usuario.getInt("id_user"),
                        rs_usuario.getString("username"),
                        rs_usuario.getString("password"),
                        rs_usuario.getString("dni"),
                        rs_usuario.getString("nombre"),
                        rs_usuario.getString("apellidos"),
                        rs_usuario.getString("fecha_alta"),
                        rs_usuario.getString("fecha_baja"),
                        rs_usuario.getString("tipo_usuario"));

                String contenidoInforme = "ID: " + usuario.getId_user()
                        + "\nNombre de usuario: " + usuario.getUsername()
                        + "\nDNI: " + usuario.getDni()
                        + "\nNombre: " + usuario.getNombre()
                        + "\nApellidos: " + usuario.getApellidos()
                        + "\nFecha de alta: " + usuario.getFecha_alta()
                        + "\nFecha de baja: " + usuario.getFecha_baja()
                        + "\nTipo de usuario: " + usuario.getTipo_usuario();
                
                contenidoInforme += "\n---------[Lista de marcajes]----------";
                while (rs_marcajes.next()){
                    String fecha = rs_marcajes.getString("fecha");
                    String tipo_marcaje = rs_marcajes.getString("tipo_marcaje");
                    if (fecha.equals("null")){
                        fecha = "No determinado";
                    }
                    
                    if (tipo_marcaje.equals("E")){
                        tipo_marcaje = "Entrada";
                    } else if (tipo_marcaje.equals("S")){
                        tipo_marcaje = "Salida";
                    }
                    
                    contenidoInforme += "\n---------[Marcaje]----------";
                    contenidoInforme += "\nFecha Marcaje: " + fecha
                            + "\nTipo de Marcaje: " + tipo_marcaje;
                    
                }
                response.setContentType("text/plain");
                response.setHeader("Content-disposition", "attachment; filename=informe_" + usuario.getId_user() + ".txt");

                try (PrintWriter out = response.getWriter()) {
                    out.println(contenidoInforme);
                }
            }

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try {
                if (rs_usuario != null) {
                    rs_usuario.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                throw new ServletException(e);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
