import 'package:flutter_admob_/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class FullScreen extends ConsumerWidget {
  const FullScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insterstialAdAsyncProvider = ref.watch(bannerIntertialProvider);

    ref.listen(bannerIntertialProvider, (previus, next) {
      if (!next.hasValue) return;

      if (next.value == null) return;

      next.value!.show();
    });

    if (insterstialAdAsyncProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text("Carregando add...")),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Nosso Conteudo ")),
    );
  }
}
