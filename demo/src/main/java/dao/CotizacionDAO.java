package dao;

import model.Cotizacion;

import java.sql.SQLException;
import java.util.List;

public interface CotizacionDAO {
    boolean insert(Cotizacion cotizacion) throws SQLException;

    boolean update(Cotizacion cotizacion) throws SQLException;

    boolean delete(String id) throws SQLException;

    boolean finalizarCotizacion(String id) throws SQLException;

    Cotizacion findById(String id) throws SQLException;

    List<Cotizacion> findAll() throws SQLException;

    List<Cotizacion> findByEstado(String estado) throws SQLException;

    List<Cotizacion> findByCliente(String clienteId) throws SQLException;
}