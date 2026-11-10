// CAPA DE DOMINIO · Contrato del repositorio.
// El Dominio define QUÉ se necesita; la capa de Datos decide CÓMO se obtiene.
import '../entities/lugar_turistico.dart';

abstract class LugaresRepository {
  Future<List<LugarTuristico>> obtenerTodos();
  Future<LugarTuristico?> obtenerPorId(String id);
}
