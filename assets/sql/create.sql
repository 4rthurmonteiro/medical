CREATE TABLE Pacientes(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, dataNascimento TEXT, genero TEXT, email TEXT, telefone TEXT);
CREATE TABLE Resultados(id INTEGER PRIMARY KEY AUTOINCREMENT, pacienteId INTEGER, equacao TEXT,categoria TEXT, profissional TEXT, resultadoValor TEXT, resultado TEXT);

