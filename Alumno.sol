//SPDX-License-Identifier: MIT

 pragma solidity ^0.8.10;

 contract Estudiante{

 
    string private _nombre;
    string private _apellido;
    string private _curso;
    address private _docente;
    mapping (string => uint) private notas_materias;
    string[] private _nombre_materias;
    
    constructor (string memory nombre_, string memory apellido_, string memory curso_)
    {
        _nombre = nombre_;
        _apellido = apellido_;
        _curso = curso_;
        _docente = msg.sender;
    }


    function apellido() public view returns (string memory){
        return _apellido;
    }

    function nombre_completo() public view returns(string memory){

        return string(abi.encodePacked (_nombre,' ', _apellido));
    }

    function curso() public view returns (string memory){
        return _curso;
    }

    function set_nota_materia(uint nota, string memory materia) public {
        require (_docente == msg.sender, "Solo el docente puede asignar notas");
        require (nota>=1 && nota<=100, "La nota debe ser un entero del 1 al 100");
        notas_materias[materia] = nota;
        _nombre_materias.push(materia);
    }

    function aprobo(string memory materia) public view returns (bool){
        if (notas_materias[materia] >= 60){
            return true;
        }

        else {
            return false;
        }
    }

    function nota_materia(string memory materia) public view returns (uint) {
        
        return notas_materias[materia];
    }

    function promedio() public view returns (uint){
        
        uint  _promedio;
        uint _sumaDeNotas;
        uint _cantMaterias = _nombre_materias.length;

        for (uint i = 0; i < _cantMaterias; i++) {
            _sumaDeNotas += notas_materias[_nombre_materias[i]];
        }
        _promedio = _sumaDeNotas/_cantMaterias;
        return _promedio;
    }
}
