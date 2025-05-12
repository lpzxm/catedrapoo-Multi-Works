package controller;

import dao.EmpleadoDAO;
import dao.EmpleadoDAOImpl;
import model.Empleado;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/empleados")
public class EmpleadoServlet extends HttpServlet {
    private EmpleadoDAO empleadoDAO;

    @Override
    public void init() {
        empleadoDAO = new EmpleadoDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertarEmpleado(request, response);
                    break;
                case "update":
                    actualizarEmpleado(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "new":
                    mostrarFormularioNuevo(request, response);
                    break;
                case "edit":
                    mostrarFormularioEditar(request, response);
                    break;
                case "delete":
                    eliminarEmpleado(request, response);
                    break;
                case "list":
                default:
                    listarEmpleados(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listarEmpleados(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Empleado> listaEmpleados = empleadoDAO.findAll();
        request.setAttribute("listaEmpleados", listaEmpleados);
        request.getRequestDispatcher("/views/empleados/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/empleados/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        Empleado empleadoExistente = empleadoDAO.findById(id);
        request.setAttribute("empleado", empleadoExistente);
        request.getRequestDispatcher("/views/empleados/form.jsp").forward(request, response);
    }

    private void insertarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Empleado empleado = new Empleado();
        empleado.setId(generarIdEmpleado());
        poblarEmpleadoDesdeRequest(empleado, request);
        empleadoDAO.insert(empleado);
        response.sendRedirect("empleados");
    }

    private void actualizarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        Empleado empleado = new Empleado();
        empleado.setId(id);
        poblarEmpleadoDesdeRequest(empleado, request);
        empleadoDAO.update(empleado);
        response.sendRedirect("empleados");
    }

    private void eliminarEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        empleadoDAO.delete(id);
        response.sendRedirect("empleados");
    }

    private void poblarEmpleadoDesdeRequest(Empleado empleado, HttpServletRequest request) {
        empleado.setNombre(request.getParameter("nombre"));
        empleado.setDocumento(request.getParameter("documento"));
        empleado.setTipoPersona(request.getParameter("tipoPersona"));
        empleado.setTipoContratacion(request.getParameter("tipoContratacion"));
        empleado.setTelefono(request.getParameter("telefono"));
        empleado.setEmail(request.getParameter("email"));
        empleado.setDireccion(request.getParameter("direccion"));
        empleado.setEstado(request.getParameter("estado"));
    }

    private String generarIdEmpleado() {
        // Genera un ID con prefijo CLI- y 8 caracteres aleatorios
        return "CLI-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}