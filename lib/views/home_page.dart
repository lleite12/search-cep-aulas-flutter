import 'package:flutter/material.dart';
import 'package:search_cep/models/result_cep.dart';
import 'package:search_cep/services/via_cep_service.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String _result;

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar CEP'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: ()
              {
                changeBrightness();
              },
              ),
          IconButton(
            icon: Icon(Icons.share),  
            onPressed: ()
              {
                Share.share("CEP: ${resultCep.cep ?? ""} \n" +
                            "UF: ${resultCep.uf ?? ""} \n" +
                            "CIDADE: ${resultCep.localidade ?? ""} \n" +
                            "BAIRRO: ${resultCep.bairro ?? ""} \n" +
                            "LOGRADOURO: ${resultCep.logradouro ?? ""}");
              },          
              )
              ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSearchCepTextField(),
            _buildSearchCepButton(),
            _buildResultForm()
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(labelText: 'Cep'),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }

  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RaisedButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('Consultar'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _searching(bool enable) {
    setState(() {
      _result = enable ? '' : _result;
      _loading = enable;
      _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  ResultCep resultCep = new ResultCep();

  Future _searchCep() async {
    _searching(true);

    final cep = _searchCepController.text;

    resultCep = await ViaCepService.fetchCep(cep: cep);

    setState(() {
      _result = resultCep.toJson();
    });

    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          _text("CEP", resultCep.cep),
          _text("UF", resultCep.uf),
          _text("CIDADE", resultCep.localidade),
          _text("BAIRRO", resultCep.bairro),
          _text("LOGRADOURO", resultCep.logradouro)
        ],        
      ),      
    );
  }

  Widget _text(label,value){

    final myController = TextEditingController();
    myController.text = value;

    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: myController,
      enabled: false         
      );

  }

  void changeBrightness() {
        DynamicTheme.of(context).setBrightness(Theme.of(context).brightness == Brightness.dark? Brightness.light: Brightness.dark);
  }
  
}

 
  