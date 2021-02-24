import 'package:apiMusica/controllerApi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Letras de músicas',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'LYRICS'),
    );
  }
}

class Home extends StatelessWidget {
  final String title;
  Home({this.title});

  final resultApi = Get.put(ApiResult());
  final TextEditingController _nomeBanda = TextEditingController(text: 'Deep Purple');
  final TextEditingController _nomeDaMusica = TextEditingController(text: 'Lazy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.local_fire_department_outlined,
          size: 30,
          color: Colors.red,
        ),
        title: Text(
          title,
          style: GoogleFonts.getFont(
            'Metal Mania',
            letterSpacing: 4,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(8),
              height: Get.height * 0.63,
              width: double.maxFinite,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 10),
                child: Obx(
                  () => Column(
                    children: [
                      if (resultApi.carregandoMusica.value)
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            backgroundColor: Colors.grey,
                            valueColor: AlwaysStoppedAnimation(Colors.black),
                          ),
                        ),
                      if (!resultApi.carregandoMusica.value && resultApi.nomeArtista.value.isNotEmpty)
                        Text(
                          resultApi.nomeArtista.value.trim().capitalize,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      const SizedBox(height: 20),
                      if (resultApi.carregandoMusica.value)
                        SizedBox(
                          height: Get.height * 0.50,
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.black),
                            ),
                          ),
                        ),
                      if (resultApi.mensagemErro.value.isNotEmpty)
                        SizedBox(
                          height: Get.height * 0.50,
                          child: Center(
                            child: Text(
                              resultApi.mensagemErro.value,
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      if (resultApi.letraMusica.value.isNotEmpty)
                        Container(
                          height: double.maxFinite,
                          child: Text(
                            resultApi.letraMusica.value,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            textScaleFactor: 1,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      if (resultApi.nomeArtista.value.isEmpty)
                        Center(
                          child: SizedBox(
                            height: Get.height * 0.50,
                            child: Center(
                              child: Icon(
                                Icons.menu_book_outlined,
                                size: 150,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 7,
                  child: Text(
                    'Nome da banda / artista: ',
                    style: GoogleFonts.getFont(
                      'Metal Mania',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: _nomeBanda,
                      decoration: InputDecoration(
                        hintText: 'Nome do artista ou banda',
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Flexible(
                  flex: 7,
                  child: Text(
                    'Nome da música: ',
                    style: GoogleFonts.getFont(
                      'Metal Mania',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: TextFormField(
                        controller: _nomeDaMusica,
                        decoration: InputDecoration(
                          hintText: 'Nome da música',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.black,
          onPressed: () {
            resultApi.getHttp(
              artista: _nomeBanda.text,
              musica: _nomeDaMusica.text,
            );
          },
          splashColor: Colors.white,
          child: Icon(
            Icons.search,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
