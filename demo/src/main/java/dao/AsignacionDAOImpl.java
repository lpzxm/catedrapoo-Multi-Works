package dao;
import model.Asignacion;
import model.Empleado;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsignacionDAOImpl implements AsignacionDAO {
    @Override
    public boolean insert(Asignacion asignacion) throws SQLException {
        String sql = "INSERT INTO asignacion (id, cotizacion_id, titulo, empleado_id, area_asignada, costo_por_hora, fecha_hora_inicio, fecha_hora_fin, horas_aproximadas, incremento_extra) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, asignacion.getId());
            stmt.setString(2, asignacion.getCotizacionId());
            stmt.setString(3, asignacion.getTitulo());
            stmt.setString(4, asignacion.getTrabajador().getId());
            stmt.setString(5, asignacion.getAreaAsignada());
            stmt.setDouble(6, asignacion.getCostoPorHora());
            stmt.setTimestamp(7, new java.sql.Timestamp(asignacion.getFechaHoraInicio().getTime()));
            stmt.setTimestamp(8, new java.sql.Timestamp(asignacion.getFechaHoraFin().getTime()));
            stmt.setDouble(9, asignacion.getHorasAproximadas());
            stmt.setDouble(10, asignacion.getIncrementoExtra());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean update(Asignacion asignacion) throws SQLException {
        String sql = "UPDATE asignacion SET titulo = ?, empleado_id = ?, area_asignada = ?, costo_por_hora = ?, fecha_hora_inicio = ?, fecha_hora_fin = ?, horas_aproximadas = ?, incremento_extra = ? WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, asignacion.getTitulo());
            stmt.setString(2, asignacion.getTrabajador().getId());
            stmt.setString(3, asignacion.getAreaAsignada());
            stmt.setDouble(4, asignacion.getCostoPorHora());
            stmt.setTimestamp(5, new java.sql.Timestamp(asignacion.getFechaHoraInicio().getTime()));
            stmt.setTimestamp(6, new java.sql.Timestamp(asignacion.getFechaHoraFin().getTime()));
            stmt.setDouble(7, asignacion.getHorasAproximadas());
            stmt.setDouble(8, asignacion.getIncrementoExtra());
            stmt.setString(9, asignacion.getId());

            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(String id) throws SQLException {
        String sql = "DELETE FROM asignacion WHERE id = ?";

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public Asignacion findById(String id) throws SQLException {
        String sql = "SELECT a.*, e.nombre as empleado_nombre FROM asignacion a JOIN empleado e ON a.empleado_id = e.id WHERE a.id = ?";
        Asignacion asignacion = null;

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    asignacion = resultSetToAsignacion(rs);
                }
            }
        }
        return asignacion;
    }

    @Override
    public List<Asignacion> findByCotizacionId(String cotizacionId) throws SQLException {
        String sql = "SELECT a.*, e.nombre as empleado_nombre FROM asignacion a JOIN empleado e ON a.empleado_id = e.id WHERE a.cotizacion_id = ?";
        List<Asignacion> asignaciones = new ArrayList<>();

        try (Connection conn = Conexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cotizacionId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    asignaciones.add(resultSetToAsignacion(rs));
                }
            }
        }
        return asignaciones;
    }

    private Asignacion resultSetToAsignacion(ResultSet rs) throws SQLException {
        Asignacion asignacion = new Asignacion();
        asignacion.setId(rs.getString("id"));
        asignacion.setCotizacionId(rs.getString("cotizacion_id"));
        asignacion.setTitulo(rs.getString("titulo"));

        Empleado empleado = new Empleado();
        empleado.setId(rs.getString("empleado_id"));
        empleado.setNombre(rs.getString("empleado_nombre"));
        asignacion.setTrabajador(empleado);

        asignacion.setAreaAsignada(rs.getString("area_asignada"));
        asignacion.setCostoPorHora(rs.getDouble("costo_por_hora"));
        asignacion.setFechaHoraInicio(rs.getTimestamp("fecha_hora_inicio"));
        asignacion.setFechaHoraFin(rs.getTimestamp("fecha_hora_fin"));
        asignacion.setHorasAproximadas(rs.getDouble("horas_aproximadas"));
        asignacion.setIncrementoExtra(rs.getDouble("incremento_extra"));
        return asignacion;
    }
}