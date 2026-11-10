// ============================================================
// Práctica 3: Descubre Dolores Hidalgo (Arquitectura Limpia)
// Alumno: Oscar Manuel Ayala Ortiz
// Grupo: GTID232 · Núm. de control: 1225100756
// Materia: Desarrollo Móvil Integral
// ============================================================
//
// main.dart es la "raíz de composición" (composition root): el ÚNICO
// archivo que conoce las clases concretas de las 3 capas y las conecta.
import 'package:flutter/material.dart';
import 'data/datasources/lugares_local_datasource.dart';
import 'data/repositories/lugares_repository_impl.dart';
import 'domain/usecases/obtener_lugares.dart';
import 'presentation/viewmodels/lugares_view_model.dart';
import 'presentation/views/lista_lugares_screen.dart';

void main() {
  // Composición manual de dependencias, de adentro hacia afuera.
  final dataSource = LugaresLocalDataSource();
  final repository = LugaresRepositoryImpl(dataSource);
  final obtenerLugares = ObtenerLugares(repository);
  final viewModel = LugaresViewModel(obtenerLugares);
  runApp(DescubreDoloresApp(viewModel: viewModel));
}

class DescubreDoloresApp extends StatelessWidget {
  final LugaresViewModel viewModel;
  const DescubreDoloresApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descubre Dolores Hidalgo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: ListaLugaresScreen(viewModel: viewModel),
    );
  }
}
