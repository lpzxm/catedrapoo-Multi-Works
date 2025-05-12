package dao;

import model.Empleado;

import java.sql.SQLException;
import java.util.List;

public interface EmpleadoDAO {
    boolean insert(Empleado empleado) throws SQLException;

    boolean update(Empleado empleado) throws SQLException;

    boolean delete(String id) throws SQLException;

    Empleado findById(String id) throws SQLException;

    List<Empleado> findAll() throws SQLException;

    List<Empleado> findByTipoContratacion(String tipo) throws SQLException;
}