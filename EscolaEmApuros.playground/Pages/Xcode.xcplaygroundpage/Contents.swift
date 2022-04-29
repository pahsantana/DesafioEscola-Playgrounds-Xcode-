/*:
## Xcode.
 
 A prefeitura de Townsville te dá os parabéns pela conclusão do treinamento.
 
 Agora que você já é uma pessoa Jedi completa, é hora de você fazer o real desafio no Xcode!
 
 No template que vocês vão baixar, a *User Interface* já estará feita.
 
 Será necessário que você transporte o seu sistema gerenciador de escolas (parcialmente ou totalmente feito aqui no *Playgrounds*) para lá!
 
 Abaixo, segue a descrição completa do sistema que a prefeitura necessita.
 
 > Toda **ESCOLA** possui **COLABORADORES**.
 >
 > Todos os **COLABORADORES** possuem **NOME**, **MATRÍCULA**, **SALÁRIO** e **CARGO**.
 >
 > -> Os **CARGOS** disponíveis são: **MONITOR**, **PROFESSOR**, **COORDENADOR**, **DIRETOR** e **ASSISTENTE**.
 >
 > -> A **MATRÍCULA** é uma propriedade única (ID), ou seja, não se repete (como um CPF).
 >
 > -> O **SALÁRIO** pode conter qualquer valor (crise pra quem?), mas o maior salário deve ser sempre o do **DIRETOR**.
 >
 > -> A **ESCOLA** não pode ter mais do que um **DIRETOR**.
 >
 > -> A **ESCOLA** não pode ter mais **COORDENADORES** do que **PROFESSORES**.
 >
 > Todas os **COLABORADORES** devem ser capazes de:
 >
 > - Se apresentar dizendo nome, matrícula e cargo (Ex: "Meu nome é **NOME**, sou **CARGO** e minha matrícula é **MATRÍCULA**").
 > - Se apresentar dizendo cargo abreviado e nome (Ex: Eu sou Dir. Renan)
 >    - Monitor = Mntr.
 >    - Professor = Prof.
 >    - Coordenador = Coord.
 >    - Diretor = Dir.
 >    - Assistente = Asst.
 >
 > A **ESCOLA** deve ser capaz de:
 >
 > - Cadastrar novos colaboradores;
 > - Remover colaboradores através da matrícula;
 >
 > - Listar gastos mensais com todas as pessoas colaboradoras;
 > - Listar gastos mensais por cargo (quanto é gasto com monitor, quanto é gasto com professor, etc.);
 > - Listar quantas pessoas existem por cargo (quantos monitores, quantos professores, etc.);
 > - Listar os nomes de todos os colaboradores em ordem alfabética.
 
 **[DESAFIO]** Implementar esse sistema em um projeto Xcode de verdade!
 
 PS: Tudo bem se quiser implementar e testar aqui antes 😉.
 
 [Anterior: Sistema](@previous) | Página 6 de 6
 */
import Foundation

enum Cargos {
    case monitor,professor,coordenador,diretor,assistente
}

struct Colaborador {
    let nome: String
    let matricula: Int
    let salario: Float
    let cargo: Cargos
    
    func Apresentacao()->String{
        return "Olá, meu nome é \(nome), minha matricula é \(matricula) e meu cargo é \(cargo)"
    }
    
    func ApresentacaoCargoAbreviadoNome()->String{
        
        var nomenclatura: String = ""
        
        switch cargo{
            case .monitor:
                nomenclatura = "Mntr."
            case .professor:
                nomenclatura="Prof."
            case .coordenador:
                nomenclatura="Coord."
            case .diretor:
                nomenclatura="Dir."
            case .assistente:
                nomenclatura="Asst."
        }
    
        
        return "Eu sou \(nomenclatura) \(nome)"
    }
}

var colaboradores: [Colaborador] = []

let paloma = Colaborador(nome: "Paloma", matricula: 1234, salario: 5481.21, cargo: .diretor)

paloma.ApresentacaoCargoAbreviadoNome()

let daniel = Colaborador(nome: "Daniel", matricula: 4567, salario: 3000.00, cargo: .coordenador)

let marcelo = Colaborador(nome: "Marcelo", matricula: 4758, salario: 4000.00, cargo: .professor)

let simone = Colaborador(nome: "Simone", matricula: 8970, salario: 1400.00, cargo: .professor)

let gilberto = Colaborador(nome: "Gilberto", matricula: 6547, salario: 1000.00, cargo: .professor)

