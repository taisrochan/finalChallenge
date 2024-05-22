//
//  ProfileScreen.swift
//  camp2024-final
//
//  Created by Tais Rocha Nogueira on 16/05/24.
//

import SwiftUI
import PhotosUI

struct ProfileScreen: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var name = UserSessionManager.shared.loadUser()?.name ?? ""
    @State private var email = UserSessionManager.shared.loadUser()?.email ?? ""
    @State private var area = UserSessionManager.shared.loadUser()?.area ?? ""
    @State private var superpower = UserSessionManager.shared.loadUser()?.superpower ?? ""
    @State private var mentor = UserSessionManager.shared.loadUser()?.mentor ?? ""
    @State private var isDeletingImage = false
    @EnvironmentObject private var appRootManager: AppRootManager

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Color.ioasysGreen
                        .frame(height: geometry.size.height * 0.2)
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Color.white
                        .frame(height: geometry.size.height * 0.9)
                }
                
                VStack {
                    ZStack {
                        if let selectedImage = selectedImage {
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .opacity(isDeletingImage ? 0.5 : 1.0)
                                .onTapGesture {
                                    if isDeletingImage {
                                        deleteImage()
                                    } else {
                                        isImagePickerPresented = true
                                    }
                                }
                                .onLongPressGesture {
                                    isDeletingImage.toggle() 
                                }
                            
                            if isDeletingImage {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .onTapGesture {
                                        deleteImage()
                                    }
                                    .padding(20)
                            }
                        } else {
                            Circle()
                                .fill(Color.ioasysOrange)
                                .frame(width: 150, height: 150)
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .onTapGesture {
                                    isImagePickerPresented = true
                                }
                        }
                    }
                    
                    Spacer().frame(height: 36)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        TextField("Nome", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        TextField("Área", text: $area)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        TextField("Superpoder", text: $superpower)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                        TextField("Mentor", text: $mentor)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disabled(true)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer().frame(height: 50)
                    
                    Button(action: {
                        
                    }) {
                        Text("Salvar")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.ioasysGreen)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer().frame(height: 24)

                    Button(action: {
                        UserSessionManager.shared.clearUser()
                        appRootManager.currentRoot = .login
                    }) {
                        Text("LogOut")
                            .foregroundColor(Color.ioasysGreen)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.ioasysGreen, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage, isImagePickerPresented: $isImagePickerPresented)
        }
        .onAppear() {
            loadMentor()
        }
    }
    
    func deleteImage() {
        selectedImage = nil
        isDeletingImage = false
    }
    
    func loadMentor() {
        let myUserId = UserSessionManager.shared.userId
        let mentorings = MentorsRequestManager.shared.getAllMentorings()
        let myMentor = mentorings.first(where: {
            $0.mentee.id == myUserId && $0.status == MentoringStatus.accepted.rawValue
        })?.mentor
        let myMentorName = getFirstTwoNames(from: myMentor?.name ?? "")
        mentor = myMentorName
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isImagePickerPresented: Bool
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var selectedImage: UIImage?
        var presentationMode: Binding<Bool>

        init(selectedImage: Binding<UIImage?>, presentationMode: Binding<Bool>) {
            _selectedImage = selectedImage
            self.presentationMode = presentationMode
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = uiImage
            }
            presentationMode.wrappedValue = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.wrappedValue = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage, presentationMode: $isImagePickerPresented)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
