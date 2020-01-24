import 'package:flutter/material.dart';
import 'package:medical/blocs/equations/cardio/imc_bloc.dart';
import 'package:medical/blocs/equations/cardio/ldl_bloc.dart';
import 'package:medical/blocs/equations/pulmonary/rva_bloc.dart';
import 'package:medical/blocs/equations/pulmonary/tidal_volume_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/result.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class RvaScreen extends StatefulWidget {
  final int patientId;

  RvaScreen({@required this.patientId});

  @override
  _RvaScreenState createState() => _RvaScreenState();
}

class _RvaScreenState extends State<RvaScreen> with SignUpValidators {

  int get patientId => widget.patientId;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RvaBloc _bloc;

  TextEditingController _ppico = TextEditingController();
  TextEditingController _ppausa = TextEditingController();
  TextEditingController _fluxo = TextEditingController();

  TextEditingController _rva = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = RvaBloc(patientId: patientId);
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
              return Text("RVA(Resistência de vias Aéreas)");
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
                            controller: _ppico,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Ppico", hint: "em cmH2O"),
                            onChanged: (value)  {
                              _rva.text =  _bloc.equation(_ppico.text, _ppausa.text, _fluxo.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                          ),
                          SizedBox(
                            height: 8,
                          ),

                          TextFormField(
                            controller: _ppausa,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Ppausa", hint: "em cmH2O"),
                            onChanged: (value)  {
                              _rva.text =  _bloc.equation(_ppico.text, _ppausa.text, _fluxo.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                          ),
                          SizedBox(
                            height: 8,
                          ),

                          TextFormField(
                            controller: _fluxo,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Fluxo", hint: "em l.s"),
                            onChanged: (value)  {
                              _rva.text =  _bloc.equation(_ppico.text, _ppausa.text, _fluxo.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

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
                            controller: _rva,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "RVA", hint: "Resistência de vias Aéreas"),
//                            keyboardType: TextInputType.numberWithOptions(decimal: true),


                          ),
                          SizedBox(
                            height: 20,
                          ),



                          Text("Ppico: pressão máxima de vias aéreas."),
                          Text("Ppausa: pressão alveolar medida ao final da inspiração por pausa de 2 a 3s."),
                          Text("Fluxo: fluxo quadrado em modo VC")


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

      bool success = await _bloc.save(_rva.text);

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
