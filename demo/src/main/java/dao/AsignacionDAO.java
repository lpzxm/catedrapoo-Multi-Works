package dao;
import model.Asignacion;

import java.sql.SQLException;
import java.util.List;

public interface AsignacionDAO {
    boolean insert(Asignacion asignacion) throws SQLException;
    boolean update(Asignacion asignacion) throws SQLException;
    boolean delete(String id) throws SQLException;
    Asignacion findById(String id) throws SQLException;
    List<Asignacion> findByCotizacionId(String cotizacionId) throws SQLException;
}