//
//  ViewController.swift
//  SistemaEscola
//
//  Created by Renan Trévia on 2/11/22.
//  Copyright © 2022 Eldorado. All rights reserved.
//

import UIKit

// Sugiro que utilizem esse Enum pois eu já deixei preparado para os botões, mas sintam-se à vontade para alterar para uma estrutura melhor caso sintam essa necessidade.
enum Cargo {
    case monitor, professor, coordenador, diretor, assistente
}

// MARK: STRUCT COLABORADOR
struct Colaborador {
    let nome: String
    let salario: Float
    let matricula: Int
    let cargo: Cargo
    
    func apresentacao()->String{
        return "Olá, meu nome é \(nome), minha matrícula é \(matricula) e meu cargo é \(cargo)"
    }
    
    func apresentacaoResumida()->String{
        var abreviacao: String = ""
        switch cargo{
            
        case .monitor:
            abreviacao="Mntr."
        case .professor:
            abreviacao="Prof."
        case .coordenador:
            abreviacao="Coord."
        case .diretor:
            abreviacao="Dir."
        case .assistente:
            abreviacao="Asst."
        }
        return "Olá, eu sou o \(abreviacao) \(nome)"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var outputMessage: UILabel!
    
    @IBOutlet weak var matriculaTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var salarioTextField: UITextField!
    
    @IBOutlet weak var monitorButton: UIButton!
    @IBOutlet weak var professorButton: UIButton!
    @IBOutlet weak var coordenadorButton: UIButton!
    @IBOutlet weak var diretorButton: UIButton!
    @IBOutlet weak var assistenteButton: UIButton!
    
    @IBOutlet weak var removeMatriculaTextField: UITextField!
    
    var cargoSelecionado: Cargo = .monitor
    var colaboradores = [Colaborador]()
    //var nomes: [String] = []
    
    @IBAction func selecionaMonitor(_ sender: UIButton) {
        cargoSelecionado = .monitor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaProfessor(_ sender: UIButton) {
        cargoSelecionado = .professor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaCoordenador(_ sender: UIButton) {
        cargoSelecionado = .coordenador
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaDiretor(_ sender: UIButton) {
        cargoSelecionado = .diretor
        selecionaBotao(botao: sender)
    }
    
    @IBAction func selecionaAssistente(_ sender: UIButton) {
        cargoSelecionado = .assistente
        selecionaBotao(botao: sender)
    }
    
    func listarGastosMensaisPor(cargo cargoConsultado:Cargo)->Float{
        return colaboradores.filter{$0.cargo == cargoConsultado}.map{$0.salario}.reduce(0, +)
    }

    func numeroPessoasPor(cargo cargoConsultado:Cargo)->Int{
        return colaboradores.filter{$0.cargo == cargoConsultado}.count
    }
    
    func duplicidadePor(matricula: Int)->Bool{
        for posicao in 0..<colaboradores.count{
            if(colaboradores[posicao].matricula == matricula){
                return true
            }
        }
        return false
    }
    
    // MARK: CADASTRAR COLABORADOR
    @IBAction func cadastrarColaborador(_ sender: UIButton) {
        var novoNome = ""
        var novaMatricula = 0
        var novoSalario: Float = 0.00
        var nomes = [String]()
        var matriculas = [String]()
        
        if nomeTextField.text != "" {
            novoNome = nomeTextField.text ?? ""
        }
        //NSString->String->Int
        if matriculaTextField.text != "" {
            let matricula = (matriculaTextField.text ?? "") as String
            novaMatricula = Int(matricula) ?? 0
        }
        //NSString->String->Float
        if salarioTextField.text != "" {
            let salario = (salarioTextField.text ?? "") as String
            novoSalario = Float(salario) ?? 0.00
        }
        
        func validacao(novoColaborador: Colaborador)->Bool{
            if(numeroPessoasPor(cargo: .diretor)==1 && novoColaborador.cargo == .diretor){
                let alerta = UIAlertController(title: "Erro", message: "A escola não pode ter mais de um diretor contando contigo \(novoColaborador.nome). Tente novamente.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true, completion: nil)
                return false
            }
            if(novoColaborador.salario > listarGastosMensaisPor(cargo: .diretor) && numeroPessoasPor(cargo: .diretor)==1){
                let alerta = UIAlertController(title: "Erro", message: "O salário do colaborador \(novoColaborador.nome) não pode ser maior do que o do diretor. Tente novamente.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true, completion: nil)
                return false
            }
            if(novoColaborador.cargo == .coordenador){
                if(numeroPessoasPor(cargo: .coordenador)+1>numeroPessoasPor(cargo: .professor)){
                    let alerta = UIAlertController(title: "Erro", message: "A escola não pode ter mais coordenadores contando contigo \(novoColaborador.nome) do que professores. Tente novamente.", preferredStyle: .alert)
                    alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    present(alerta,animated: true, completion: nil)
                }
                return false
            }
           
            
            if(duplicidadePor(matricula: novoColaborador.matricula)){
                let alerta = UIAlertController(title: "Erro", message: "O número da matrícula é único, não pode repetir. Tente novamente.", preferredStyle: .alert)
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta,animated: true, completion: nil)
                return false
            }
            
            return true
        }
        
        if novaMatricula == 0 || novoSalario == 0.00 || novoNome == "" {
            let alerta = UIAlertController(title: "Erro", message: "O cadastro do salário, matricula ou nome está incompleto. Tente novamente.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta,animated: true, completion: nil)
        }
        else {
            let novoColaborador = Colaborador(nome: novoNome, salario: novoSalario, matricula: novaMatricula, cargo: cargoSelecionado)
            if(validacao(novoColaborador: novoColaborador)){
                colaboradores.append(novoColaborador)
            }             
        }
        
        outputMessage.text = ""
        
        for posicao in 0..<colaboradores.count{
            nomes.append(colaboradores[posicao].nome)
            matriculas.append("\(colaboradores[posicao].matricula)")
        }
        
        for posicao in 0..<nomes.count {
            outputMessage.text! += "\(matriculas[posicao]): \(nomes[posicao])\n"
        }
        resetaCadastraColaborador()
    }
    // MARK: REMOVER COLABORADOR
    @IBAction func removerColaborador(_ sender: UIButton) {
        
        let matricula = removeMatriculaTextField.text
        var novaMatricula = 0
        var nomes = [String]()
        var matriculas = [Int]()
        var posicaoRemovida = 0
        
        if matricula != "" {
            let matriculaConvertida = (matricula ?? "") as String
            novaMatricula = Int(matriculaConvertida) ?? 0
        } else {
            let alerta = UIAlertController(title: "Erro", message: "O número da matrícula é inválido. Tente novamente.", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta,animated: true, completion: nil)
        }
        
        for posicao in 0..<colaboradores.count {
            let colaboradorSelecionado = colaboradores[posicao]
            if colaboradorSelecionado.matricula == novaMatricula {
                posicaoRemovida = posicao
            }
        }
        
        colaboradores.remove(at: posicaoRemovida)
        
        outputMessage.text = ""
        
        for posicao in 0..<colaboradores.count{
            nomes.append(colaboradores[posicao].nome)
            matriculas.append(colaboradores[posicao].matricula)
        }
        
        for posicao in 0..<nomes.count {
            outputMessage.text! += "\(matriculas[posicao]): \(nomes[posicao])\n"
        }
        resetaRemoveColaborador()
    }
    
    //MARK: GASTOS MENSAIS
    @IBAction func listarGastosMensaisComTodosColaboradores(_ sender: UIButton) {
        var gastosMensais: Float = 0.00
        for posicao in 0..<colaboradores.count {
            gastosMensais += colaboradores[posicao].salario
        }
        
        outputMessage.text = "Os gastos mensais da empresa com todos os colaboradores foi de: R$ \(gastosMensais)"
    }
    
    //MARK: GASTOS MENSAIS POR CARGO
    @IBAction func listarGastosMensaisPorCargo(_ sender: UIButton) {
        
        var gastosDiretor: Float = 0.00
        var gastosMonitor: Float = 0.00
        var gastosProfessor: Float = 0.00
        var gastosAssistente: Float = 0.00
        var gastosCoordenador : Float = 0.00
        
        for posicao in 0..<colaboradores.count {
            let colaboradorDaVez = colaboradores[posicao]
            switch colaboradorDaVez.cargo {
                
            case .monitor:
                gastosMonitor += colaboradorDaVez.salario
            case .professor:
                gastosProfessor += colaboradorDaVez.salario
            case .coordenador:
                gastosCoordenador += colaboradorDaVez.salario
            case .diretor:
                gastosDiretor += colaboradorDaVez.salario
            case .assistente:
                gastosAssistente += colaboradorDaVez.salario
            }
        }
        
        let gastosTotais = [gastosDiretor, gastosCoordenador, gastosProfessor, gastosAssistente, gastosMonitor]
        let printCargos = ["Diretor: R$","Coordenador: R$","Professor: R$","Assistente: R$", "Monitor: R$"]
        
        outputMessage.text = ""
        
        for posicao in 0..<gastosTotais.count {
            outputMessage.text! += "\(printCargos[posicao]) \(gastosTotais[posicao])\n"
        }
    }
    
    //MARK: PESSOAS POR CARGO
    @IBAction func listarQuantasPessoasExistemPorCargo(_ sender: UIButton) {
        
        var diretores = 0
        var monitores = 0
        var professores = 0
        var assistentes = 0
        var coordenadores = 0
        
        for posicao in 0..<colaboradores.count {
            let colaboradorDaVez = colaboradores[posicao]
            switch colaboradorDaVez.cargo {
                
            case .monitor:
                monitores += 1
            case .professor:
                professores += 1
            case .coordenador:
                coordenadores += 1
            case .diretor:
                diretores += 1
            case .assistente:
                assistentes += 1
            }
        }
        
        let equipe = [diretores, coordenadores, professores, assistentes, monitores]
        
        let printCargos = ["Diretores:","Coordenadores:","Professores: ","Assistentes: ", "Monitores:"]
        
        outputMessage.text = ""
        
        for posicao in 0..<equipe.count {
            outputMessage.text! += "\(printCargos[posicao]) \(equipe[posicao])\n"
        }
    }
    
    //MARK: NOME EM ORDEM ALFABÉTICA
    @IBAction func listarNomesColaboradoresOrdemAlfabetica(_ sender: UIButton) {
        var nomes = [String]()
        for posicao in 0..<colaboradores.count {
            nomes.append(colaboradores[posicao].nome)
        }
        nomes.sort()
        
        outputMessage.text = ""
        
        for posicao in 0..<nomes.count {
            outputMessage.text! += "\(nomes[posicao])\n"
        }
    }
    
    
    
}

