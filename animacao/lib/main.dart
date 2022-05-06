import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const PageAnimada());
}

class PageAnimada extends StatefulWidget {
  const PageAnimada({ Key? key }) : super(key: key);

  @override
  State<PageAnimada> createState() => _PageAnimadaState();
}

class _PageAnimadaState extends State<PageAnimada> {

  final numberPage = 3;
  int currentPage = 0;
  Color corFundo = Colors.yellow;
  Color corLetra = Colors.blue;

  PageController _pageController = PageController(initialPage: 0);
  List<Widget> listAnimation() {
    List<Widget> listaAnimada = [];
    for (int i = 0; i < numberPage; i++) {
      listaAnimada.add(i == currentPage ? marcaPage(true) : marcaPage(false));
    }
    return listaAnimada;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: corFundo,
        appBar: AppBar(
        leading: currentPage != 0 ? IconButton(onPressed: () {
          _pageController.previousPage(duration: 
          Duration(milliseconds: 300), 
          curve: Curves.easeIn);
        }, 
        icon: Icon(Icons.arrow_back_ios_new, color: corLetra),) : null,
        backgroundColor: corFundo,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Pular', 
            style: TextStyle(color: corLetra),),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int contPage) {
              setState(() {
                currentPage = contPage;
              });
            },
            children: [
              Lottie.asset('assets/duvida.zip'),
              Lottie.asset('assets/pokebola.zip'),
              Lottie.asset('assets/squirtle.zip'),
            ],
          )),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: listAnimation(),
          ),
          const SizedBox(height: 35),
          Text(textoPage(), 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: corLetra),
          ),
          const SizedBox(height: 60),
          MaterialButton(onPressed: () {
            currentPage != 2 ? _pageController.nextPage(
              duration: const Duration(milliseconds: 500), 
            curve: Curves.easeIn) : _pageController.jumpToPage(0);
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(currentPage != 2 ? 'Próximo' : 'Fim',
            style: TextStyle(color: corFundo),),
          ),
          color: corLetra,
          
          ),
        ],
        ),
      ),
      ),      
    );
  }
  Widget marcaPage(bool marcar) {
    return AnimatedContainer(duration: const Duration(microseconds: 150),
      height: 15,
      width: 15,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: marcar ? corLetra : corFundo,
        border: Border.all(color: corLetra),
        borderRadius: BorderRadius.circular(7.5),
      ),
    );
  }
  String textoPage() {
    switch (currentPage) {
      case 0:
        return 'Qual será seu primeiro pokemon?';
      case 1:
        return 'Está curioso?';
      case 2:
        return 'É um SQUIRTLE, boa sorte com seu novo companheiro';
      default:
        return '';
    }
  }
}