package controller;

import dao.*;
import model.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cotizaciones")
public class CotizacionServlet extends HttpServlet {
    private CotizacionDAO cotizacionDAO;
    private ClienteDAO clienteDAO;
    private EmpleadoDAO empleadoDAO;
    private AsignacionDAO asignacionDAO;

    @Override
    public void init() {
        cotizacionDAO = new CotizacionDAOImpl();
        clienteDAO = new ClienteDAOImpl();
        empleadoDAO = new EmpleadoDAOImpl();
        asignacionDAO = new AsignacionDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertarCotizacion(request, response);
                    break;
                case "update":
                    actualizarCotizacion(request, response);
                    break;
                case "addAsignacion":
                    agregarAsignacion(request, response);
                    break;
                case "finalizar":
                    finalizarCotizacion(request, response);
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
                    eliminarCotizacion(request, response);
                    break;
                case "view":
                    verCotizacion(request, response);
                    break;
                case "addAsignacion":
                    mostrarFormularioAsignacion(request, response);
                    break;
                case "list":
                default:
                    listarCotizaciones(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listarCotizaciones(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Cotizacion> listaCotizaciones = cotizacionDAO.findAll();
        request.setAttribute("listaCotizaciones", listaCotizaciones);
        request.getRequestDispatcher("/views/cotizaciones/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        List<Cliente> clientes = clienteDAO.findAll();
        request.setAttribute("clientes", clientes);
        request.getRequestDispatcher("/views/cotizaciones/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        Cotizacion cotizacionExistente = cotizacionDAO.findById(id);
        List<Cliente> clientes = clienteDAO.findAll();

        request.setAttribute("cotizacion", cotizacionExistente);
        request.setAttribute("clientes", clientes);
        request.getRequestDispatcher("/views/cotizaciones/form.jsp").forward(request, response);
    }

    private void mostrarFormularioAsignacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String cotizacionId = request.getParameter("cotizacionId");
        List<Empleado> empleados = empleadoDAO.findAll();

        request.setAttribute("cotizacionId", cotizacionId);
        request.setAttribute("empleados", empleados);
        request.getRequestDispatcher("/views/cotizaciones/asignacionForm.jsp").forward(request, response);
    }

    private void verCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        Cotizacion cotizacion = cotizacionDAO.findById(id);
        List<Asignacion> asignaciones = asignacionDAO.findByCotizacionId(id);

        request.setAttribute("cotizacion", cotizacion);
        request.setAttribute("asignaciones", asignaciones);
        request.getRequestDispatcher("/views/cotizaciones/view.jsp").forward(request, response);
    }

    private void insertarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Cotizacion cotizacion = new Cotizacion();
        cotizacion.setId(generarIdCotizacion());
        poblarCotizacionDesdeRequest(cotizacion, request);
        cotizacionDAO.insert(cotizacion);
        response.sendRedirect("cotizaciones");
    }

    private void actualizarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        Cotizacion cotizacion = new Cotizacion();
        cotizacion.setId(id);
        poblarCotizacionDesdeRequest(cotizacion, request);
        cotizacionDAO.update(cotizacion);
        response.sendRedirect("cotizaciones");
    }

    private void agregarAsignacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Asignacion asignacion = new Asignacion();
        poblarAsignacionDesdeRequest(asignacion, request);
        asignacionDAO.insert(asignacion);
        response.sendRedirect("cotizaciones?action=view&id=" + asignacion.getCotizacionId());
    }

    private void finalizarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        cotizacionDAO.finalizarCotizacion(id);
        response.sendRedirect("cotizaciones?action=view&id=" + id);
    }

    private void eliminarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        cotizacionDAO.delete(id);
        response.sendRedirect("cotizaciones");
    }

    private void poblarCotizacionDesdeRequest(Cotizacion cotizacion, HttpServletRequest request) {
        String clienteId = request.getParameter("clienteId");
        Cliente cliente = new Cliente();
        cliente.setId(clienteId);
        cotizacion.setCliente(cliente);

        cotizacion.setFechaTentativaInicio(java.sql.Date.valueOf(request.getParameter("fechaTentativaInicio")));
        cotizacion.setFechaTentativaFin(java.sql.Date.valueOf(request.getParameter("fechaTentativaFin")));
        cotizacion.setCostosAdicionales(Double.parseDouble(request.getParameter("costosAdicionales")));
        cotizacion.setEstado("En proceso");
    }

    private void poblarAsignacionDesdeRequest(Asignacion asignacion, HttpServletRequest request) {
        asignacion.setCotizacionId(request.getParameter("cotizacionId"));
        asignacion.setTitulo(request.getParameter("titulo"));

        String empleadoId = request.getParameter("empleadoId");
        Empleado empleado = new Empleado();
        empleado.setId(empleadoId);
        asignacion.setTrabajador(empleado);

        asignacion.setAreaAsignada(request.getParameter("areaAsignada"));
        asignacion.setCostoPorHora(Double.parseDouble(request.getParameter("costoPorHora")));
        asignacion.setFechaHoraInicio(java.sql.Timestamp.valueOf(request.getParameter("fechaHoraInicio")));
        asignacion.setFechaHoraFin(java.sql.Timestamp.valueOf(request.getParameter("fechaHoraFin")));
        asignacion.setHorasAproximadas(Double.parseDouble(request.getParameter("horasAproximadas")));
        asignacion.setIncrementoExtra(Double.parseDouble(request.getParameter("incrementoExtra")));
    }

    private String generarIdCotizacion() {
        // Genera un ID con prefijo CLI- y 8 caracteres aleatorios
        return "CLI-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}