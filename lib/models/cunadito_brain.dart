class CunaditoBrain {
  static final Map<String, List<String>> _respuestas = {
    'coche': [
      'Eso lo arreglas tú con cinta americana y un poco de fe.',
      '¿No será la correa de distribución? Eso lo vi en un vídeo.',
      'Taller caro. Mejor llama a tu cuñado, hombre.',
    ],
    'dinero': [
      'Yo ya te lo dije: criptomonedas. Pero claro, tú sabrás.',
      'Eso es fácil: invierte en jamones y vivienda. Siempre suben.',
      'A ver, ahorrar está sobrevalorado... tú gasta que pa’ eso está.',
    ],
    'hola': [
      '¡Hombre, cuánto tiempo! ¿Ya vienes a pedir consejo otra vez?',
      '¡Qué pasa, máquina!',
      'Aquí el único que sabe de todo: yo. ¿Qué necesitas?',
    ],
    'trabajo': [
      'Yo en tu lugar me haría autónomo. Libertad total, y ruina también.',
      'Busca en LinkedIn, o en el bar... depende lo que quieras.',
      '¿Trabajar? Yo prefiero vivir, gracias.',
    ],
  };

  static String responder(String mensaje) {
    mensaje = mensaje.toLowerCase();

    for (final tema in _respuestas.keys) {
      if (mensaje.contains(tema)) {
        final respuestas = _respuestas[tema]!;
        respuestas.shuffle();
        return respuestas.first;
      }
    }

    final generales = [
      'Eso no lo sé, pero te lo digo con seguridad igualmente.',
      'No tengo pruebas, pero tampoco dudas.',
      'Si me hubieras preguntado antes, te lo habría dicho mejor.',
      'Eso lo sabe cualquiera, hombre... menos tú.',
    ];

    generales.shuffle();
    return generales.first;
  }
}
