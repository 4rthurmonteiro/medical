import 'package:flutter/material.dart';
import 'package:medical/blocs/equations/cardio/imc_bloc.dart';
import 'package:medical/blocs/equations/cardio/ldl_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/result.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class IdealWeightScreen extends StatefulWidget {
  final int patientId;

  IdealWeightScreen({@required this.patientId});

  @override
  _IdealWeightScreenState createState() => _IdealWeightScreenState();
}

class _IdealWeightScreenState extends State<IdealWeightScreen> with SignUpValidators {

  int get patientId => widget.patientId;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ImcBloc _bloc;

  TextEditingController _peso = TextEditingController();
  TextEditingController _altura = TextEditingController();
  TextEditingController _imc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = ImcBloc(patientId: patientId);
  }


  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: StreamBuilder<bool>(
            stream: _bloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text("IMC(Íncide de Massa Corporal)");
            }),
      ),
      floatingActionButton: StreamBuilder<bool>(
          stream: _bloc.outLoading,
          initialData: false,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: snapshot.data ? null : saveResult,
              child: Icon(Icons.assignment),
            );
          }),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: StreamBuilder<Result>(
                stream: _bloc.outData,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            controller: _peso,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Peso", hint: "em kg"),
                            onChanged: (value){
                              _imc.text = _bloc.equation(_peso.text, _altura.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _altura,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Altura", hint: "em metros"),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                            onChanged: (value){
                              _imc.text = _bloc.equation(_peso.text, _altura.text);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          Divider(thickness: 5,),

                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            enabled: false,
                            controller: _imc,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "IMC", hint: "IMC"),
//                            keyboardType: TextInputType.numberWithOptions(decimal: true),


                          ),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void saveResult() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Salvando resultado...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
      ));

      bool success = await _bloc.save(_imc.text);

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Resultado salvo com sucesso!" : "Erro ao salvar resultado!",
          style: TextStyle(color: Colors.white),
        ),
      ));

      if (success) {
        EventBus.get(context).sendEvent(Event("salvar", "resultado"));
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 3);      }
    }
  }


}
