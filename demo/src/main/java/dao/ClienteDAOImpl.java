package dao;

import model.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAOImpl implements ClienteDAO {
    @Override
    public boolean insert(Cliente cliente) throws SQLException {
        String sql = "INSERT INTO cliente (id, nombre, documento, tipo_persona, telefono, email, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cliente.getId());
            stmt.setString(2, cliente.getNombre());
            stmt.setString(3, cliente.getDocumento());
            stmt.setString(4, cliente.getTipoPersona());
            stmt.setString(5, cliente.getTelefono());
            stmt.setString(6, cliente.getEmail());
            stmt.setString(7, cliente.getDireccion());
            stmt.setString(8, cliente.getEstado());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean update(Cliente cliente) throws SQLException {
        String sql = "UPDATE cliente SET nombre = ?, documento = ?, tipo_persona = ?, telefono = ?, email = ?, direccion = ?, estado = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cliente.getNombre());
            stmt.setString(2, cliente.getDocumento());
            stmt.setString(3, cliente.getTipoPersona());
            stmt.setString(4, cliente.getTelefono());
            stmt.setString(5, cliente.getEmail());
            stmt.setString(6, cliente.getDireccion());
            stmt.setString(7, cliente.getEstado());
            stmt.setString(8, cliente.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(String id) throws SQLException {
        String sql = "UPDATE cliente SET estado = 'Inactivo', fecha_inactivacion = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public Cliente findById(String id) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE id = ?";
        Cliente cliente = null;

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cliente = resultSetToCliente(rs);
                }
            }
        }
        return cliente;
    }

    @Override
    public List<Cliente> findAll() throws SQLException {
        String sql = "SELECT * FROM cliente";
        List<Cliente> clientes = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                clientes.add(resultSetToCliente(rs));
            }
        }
        return clientes;
    }

    @Override
    public List<Cliente> findByEstado(String estado) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE estado = ?";
        List<Cliente> clientes = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estado);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    clientes.add(resultSetToCliente(rs));
                }
            }
        }
        return clientes;
    }

    private Cliente resultSetToCliente(ResultSet rs) throws SQLException {
        Cliente cliente = new Cliente();
        cliente.setId(rs.getString("id"));
        cliente.setNombre(rs.getString("nombre"));
        cliente.setDocumento(rs.getString("documento"));
        cliente.setTipoPersona(rs.getString("tipo_persona"));
        cliente.setTelefono(rs.getString("telefono"));
        cliente.setEmail(rs.getString("email"));
        cliente.setDireccion(rs.getString("direccion"));
        cliente.setEstado(rs.getString("estado"));
        cliente.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        cliente.setFechaActualizacion(rs.getTimestamp("fecha_actualizacion"));
        cliente.setFechaInactivacion(rs.getTimestamp("fecha_inactivacion"));
        return cliente;
    }

    @Override
    public int countClientesActivos() throws SQLException {
        String sql = "SELECT COUNT(*) FROM cliente WHERE estado = 'Activo'";
        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}