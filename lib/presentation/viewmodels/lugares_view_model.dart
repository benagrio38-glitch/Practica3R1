// CAPA DE PRESENTACIÓN · ViewModel de la lista (MVVM).
// Solo conoce el caso de uso: nunca el repositorio ni la fuente de datos.
import 'package:flutter/foundation.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../../domain/usecases/obtener_lugares.dart';

class LugaresViewModel extends ChangeNotifier {
  final ObtenerLugares obtenerLugares;
  LugaresViewModel(this.obtenerLugares);

  List<LugarTuristico> _lugares = [];
  List<LugarTuristico> get lugares => _lugares;

  bool _cargando = false;
  bool get cargando => _cargando;

  // Mensaje de error para la vista (null = todo bien).
  String? _error;
  String? get error => _error;

  Future<void> cargar() async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      _lugares = await obtenerLugares();
    } catch (e) {
      _error = 'No se pudieron cargar los lugares.';
    }
    _cargando = false;
    notifyListeners();
  }
}
