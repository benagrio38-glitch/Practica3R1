// CAPA DE PRESENTACIÓN · Vista: detalle con imagen, audio-guía y video.
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/lugar_turistico.dart';
import '../viewmodels/detalle_view_model.dart';

class DetalleLugarScreen extends StatefulWidget {
  final LugarTuristico lugar;
  const DetalleLugarScreen({super.key, required this.lugar});

  @override
  State<DetalleLugarScreen> createState() => _DetalleLugarScreenState();
}

class _DetalleLugarScreenState extends State<DetalleLugarScreen> {
  late final DetalleViewModel _viewModel;
  VideoPlayerController? _videoController;
  bool _videoConError = false;

  @override
  void initState() {
    super.initState();
    _viewModel = DetalleViewModel(widget.lugar);
    final video = widget.lugar.videoAsset;
    if (video != null) {
      _videoController = VideoPlayerController.asset(video);
      _videoController!.initialize().then((_) {
        // mounted: la pantalla pudo cerrarse mientras el video cargaba.
        if (mounted) setState(() {});
      }).catchError((_) {
        if (mounted) setState(() => _videoConError = true);
      });
    }
  }

  // Libera audio y video al salir de la pantalla.
  @override
  void dispose() {
    _viewModel.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = _videoController;
    return Scaffold(
      appBar: AppBar(title: Text(widget.lugar.nombre)),
      body: ListView(
        children: [
          Image.asset(
            widget.lugar.imagenAsset,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const SizedBox(
              height: 220,
              child: Center(child: Icon(Icons.image_not_supported, size: 48)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              widget.lugar.descripcion,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          AnimatedBuilder(
            animation: _viewModel,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _viewModel.alternarAudio,
                    icon: Icon(
                      _viewModel.reproduciendo
                          ? Icons.pause
                          : Icons.headphones,
                    ),
                    label: Text(
                      _viewModel.reproduciendo
                          ? 'Pausar audioguía'
                          : 'Escuchar audioguía',
                    ),
                  ),
                  if (_viewModel.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _viewModel.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_videoConError)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No se pudo cargar el video.'),
            ),
          if (video != null && video.value.isInitialized)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: video.value.aspectRatio,
                    child: VideoPlayer(video),
                  ),
                  IconButton(
                    icon: Icon(
                      video.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                    iconSize: 48,
                    onPressed: () {
                      setState(() {
                        video.value.isPlaying ? video.pause() : video.play();
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
