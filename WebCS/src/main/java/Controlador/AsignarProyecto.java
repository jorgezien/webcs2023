package Controlador;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class AsignarProyecto extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AsignarProyecto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Proyecto asignado correctamente.</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String workerId = request.getParameter("workerId");
        String projectId = request.getParameter("projectId");

        String url = "jdbc:mysql://localhost:3306/rrhh";
        String usuarioBD = "root";
        String contrasenaBD = "webcs";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, usuarioBD, contrasenaBD);

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            String nowStr = LocalDateTime.now().format(formatter);
            String oneYearLaterStr = LocalDateTime.now().plusYears(1).format(formatter);

            String query = "INSERT INTO usuarios_proyectos (id_user, id_proyecto, fecha_alta, fecha_baja) VALUES (?, ?, ?, ?)";

            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, workerId);
            pstmt.setString(2, projectId);
            pstmt.setString(3, nowStr);
            pstmt.setString(4, oneYearLaterStr);

            int result = pstmt.executeUpdate();
            LoginProcess.logger.info("Proyecto asignado a usuario correctamente.");
            response.sendRedirect("informacion_trabajadores.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public String getServletInfo() {
        return "AsignarProyecto servlet";
    }
}
