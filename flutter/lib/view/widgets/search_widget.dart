import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget{
  String title;
  String routNameForm;

  List<dynamic> results;

  Widget Function(BuildContext context, int index) onitemBuilder;

  Function() updateListView; 
  Function(String value)? filtraResultados; 

  // TextEditingController _searchController = TextEditingController();


  SearchWidget({
    super.key,
    required this.title, 
    required this.routNameForm, 
    required this.results, 
    required this.onitemBuilder,
    required this.updateListView, 
    required this.filtraResultados 
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async{
          await Navigator.pushNamed(context, routNameForm);
          updateListView();
          })
      );
  }

  Widget _body(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        _createSearchTextField(context),
        const SizedBox(height: 16),
        _createListView(context)
      ],
      )
    );
  }

  Widget _createSearchTextField(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child:TextField(
            onChanged: (value) => filtraResultados!(value),  // Update the results list when the user types
            // controller: _searchController,
            decoration: const InputDecoration(
              labelText: "Pesquisar...", 
              suffixIcon: Icon(Icons.search)))
        )
      ],
    );
  }

  Widget _createListView(BuildContext context) {
    if (results.isEmpty)
    {
      return const Text("Nenhum dado encontrado",
      style: TextStyle(fontSize: 20));
    }
    else {
      return Expanded(
      child: SizedBox(
        height: 150,
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: onitemBuilder,
        ),
      ));
    }
  }
}
