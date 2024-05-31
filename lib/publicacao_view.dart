import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:inventar/Model/publicacao_model.dart';
import 'package:inventar/database.dart';

class PublicacaoView extends StatefulWidget {
  const PublicacaoView({super.key});

  @override
  State<PublicacaoView> createState() => _PublicacaoViewState();
}

class _PublicacaoViewState extends State<PublicacaoView> {
  late Future<List<PublicacaoModel>> futurePublicacoes;

  @override
  void initState() {
    super.initState();
    futurePublicacoes = buscarDados();
  }

  Future<List<PublicacaoModel>> buscarDados() async {
    DatabaseHelper dbHelper = DatabaseHelper();
    List<PublicacaoModel> publicacoes = await dbHelper.buscarPublicacoes();
    return publicacoes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Inventario"),
      ),
      body: FutureBuilder<List<PublicacaoModel>>(
        future: futurePublicacoes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma publicação encontrada.'));
          } else {
            List<PublicacaoModel> publicacoes = snapshot.data!;
            var groupedPublicacoes =
                groupBy(publicacoes, (PublicacaoModel p) => p.tipoId);

            return ListView(
              children: groupedPublicacoes.entries.map((entry) {
                var tipoId = entry.key;
                var publicacoesDoTipo = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (tipoId == 1)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Biblia", style: TextStyle(fontSize: 30)),
                      ),
                    if (tipoId == 2)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Kit de Ferramentas de Ensino",
                            style: TextStyle(fontSize: 30)),
                      ),
                    if (tipoId == 3)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Livros", style: TextStyle(fontSize: 30)),
                      ),
                    if (tipoId == 4)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Brochuras e livretos",
                            style: TextStyle(fontSize: 30)),
                      ),
                    if (tipoId == 5)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Revistas — edição para o publico",
                            style: TextStyle(fontSize: 30)),
                      ),
                    if (tipoId == 6)
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child:
                            Text("Formularios", style: TextStyle(fontSize: 30)),
                      ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 250,
                      ),
                      itemCount: publicacoesDoTipo.length,
                      itemBuilder: (context, index) {
                        var publicacao = publicacoesDoTipo[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              print(publicacao.id);
                              print(publicacao.sigla);
                              print(publicacao.excelRow);
                            },
                            child: PublicacaoCard(publicacao: publicacao),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

class PublicacaoCard extends StatelessWidget {
  final PublicacaoModel publicacao;

  const PublicacaoCard({required this.publicacao});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              image: DecorationImage(
                image: AssetImage('assets/imgs/wp22.1.jpeg'), //test
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    publicacao.nome,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        publicacao.quantidade.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        publicacao.sigla,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
