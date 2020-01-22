import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:medical/blocs/patient/patient_detail_bloc.dart';
import 'package:medical/event_bus/event_bus.dart';
import 'package:medical/models/event.dart';
import 'package:medical/models/patient.dart';
import 'package:medical/utils/colors.dart';
import 'package:medical/utils/decorations.dart';
import 'package:medical/utils/formats.dart';
import 'package:medical/utils/styles.dart';
import 'package:medical/validators/sign_up_validators.dart';

class CreateScreen extends StatefulWidget {
  final Patient patient;

  const CreateScreen({this.patient});

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> with SignUpValidators {
  Patient get patient => widget.patient;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  PatientDetailBloc _bloc;

  int _gender = 0;

  @override
  void initState() {
    super.initState();
    _bloc = PatientDetailBloc(patient: patient);
    _gender = getGenderType(_bloc.unsavedData.gender);
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
        actions: <Widget>[
          StreamBuilder<bool>(
              stream: _bloc.outCreated,
              initialData: false,
              builder: (context, snapshot) {
                if(snapshot.data){
                  return StreamBuilder<bool>(
                    stream: _bloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: snapshot.data ? null : deletePatient,
                      );
                    }
                  );
                }else{
                  return Container();
                }

              })
        ],
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
              onPressed: snapshot.data ? null : savePatient,
              child: Icon(Icons.save),
            );
          }),
      body: Stack(
        children: <Widget>[
          Form(
            key: _formKey,
            child: StreamBuilder<Patient>(
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
                            initialValue: snapshot.data.name,
                            style: textFormFieldStyle,
                            onSaved: _bloc.saveName,
                            decoration: textFormFieldDecoration(
                                label: "Nome", icon: Icons.person),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: validateNotEmpty,
                            initialValue: snapshot.data.email,
                            onSaved: _bloc.saveEmail,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: textFormFieldDecoration(
                                label: "E-mail", icon: Icons.mail),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            validator: validateNotEmpty,
                            initialValue: snapshot.data.phone,
                            onSaved: _bloc.savePhone,
                            cursorColor: textColor,
                            style: textFormFieldStyle,
                            decoration: textFormFieldDecoration(
                                label: "Telefone", icon: Icons.phone),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DateTimeField(
                            validator: validateDate,
                            initialValue: snapshot.data.dayBirth == null
                                ? null
                                : DateTime.parse(snapshot.data.dayBirth),
                            onSaved: _bloc.saveDayBirth,
                            format: dateFormat,
                            decoration: textFormFieldDecoration(
                                label: "Data", icon: Icons.date_range),
                            style: textFormFieldStyle,
                            onShowPicker: (context, currentValue) {
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));
                            },
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                // color: Colors.black87,
                                border: Border.all(
                                    color: Colors.black26, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: _genderType()),
                          ),
                          SizedBox(
                            height: 8,
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

  void savePatient() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _bloc.unsavedData.gender = _gender == 0 ? "M" : "F";

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Salvando paciente...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
      ));

      bool success = await _bloc.savePatient();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success ? "Paciente salvo com sucesso!" : "Erro ao salvar paciente!",
          style: TextStyle(color: Colors.white),
        ),
      ));

      if (success) {
        EventBus.get(context).sendEvent(Event("salvar", "paciente"));
        Navigator.of(context).pop();
      }
    }
  }

  void deletePatient() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "Deletando paciente...",
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(minutes: 1),
      ));

      bool success = await _bloc.deletePatient();

      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          success
              ? "Paciente deletado com sucesso!"
              : "Erro ao deletar o paciente!",
          style: TextStyle(color: Colors.white),
        ),
      ));

      if (success) {
        EventBus.get(context).sendEvent(Event("deletar", "paciente"));
        int count = 0;
        Navigator.of(context).popUntil((_) => count++ >= 2);      }
    }
  }

  getGenderType(String gender) {
    switch (gender) {
      case 'M':
        return 0;
      case 'F':
        return 1;
      default:
        return 0;
    }
  }

  void _onClickGenderType(int value) {
    setState(() {
      _gender = value;
    });
  }

  _genderType() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          value: 0,
          groupValue: _gender,
          onChanged: _onClickGenderType,
        ),
        Text(
          "Masculino",
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
        Radio(
          value: 1,
          groupValue: _gender,
          onChanged: _onClickGenderType,
        ),
        Text(
          "Feminino",
          style: TextStyle(color: Colors.black87, fontSize: 15),
        ),
      ],
    );
  }
}
