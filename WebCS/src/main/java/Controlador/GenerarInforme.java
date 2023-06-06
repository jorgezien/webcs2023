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
 * Servlet para generar un informe de usuario.
 */
public class GenerarInforme extends HttpServlet {

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
            out.println("<title>Servlet GenerarInforme</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GenerarInforme en " + request.getContextPath() + "</h1>");
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
        LoginProcess.logger.info("Generando informes...");
        String id_user = request.getParameter("usuario_id");

        Connection conn = null;
        Statement stmt = null;
        Statement stmt2 = null;
        ResultSet rs_usuario = null;
        ResultSet rs_marcajes = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/rrhh", "root", "webcs");
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
                   
                LoginProcess.logger.info("Informes generados correctamente.");
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
     * Retorna una descripción corta del servlet.
     *
     * @return una cadena que contiene la descripción del servlet
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
