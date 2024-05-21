//
//  PowerUpDetail.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 19/05/24.
//

//import SwiftUI
//
//struct AddTrainingView: View {
//    @Environment(\.presentationMode) var presentationMode
//    
//    @State private var selectedAction = "Agendar PowerUp"
//    @State private var selectedArea = "Desenvolvimento"
//    @State private var theme = ""
//    @State private var description = ""
//    @State private var date = Date()
//    @State private var time = Date()
//    @State private var selectedDuration = "30 min"
//    @State private var link = ""
//    
//    private let actions = ["Agendar", "Salvar", "Sugerir"]
//    private let areas = ["Desenvolvimento", "Dados", "Design", "Produto", "Gestão", "Marketing", "Outros"]
//    private let durations = ["30 min", "1 hora"]
//    
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("O que deseja fazer?")) {
//                    Picker("Ação", selection: $selectedAction) {
//                        ForEach(actions, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
//                
//                Section(header: Text("Selecione a área relacionada ao PowerUp")) {
//                    Picker("Área", selection: $selectedArea) {
//                        ForEach(areas, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
//                
//                if selectedAction != "Sugerir PowerUp" {
//                    TextField("Tema", text: $theme)
//                        .disableAutocorrection(true)
//                    
//                    TextField("Descrição", text: $description)
//                        .disableAutocorrection(true)
//                    
//                    DatePicker("Data", selection: $date, displayedComponents: .date)
//                    
//                    DatePicker("Horário", selection: $time, displayedComponents: .hourAndMinute)
//                    
//                    Picker("Duração", selection: $selectedDuration) {
//                        ForEach(durations, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                    
//                    TextField("Link", text: $link)
//                        .disableAutocorrection(true)
//                        .keyboardType(.URL)
//                } else {
//                    TextField("Tema", text: $theme)
//                        .disableAutocorrection(true)
//                }
//                
//                Button(action: saveTraining) {
//                    Text("Salvar")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.ioasysGreen)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//            }
//            .navigationBarTitle("Power Up", displayMode: .inline)
//        }
//    }
//    
//    private func saveTraining() {
//        if selectedAction == "Sugerir PowerUp" {
//            guard !theme.isEmpty, !selectedArea.isEmpty else {
//                print("Campos obrigatórios não preenchidos")
//                return
//            }
//        } else {
//            guard !theme.isEmpty, !selectedArea.isEmpty, !date.description.isEmpty, !time.description.isEmpty, !selectedDuration.isEmpty, !link.isEmpty else {
//                print("Campos obrigatórios não preenchidos")
//                return
//            }
//        }
//        
//        print("Treinamento salvo com sucesso")
//        presentationMode.wrappedValue.dismiss()
//    }
//    
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }
//}
//
//struct AddTrainingView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTrainingView()
//    }
//}
