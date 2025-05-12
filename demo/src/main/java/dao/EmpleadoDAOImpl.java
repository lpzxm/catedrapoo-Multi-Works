package dao;

import model.Empleado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAOImpl implements EmpleadoDAO {
    @Override
    public boolean insert(Empleado empleado) throws SQLException {
        String sql = "INSERT INTO empleado (id, nombre, documento, tipo_persona, tipo_contratacion, telefono, email, direccion, estado) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, empleado.getId());
            stmt.setString(2, empleado.getNombre());
            stmt.setString(3, empleado.getDocumento());
            stmt.setString(4, empleado.getTipoPersona());
            stmt.setString(5, empleado.getTipoContratacion());
            stmt.setString(6, empleado.getTelefono());
            stmt.setString(7, empleado.getEmail());
            stmt.setString(8, empleado.getDireccion());
            stmt.setString(9, empleado.getEstado());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean update(Empleado empleado) throws SQLException {
        String sql = "UPDATE empleado SET nombre = ?, documento = ?, tipo_persona = ?, tipo_contratacion = ?, telefono = ?, email = ?, direccion = ?, estado = ?, fecha_actualizacion = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, empleado.getNombre());
            stmt.setString(2, empleado.getDocumento());
            stmt.setString(3, empleado.getTipoPersona());
            stmt.setString(4, empleado.getTipoContratacion());
            stmt.setString(5, empleado.getTelefono());
            stmt.setString(6, empleado.getEmail());
            stmt.setString(7, empleado.getDireccion());
            stmt.setString(8, empleado.getEstado());
            stmt.setString(9, empleado.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(String id) throws SQLException {
        String sql = "UPDATE empleado SET estado = 'Inactivo', fecha_inactivacion = CURRENT_TIMESTAMP WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public Empleado findById(String id) throws SQLException {
        String sql = "SELECT * FROM empleado WHERE id = ?";
        Empleado empleado = null;

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    empleado = resultSetToEmpleado(rs);
                }
            }
        }
        return empleado;
    }

    @Override
    public List<Empleado> findAll() throws SQLException {
        String sql = "SELECT * FROM empleado";
        List<Empleado> empleados = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                empleados.add(resultSetToEmpleado(rs));
            }
        }
        return empleados;
    }

    @Override
    public List<Empleado> findByTipoContratacion(String tipo) throws SQLException {
        String sql = "SELECT * FROM empleado WHERE tipo_contratacion = ?";
        List<Empleado> empleados = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, tipo);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    empleados.add(resultSetToEmpleado(rs));
                }
            }
        }
        return empleados;
    }

    private Empleado resultSetToEmpleado(ResultSet rs) throws SQLException {
        Empleado empleado = new Empleado();
        empleado.setId(rs.getString("id"));
        empleado.setNombre(rs.getString("nombre"));
        empleado.setDocumento(rs.getString("documento"));
        empleado.setTipoPersona(rs.getString("tipo_persona"));
        empleado.setTipoContratacion(rs.getString("tipo_contratacion"));
        empleado.setTelefono(rs.getString("telefono"));
        empleado.setEmail(rs.getString("email"));
        empleado.setDireccion(rs.getString("direccion"));
        empleado.setEstado(rs.getString("estado"));
        empleado.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
        empleado.setFechaActualizacion(rs.getTimestamp("fecha_actualizacion"));
        empleado.setFechaInactivacion(rs.getTimestamp("fecha_inactivacion"));
        return empleado;
    }
}