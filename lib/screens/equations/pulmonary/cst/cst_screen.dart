import 'package:flutter/material.dart';
import 'package:medical/blocs/equations/cardio/imc_bloc.dart';
import 'package:medical/blocs/equations/cardio/ldl_bloc.dart';
import 'package:medical/blocs/equations/pulmonary/cst_bloc.dart';
import 'package:medical/blocs/equations/pulmonary/rva_bloc.dart';
import 'package:medical/blocs/equations/pulmonary/tidal_volume_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/result.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class CstScreen extends StatefulWidget {
  final int patientId;

  CstScreen({@required this.patientId});

  @override
  _CstScreenState createState() => _CstScreenState();
}

class _CstScreenState extends State<CstScreen> with SignUpValidators {

  int get patientId => widget.patientId;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CstBloc _bloc;

  TextEditingController _vc = TextEditingController();
  TextEditingController _ppausa = TextEditingController();
  TextEditingController _peep = TextEditingController();

  TextEditingController _cst = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = CstBloc(patientId: patientId);
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
              return Text("CST (Complacência estática)");
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
                            controller: _vc,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "VC", hint: "em ml/kg"),
                            onChanged: (value)  {
                              _cst.text =  _bloc.equation(_vc.text, _ppausa.text, _peep.text);
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
                              _cst.text =  _bloc.equation(_vc.text, _ppausa.text, _peep.text);
                            },
                            keyboardType: TextInputType.numberWithOptions(decimal: true),

                          ),
                          SizedBox(
                            height: 8,
                          ),

                          TextFormField(
                            controller: _peep,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "Fluxo", hint: "em l.s"),
                            onChanged: (value)  {
                              _cst.text =  _bloc.equation(_vc.text, _ppausa.text, _peep.text);
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
                            controller: _cst,
                            validator: validateNotEmpty,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: equationDecoration(
                                label: "CST", hint: "Complacência estática"),
//                            keyboardType: TextInputType.numberWithOptions(decimal: true),


                          ),
                          SizedBox(
                            height: 20,
                          ),



                          Text("VC: volume correntes."),
                          Text("Ppausa: pressão alveolar medida ao final da inspiração por pausa de 2 a 3s."),
                          Text("PEEP: pressão alveolar medida ao final da expiração por pausa de 3s.")


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

      bool success = await _bloc.save(_peep.text);

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
