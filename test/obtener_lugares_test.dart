// Pruebas del DOMINIO: sin Flutter, sin audio, sin video, sin imágenes.
import 'package:flutter_test/flutter_test.dart';
import 'package:descubre_dolores/domain/entities/lugar_turistico.dart';
import 'package:descubre_dolores/domain/repositories/lugares_repository.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugar_por_id.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugares.dart';

// Fake: doble de prueba que implementa el contrato del Dominio.
class FakeLugaresRepository implements LugaresRepository {
  static const _lugar = LugarTuristico(
    id: '1',
    nombre: 'Lugar de prueba',
    descripcion: 'Descripcion de prueba',
    imagenAsset: 'x.jpg',
    audioAsset: 'x.mp3',
  );

  @override
  Future<List<LugarTuristico>> obtenerTodos() async => const [_lugar];

  @override
  Future<LugarTuristico?> obtenerPorId(String id) async =>
      id == '1' ? _lugar : null;
}

void main() {
  test('ObtenerLugares regresa la lista que entrega el repositorio', () async {
    final usecase = ObtenerLugares(FakeLugaresRepository());

    final resultado = await usecase();

    expect(resultado.length, 1);
    expect(resultado.first.nombre, 'Lugar de prueba');
  });

  test('ObtenerLugarPorId regresa el lugar cuando el id existe', () async {
    final usecase = ObtenerLugarPorId(FakeLugaresRepository());

    final lugar = await usecase('1');

    expect(lugar, isNotNull);
    expect(lugar!.nombre, 'Lugar de prueba');
  });

  test('ObtenerLugarPorId regresa null cuando el id no existe', () async {
    final usecase = ObtenerLugarPorId(FakeLugaresRepository());

    expect(await usecase('no-existe'), isNull);
  });
}
