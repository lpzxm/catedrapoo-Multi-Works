package dao;

import model.Cliente;
import model.Cotizacion;
import model.Empleado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CotizacionDAOImpl implements CotizacionDAO {
    @Override
    public boolean insert(Cotizacion cotizacion) throws SQLException {
        String sql = "INSERT INTO cotizacion (id, cliente_id, fecha_tentativa_inicio, fecha_tentativa_fin, costos_adicionales, estado) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cotizacion.getId());
            stmt.setString(2, cotizacion.getCliente().getId());
            stmt.setDate(3, new java.sql.Date(cotizacion.getFechaTentativaInicio().getTime()));
            stmt.setDate(4, new java.sql.Date(cotizacion.getFechaTentativaFin().getTime()));
            stmt.setDouble(5, cotizacion.getCostosAdicionales());
            stmt.setString(6, cotizacion.getEstado());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean update(Cotizacion cotizacion) throws SQLException {
        String sql = "UPDATE cotizacion SET cliente_id = ?, fecha_tentativa_inicio = ?, fecha_tentativa_fin = ?, costos_adicionales = ?, estado = ? WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cotizacion.getCliente().getId());
            stmt.setDate(2, new java.sql.Date(cotizacion.getFechaTentativaInicio().getTime()));
            stmt.setDate(3, new java.sql.Date(cotizacion.getFechaTentativaFin().getTime()));
            stmt.setDouble(4, cotizacion.getCostosAdicionales());
            stmt.setString(5, cotizacion.getEstado());
            stmt.setString(6, cotizacion.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(String id) throws SQLException {
        String sql = "DELETE FROM cotizacion WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean finalizarCotizacion(String id) throws SQLException {
        String sql = "UPDATE cotizacion SET estado = 'Finalizada' WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public Cotizacion findById(String id) throws SQLException {
        String sql = "SELECT c.*, cli.nombre as cliente_nombre FROM cotizacion c JOIN cliente cli ON c.cliente_id = cli.id WHERE c.id = ?";
        Cotizacion cotizacion = null;
        ClienteDAO clienteDAO = new ClienteDAOImpl();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    cotizacion = resultSetToCotizacion(rs);
                }
            }
        }
        return cotizacion;
    }

    @Override
    public List<Cotizacion> findAll() throws SQLException {
        String sql = "SELECT c.*, cli.nombre as cliente_nombre FROM cotizacion c JOIN cliente cli ON c.cliente_id = cli.id";
        List<Cotizacion> cotizaciones = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                cotizaciones.add(resultSetToCotizacion(rs));
            }
        }
        return cotizaciones;
    }

    @Override
    public List<Cotizacion> findByEstado(String estado) throws SQLException {
        String sql = "SELECT c.*, cli.nombre as cliente_nombre FROM cotizacion c JOIN cliente cli ON c.cliente_id = cli.id WHERE c.estado = ?";
        List<Cotizacion> cotizaciones = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, estado);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cotizaciones.add(resultSetToCotizacion(rs));
                }
            }
        }
        return cotizaciones;
    }

    @Override
    public List<Cotizacion> findByCliente(String clienteId) throws SQLException {
        String sql = "SELECT c.*, cli.nombre as cliente_nombre FROM cotizacion c JOIN cliente cli ON c.cliente_id = cli.id WHERE c.cliente_id = ?";
        List<Cotizacion> cotizaciones = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, clienteId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cotizaciones.add(resultSetToCotizacion(rs));
                }
            }
        }
        return cotizaciones;
    }

    private Cotizacion resultSetToCotizacion(ResultSet rs) throws SQLException {
        Cotizacion cotizacion = new Cotizacion();
        cotizacion.setId(rs.getString("id"));

        Cliente cliente = new Cliente();
        cliente.setId(rs.getString("cliente_id"));
        cliente.setNombre(rs.getString("cliente_nombre"));
        cotizacion.setCliente(cliente);

        cotizacion.setFechaTentativaInicio(rs.getDate("fecha_tentativa_inicio"));
        cotizacion.setFechaTentativaFin(rs.getDate("fecha_tentativa_fin"));
        cotizacion.setCostosAdicionales(rs.getDouble("costos_adicionales"));
        cotizacion.setEstado(rs.getString("estado"));
        return cotizacion;
    }
}