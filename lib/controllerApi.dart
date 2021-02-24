import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiResult extends GetxController {
  RxString nomeArtista = ''.obs;
  RxString letraMusica = ''.obs;
  RxString mensagemErro = ''.obs;
  RxBool carregandoMusica = false.obs;

  Future<void> getHttp({String artista, String musica}) async {
    nomeArtista.value = artista;
    letraMusica.value = '';
    mensagemErro.value = '';
    carregandoMusica.value = true;
    try {
      BaseOptions options = BaseOptions(
        baseUrl: 'https://api.lyrics.ovh/v1/$artista/$musica',
        connectTimeout: 5000,
        receiveTimeout: 5000,
        method: 'GET',
      );
      Dio dio = Dio(options);
      var response = await dio.get(options.baseUrl);
      letraMusica.value = response.data['lyrics'].toString().trim();
      if (letraMusica.value.isEmpty) {
        nomeArtista.value = '';
        mensagemErro.value = 'O artista ou o nome\n da música está errado kkkkk';
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.type);
      switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          mensagemErro.value = "Está demorando\npara se comunicar a API :(";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          mensagemErro.value = "Está demorando\npara se comunicar a API :(";
          break;
        case DioErrorType.RESPONSE:
          mensagemErro.value = 'O artista ou o nome\n da música está errado kkkkk';
          break;

        default:
      }
    } finally {
      carregandoMusica.value = false;
    }
  }
}
