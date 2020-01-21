import 'package:flutter/material.dart';
import 'package:medical/blocs/equations/mean_blood_pressure_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/result.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class MeanBloodPressureScreen extends StatefulWidget {
  @override
  _MeanBloodPressureScreenState createState() => _MeanBloodPressureScreenState();
}

class _MeanBloodPressureScreenState extends State<MeanBloodPressureScreen> with SignUpValidators {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MeanBloodPressureBloc _bloc;


  @override
  void initState() {
    super.initState();
    _bloc = MeanBloodPressureBloc();
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
        title: StreamBuilder<bool>(
            stream: _bloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              return Text(
                  snapshot.data ? "Editar paciente" : "Cadastrar paciente");
            }),
      ),
      floatingActionButton: StreamBuilder<bool>(
          stream: _bloc.outLoading,
          initialData: false,
          builder: (context, snapshot) {
            return FloatingActionButton(
              onPressed: snapshot.data ? null : saveResult,
              child: Icon(Icons.save),
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
                        children: <Widget>[
                          TextFormField(
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            onSaved: _bloc.savePAS,
                            decoration: equationDecoration(
                                label: "PAS", hint: "em mmHg"),
                            keyboardType: TextInputType.number,

                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: validateNotEmpty,
                            onSaved: _bloc.savePAS,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "PAD", hint: "em mmHg"),
                            keyboardType: TextInputType.number,
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

      bool success = await _bloc.save();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Resultado salvo com sucesso!" : "Erro ao salvar resultado!",
          style: TextStyle(color: Colors.white),
        ),
      ));

      if (success) {
        EventBus.get(context).sendEvent(Event("salvar", "resultado"));
        Navigator.of(context).pop();
      }
    }
  }

}
