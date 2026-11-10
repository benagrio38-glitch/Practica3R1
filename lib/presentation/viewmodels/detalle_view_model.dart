// CAPA DE PRESENTACIÓN · ViewModel del detalle: controla la audio-guía.
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import '../../domain/entities/lugar_turistico.dart';

class DetalleViewModel extends ChangeNotifier {
  final LugarTuristico lugar;
  final AudioPlayer _reproductor;
  StreamSubscription<void>? _suscripcionFin;

  bool reproduciendo = false;
  bool _enPausa = false;
  String? error;

  // El reproductor se puede inyectar (útil para pruebas); si no, se crea uno.
  DetalleViewModel(this.lugar, {AudioPlayer? reproductor})
      : _reproductor = reproductor ?? AudioPlayer() {
    // Cuando el audio termina, el botón vuelve a "Escuchar".
    _suscripcionFin = _reproductor.onPlayerComplete.listen((_) {
      reproduciendo = false;
      _enPausa = false;
      notifyListeners();
    });
  }

  Future<void> alternarAudio() async {
    try {
      error = null;
      if (reproduciendo) {
        await _reproductor.pause();
        reproduciendo = false;
        _enPausa = true;
      } else if (_enPausa) {
        await _reproductor.resume();
        reproduciendo = true;
        _enPausa = false;
      } else {
        await _reproductor.play(AssetSource(lugar.audioAsset));
        reproduciendo = true;
      }
    } catch (e) {
      error = 'No se pudo reproducir la audio-guía.';
      reproduciendo = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _suscripcionFin?.cancel();
    _reproductor.dispose();
    super.dispose();
  }
}
