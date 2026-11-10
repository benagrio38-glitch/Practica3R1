// CAPA DE DOMINIO · Caso de uso: obtener la lista de lugares.
import '../entities/lugar_turistico.dart';
import '../repositories/lugares_repository.dart';

class ObtenerLugares {
  final LugaresRepository repository;
  ObtenerLugares(this.repository);

  // call() permite invocar el caso de uso como si fuera una función:
  // obtenerLugares()
  Future<List<LugarTuristico>> call() {
    return repository.obtenerTodos();
  }
}
