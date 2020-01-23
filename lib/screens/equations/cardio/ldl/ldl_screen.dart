import 'package:flutter/material.dart';
import 'package:medical/blocs/equations/cardio/ldl_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/result.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class LdlScreen extends StatefulWidget {
  final int patientId;

  LdlScreen({@required this.patientId});

  @override
  _LdlScreenState createState() => _LdlScreenState();
}

class _LdlScreenState extends State<LdlScreen> with SignUpValidators {

  int get patientId => widget.patientId;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LdlBloc _bloc;

  TextEditingController _ct = TextEditingController();
  TextEditingController _hdl = TextEditingController();
  TextEditingController _tg = TextEditingController();
  TextEditingController _ldl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = LdlBloc(patientId: patientId);
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
              return Text("LDL-Colesterol");
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
                            controller: _ct,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "CT", hint: "em mg/dL"),
                            onChanged: (value){
                              _ldl.text = _bloc.equation(_ct.text, _hdl.text,_tg.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: _hdl,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "HDL", hint: "em mg/dL"),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                            onChanged: (value){
                              _ldl.text = _bloc.equation(_ct.text, _hdl.text,_tg.text);
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          TextFormField(
                            controller: _tg,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "TG", hint: "em mg/dL"),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value){
                              _ldl.text = _bloc.equation(_ct.text, _hdl.text,_tg.text);
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
                            controller: _ldl,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "LDL", hint: "em mg/dL"),
//                            keyboardType: TextInputType.numberWithOptions(decimal: true),


                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text("LDL: LDL-colesterol"),
                          Text("CT: colesterol total"),
                          Text("HDL: HDL-colesterol"),
                          Text("TG: triglicerídeos")
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

      bool success = await _bloc.save(_ldl.text);

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
