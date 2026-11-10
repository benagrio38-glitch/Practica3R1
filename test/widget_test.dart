// Pruebas del ViewModel de la lista y de la capa de Datos (sin multimedia).
import 'package:flutter_test/flutter_test.dart';
import 'package:descubre_dolores/data/datasources/lugares_local_datasource.dart';
import 'package:descubre_dolores/data/repositories/lugares_repository_impl.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugares.dart';
import 'package:descubre_dolores/presentation/viewmodels/lugares_view_model.dart';

void main() {
  test('el repositorio real regresa los 3 lugares y busca por id', () async {
    final repo = LugaresRepositoryImpl(LugaresLocalDataSource());

    expect((await repo.obtenerTodos()).length, 3);
    expect((await repo.obtenerPorId('2'))!.nombre, contains('Parroquia'));
    expect(await repo.obtenerPorId('99'), isNull);
  });

  test('LugaresViewModel.cargar llena la lista y termina de cargar', () async {
    final repo = LugaresRepositoryImpl(LugaresLocalDataSource());
    final vm = LugaresViewModel(ObtenerLugares(repo));

    expect(vm.lugares, isEmpty);
    await vm.cargar();

    expect(vm.cargando, false);
    expect(vm.error, isNull);
    expect(vm.lugares.length, 3);
  });
}
