//
//  AddPowerUpScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI

struct AddTrainingView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddPowerUpViewModel()
  
    @State private var selectedAction = "Agendar"
    @State private var selectedArea = "Desenvolvimento"
    @State private var theme = ""
    @State private var description = ""
    @State private var date = Date()
    @State private var time = Date()
    @State private var selectedDuration = "30 min"
    @State private var link = ""
    
    private let actions = ["Agendar", "Salvar", "Sugerir"]

    private let durations = ["30 min", "1 hora"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("O que deseja fazer?")) {
                    Picker("Ação", selection: $selectedAction) {
                        ForEach(actions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Selecione a área relacionada ao PowerUp")) {
                    Picker("Área", selection: $selectedArea) {
                        ForEach(CompanyAreas.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                if selectedAction != "Sugerir PowerUp" {
                    TextField("Tema", text: $theme)
                        .disableAutocorrection(true)
                    
                    TextField("Descrição", text: $description)
                        .disableAutocorrection(true)
                    
                    DatePicker("Data", selection: $date, displayedComponents: .date)
                    
                    DatePicker("Horário", selection: $time, displayedComponents: .hourAndMinute)
                    
                    Picker("Duração", selection: $selectedDuration) {
                        ForEach(durations, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    TextField("Link", text: $link)
                        .disableAutocorrection(true)
                        .keyboardType(.URL)
                } else {
                    TextField("Tema", text: $theme)
                        .disableAutocorrection(true)
                }
                
                Button(action: saveTraining) {
                    Text("Salvar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .navigationBarTitle("Power Up", displayMode: .inline)
            .overlay(
                Group {
                    if viewModel.isLoading {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        ProgressView("Carregando...")
                            .progressViewStyle(CircularProgressViewStyle())
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
            )
            .alert(isPresented: $viewModel.showAlert) {
                if viewModel.didSucceed {
                    Alert(
                        title: Text("Sucesso"),
                        message: Text("Treinamento salvo com sucesso!"),
                        dismissButton: .default(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                } else {
                    Alert(
                        title: Text("Erro"),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    
    private func saveTraining() {
        if selectedAction == "Sugerir" {
            guard !theme.isEmpty, !selectedArea.isEmpty else {
                viewModel.errorMessage = "Campos obrigatórios não preenchidos"
                viewModel.showAlert = true
                return
            }
        } else {
            guard !theme.isEmpty, !selectedArea.isEmpty, !date.description.isEmpty, !time.description.isEmpty, !selectedDuration.isEmpty, !link.isEmpty else {
                viewModel.errorMessage = "Campos obrigatórios não preenchidos"
                viewModel.showAlert = true
                return
            }
        }
        
        let combinedDate = Calendar.current.date(
            bySettingHour: Calendar.current.component(.hour, from: time),
            minute: Calendar.current.component(.minute, from: time),
            second: 0,
            of: date
        ) ?? Date()
        
        let status = PowerUpStatus(rawValue: selectedAction)
        
        viewModel.createPowerUp(
            area: selectedArea,
            titulo: theme,
            descricao: description,
            data: combinedDate,
            duracao: selectedDuration,
            linkReuniao: link, 
            status: status
        )
    }
}



struct AddTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        AddTrainingView()
    }
}
