// CAPA DE DOMINIO · Entidad.
// Dart puro: no importa Flutter ni ningún paquete externo.
class LugarTuristico {
  final String id;
  final String nombre;
  final String descripcion;
  final String imagenAsset; // ruta completa: assets/images/...
  final String audioAsset; // ruta SIN 'assets/' (audioplayers ya la asume)
  final String? videoAsset; // opcional: no todos los lugares tienen video

  const LugarTuristico({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenAsset,
    required this.audioAsset,
    this.videoAsset,
  });
}
