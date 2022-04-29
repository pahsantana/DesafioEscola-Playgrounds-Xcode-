//
//  ViewControllerExtension.swift
//  SistemaEscola
//
//  Created by Renan Trévia on 2/14/22.
//  Copyright © 2022 Eldorado. All rights reserved.
//

import UIKit

extension ViewController {
    func resetaRemoveColaborador() {
        resetaTodosTextFieldRemove()
    }
    
    func resetaTodosTextFieldRemove() {
        removeMatriculaTextField.text = ""
    }
    
    func resetaCadastraColaborador() {
        resetaTodosBotoesDeCargo()
        resetaTodosTextFieldCadastro()
        
        monitorButton.backgroundColor = .systemBlue
        monitorButton.setTitleColor(.white, for: .normal)
        
        cargoSelecionado = .monitor
    }
    
    func resetaTodosTextFieldCadastro() {
        matriculaTextField.text = ""
        nomeTextField.text = ""
        salarioTextField.text = ""
    }
    
    func resetaTodosBotoesDeCargo() {
        monitorButton.backgroundColor = .clear
        professorButton.backgroundColor = .clear
        coordenadorButton.backgroundColor = .clear
        diretorButton.backgroundColor = .clear
        assistenteButton.backgroundColor = .clear
        
        monitorButton.setTitleColor(.systemBlue, for: .normal)
        professorButton.setTitleColor(.systemBlue, for: .normal)
        coordenadorButton.setTitleColor(.systemBlue, for: .normal)
        diretorButton.setTitleColor(.systemBlue, for: .normal)
        assistenteButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    func selecionaBotao(botao: UIButton) {
        resetaTodosBotoesDeCargo()
        botao.backgroundColor = .systemBlue
        botao.setTitleColor(.white, for: .normal)
    }
}
