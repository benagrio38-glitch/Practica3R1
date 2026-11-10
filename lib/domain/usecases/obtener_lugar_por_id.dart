// CAPA DE DOMINIO · Caso de uso: obtener un lugar por su id.
import '../entities/lugar_turistico.dart';
import '../repositories/lugares_repository.dart';

class ObtenerLugarPorId {
  final LugaresRepository repository;
  ObtenerLugarPorId(this.repository);

  Future<LugarTuristico?> call(String id) {
    return repository.obtenerPorId(id);
  }
}