// Cadastrar novos colaboradores
func cadastrarColaborador(novoColaborador: Colaborador){
    
    if(numeroPessoasPor(cargo: .diretor)==1 && novoColaborador.cargo == .diretor){
        fatalError("A escola não pode ter mais de um diretor contando contigo \(novoColaborador.nome)")
    }
    if(novoColaborador.salario > listarGastosMensaisPor(cargo: .diretor) && numeroPessoasPor(cargo: .diretor)==1){
        fatalError("O salário do colaborador \(novoColaborador.nome) não pode ser maior do que o do diretor")
    }
    if(novoColaborador.cargo == .coordenador){
        if(numeroPessoasPor(cargo: .coordenador)+1>numeroPessoasPor(cargo: .professor)){
            fatalError("A escola não pode ter mais coordenadores contando contigo \(novoColaborador.nome) do que professores")
        }
    }
    
    if(novoColaborador.cargo == .professor){
        if(numeroPessoasPor(cargo: .coordenador)>numeroPessoasPor(cargo: .professor)+1){
            fatalError("A escola não pode ter mais coordenadores do que professores contando contigo \(novoColaborador.nome)")
        }
    }
    
    colaboradores.append(novoColaborador)
    print(colaboradores)
    print("Adicionamos o colaborador de nome \(novoColaborador.nome) a nossa lista de colaboradores")
}


cadastrarColaborador(novoColaborador: paloma)
cadastrarColaborador(novoColaborador: gilberto)
cadastrarColaborador(novoColaborador: daniel)
cadastrarColaborador(novoColaborador: marcelo)
cadastrarColaborador(novoColaborador: simone)

//Remover colaboradores através de sua matrícula
func removerColaborador(porMatricula matricula:Int){
    for posicao in 0..<colaboradores.count-1{
        let colaboradorSelecionado = colaboradores[posicao]
        if colaboradorSelecionado.matricula == matricula {
            colaboradores.remove(at: posicao)
        }
    }
}

removerColaborador(porMatricula: 4567)
print(colaboradores)


func listarGastosMensaisTodos()->Float{
    
    return colaboradores.map{$0.salario}.reduce(0, +)
}

func listarGastosMensaisPor(cargo cargoConsultado:Cargos)->Float{
    
    return colaboradores.filter{$0.cargo == cargoConsultado}.map{$0.salario}.reduce(0, +)
}

func numeroPessoasPor(cargo cargoConsultado:Cargos)->Int{
    
    return colaboradores.filter{$0.cargo == cargoConsultado}.count
}

func listarColaboradoresAlfabetico(){
    let colaboradoresOrganizados = colaboradores.sorted{$0.nome.compare($1.nome, locale: Locale.current) == .orderedAscending }
    for posicao in 0..<colaboradoresOrganizados.count{
        print(colaboradoresOrganizados[posicao].nome)
    }
}

listarGastosMensaisTodos()

listarGastosMensaisPor(cargo: .professor)

numeroPessoasPor(cargo: .professor)

listarColaboradoresAlfabetico()


// Listar gastos mensais com todos os colaboradores

func gastosMensais()->Float{
    var gastosMensais: Float = 0.00
    for posicao in 0..<colaboradores.count{
        gastosMensais+=colaboradores[posicao].salario
    }
    return gastosMensais
    
}

// Listar gastos mensais por cargo(quanto é gasto com monitor, quanto é gasto com professor,etc.)

func gastosMensaisPorCargo(cargo: Cargos)->Float{
    
    var gastosMensais: Float = 0.00
    for posicao in 0..<colaboradores.count{
        let cargoSelecionado =
        colaboradores[posicao].cargo
        if cargoSelecionado == cargo{
            gastosMensais+=colaboradores[posicao].salario
        }
    }
    return gastosMensais
}

//Listar quantas pessoas existem por cargo (quantos monitores, quantos professores, etc.)

func numeroDePessoasPorCargo(cargo: Cargos)-> Int{
    
    var contador: Int = 0
    
    for posicao in 0..<colaboradores.count{
        let cargoSelecionado =
        colaboradores[posicao].cargo
        if cargoSelecionado == cargo{
            contador+=1
        }
    }
    
    return contador
    
}

// Listar os nomes de todos os colaboradores em ordem alfabética

func listaColaboradoresEmOrdemAlfabetica(){
    var nomes: [String] = []
    for posicao in 0..<colaboradores.count{
        nomes.append(colaboradores[posicao].nome)
    }
    nomes.sort()
    print(nomes)
}



