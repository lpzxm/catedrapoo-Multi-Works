package dao;

import model.Cliente;

import java.sql.SQLException;
import java.util.List;

public interface ClienteDAO {
    boolean insert(Cliente cliente) throws SQLException;

    boolean update(Cliente cliente) throws SQLException;

    boolean delete(String id) throws SQLException;

    Cliente findById(String id) throws SQLException;

    List<Cliente> findAll() throws SQLException;

    List<Cliente> findByEstado(String estado) throws SQLException;

    int countClientesActivos() throws SQLException;
}