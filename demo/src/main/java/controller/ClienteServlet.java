package controller;

import dao.ClienteDAO;
import dao.ClienteDAOImpl;
import model.Cliente;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {
    private ClienteDAO clienteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        clienteDAO = new ClienteDAOImpl();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertarCliente(request, response);
                    break;
                case "update":
                    actualizarCliente(request, response);
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
                    eliminarCliente(request, response);
                    break;
                case "list":
                default:
                    listarClientes(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listarClientes(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        List<Cliente> listaClientes = clienteDAO.findAll();
        int totalClientesActivos = clienteDAO.countClientesActivos();
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("totalClientesActivos", totalClientesActivos);
        request.getRequestDispatcher("/views/clientes/list.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/clientes/form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        Cliente clienteExistente = clienteDAO.findById(id);
        request.setAttribute("cliente", clienteExistente);
        request.getRequestDispatcher("/views/clientes/form.jsp").forward(request, response);
    }

    private void insertarCliente(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Cliente cliente = new Cliente();
        cliente.setId(generarIdCliente());
        poblarClienteDesdeRequest(cliente, request);
        clienteDAO.insert(cliente);
        response.sendRedirect("clientes");
    }

    private void actualizarCliente(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        Cliente cliente = new Cliente();
        cliente.setId(id);
        poblarClienteDesdeRequest(cliente, request);
        clienteDAO.update(cliente);
        response.sendRedirect("clientes");
    }

    private void eliminarCliente(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String id = request.getParameter("id");
        clienteDAO.delete(id);
        response.sendRedirect("clientes");
    }

    private void poblarClienteDesdeRequest(Cliente cliente, HttpServletRequest request) {
        cliente.setNombre(request.getParameter("nombre"));
        cliente.setDocumento(request.getParameter("documento"));
        cliente.setTipoPersona(request.getParameter("tipoPersona"));
        cliente.setTelefono(request.getParameter("telefono"));
        cliente.setEmail(request.getParameter("email"));
        cliente.setDireccion(request.getParameter("direccion"));
        cliente.setEstado(request.getParameter("estado"));
    }

    private String generarIdCliente() {
        // Genera un ID con prefijo CLI- y 8 caracteres aleatorios
        return "CLI-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
    }
}
