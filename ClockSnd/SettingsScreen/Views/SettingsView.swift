//
//  SettingsView.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI
import MessageUI

enum SettingsSection: String, Identifiable {
    case terms
    case privacy
    case support
    case about
    case settings
    
    var id: SettingsSection { self }
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: TabBarViewModel
    
    @State private var isSignedIn: Bool = true
    @State private var isAnimating: Bool = false
    
    @State private var isShowingMailView = false
    @State private var alertNoMail = false

    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                SndText(style: .extraBold, size: 32, "Settings")
                    .padding(.top, 10)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 14) {
                    settingsButton(label: "App settings", icon: .settings) {
                        viewModel.coordinator.push(page: .settings)
                    }
                    
                    settingsButton(label: "About", icon: .about) {
                        viewModel.coordinator.push(page: .about)
                    }

                    settingsButton(label: "Terms of Use", icon: .terms) {
                        if let url = URL(string: "https://www.freeprivacypolicy.com/live/6eb9085e-86c6-49e8-af68-dc525297ff38") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    settingsButton(label: "Privacy Policy", icon: .privacy) {
                        if let url = URL(string: "https://www.freeprivacypolicy.com/live/7ddee06a-49c4-4498-8731-bd5ac162ba2e") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    settingsButton(label: "Developer Support", icon: .support) {
                        if MFMailComposeViewController.canSendMail() {
                            self.isShowingMailView = true
                        } else {
                            self.alertNoMail = true
                        }
                    }
                }
                .padding()
            }
            
        }
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: self.$isShowingMailView)
        }
        .alert(isPresented: $alertNoMail) {
            Alert(title: Text("No Mail Accounts"), message: Text("Please set up a Mail account in order to send email."), dismissButton: .default(Text("OK")))
        }
        .opacity(isAnimating ? 1 : 0)
        .onAppear {
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = true
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.async {
                withAnimation {
                    isAnimating = false
                }
            }
        }
    }
    
    func settingsButton(label: String, icon: SettingsSection = .about, color: Color = .primary, action: @escaping () -> Void = {}) -> some View {
        Button(action: action) {
            HStack {
                Image(icon.rawValue)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                
                    
                SndText(style: .bold, label)
                    .font(.headline)
                    .foregroundColor(color)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .background(Color.clear)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .background(
                    Color.white
                        .opacity(colorScheme == .dark ? 0.1 : 0.9)
                )
                .cornerRadius(10)
        )
        .shadow(color: colorScheme == .dark ? Color.customColor4 : Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
    
    func signOut() {
        isSignedIn = false
    }
}

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var result: Bool

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var result: Bool
        @Binding var presentation: PresentationMode

        init(result: Binding<Bool>, presentation: Binding<PresentationMode>) {
            _result = result
            _presentation = presentation
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            self.result = false
            $presentation.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(result: $result, presentation: presentation)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(["romanivvladyslav057@gmail.com"]) // Replace with your email address
        vc.setSubject("Support Request")
        vc.setMessageBody("I need help with...", isHTML: false)
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
}
