// CAPA DE PRESENTACIÓN · Vista: lista de lugares.
import 'package:flutter/material.dart';
import '../viewmodels/lugares_view_model.dart';
import 'detalle_lugar_screen.dart';

class ListaLugaresScreen extends StatefulWidget {
  final LugaresViewModel viewModel;
  const ListaLugaresScreen({super.key, required this.viewModel});

  @override
  State<ListaLugaresScreen> createState() => _ListaLugaresScreenState();
}

class _ListaLugaresScreenState extends State<ListaLugaresScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.cargar();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder se redibuja cada vez que el ViewModel avisa un cambio.
    return AnimatedBuilder(
      animation: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.cargando) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (widget.viewModel.error != null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Descubre Dolores Hidalgo')),
            body: Center(child: Text(widget.viewModel.error!)),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('Descubre Dolores Hidalgo')),
          body: ListView.builder(
            itemCount: widget.viewModel.lugares.length,
            itemBuilder: (context, i) {
              final lugar = widget.viewModel.lugares[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    lugar.imagenAsset,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    // Si falta la imagen, muestra un ícono en lugar de fallar.
                    errorBuilder: (_, _, _) => const SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                title: Text(lugar.nombre),
                subtitle: Text(
                  lugar.descripcion,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetalleLugarScreen(lugar: lugar),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
