import SwiftUI

struct SettingsScreen: View {
    @EnvironmentObject var userData: AppUserData
    @ObservedObject var appSettings: GlobalAppSettings

    @State private var temporaryFontSize: Double
    
    init(appSettings: GlobalAppSettings) {
        self.appSettings = appSettings
        _temporaryFontSize = State(initialValue: appSettings.fontSizeModifier)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Обліковий запис")) {
                    Text("Користувач: \(userData.userName)")
                    Button(userData.isLoggedIn ? "Вийти" : "Увійти") {
                        userData.isLoggedIn.toggle()
                        if !userData.isLoggedIn {
                            userData.userName = "Гість"
                        } else {
                            userData.userName = "Повернений Користувач"
                        }
                    }
                    .foregroundColor(userData.isLoggedIn ? .red : .green)
                }

                Section(header: Text("Вигляд")) {
                    VStack {
                        Text("Розмір шрифту: \(temporaryFontSize, specifier: "%.1f")")
                        Slider(value: $temporaryFontSize, in: -2...4, step: 0.5) {
                        }
                        .accessibilityLabel("Зміна розміру шрифту")
                    }
                    
                    Button("Застосувати розмір") {
                        appSettings.fontSizeModifier = temporaryFontSize
                    }

                    Toggle("Показувати налагоджувальну інформацію", isOn: $appSettings.showDebugInfo)
                }
                
                Section(header: Text("Тема")) {
                     Picker("Колір теми", selection: $userData.themeColorName) {
                         Text("Синій").tag("blue")
                         Text("Зелений").tag("green")
                         Text("Помаранчевий").tag("orange")
                     }
                }

                if appSettings.showDebugInfo {
                    Section(header: Text("Інформація для налагодження")) {
                        Text("ID Користувача: \(userData.isLoggedIn ? "XYZ123" : "Немає")")
                        Text("Версія додатку: 1.0.5 (alpha)")
                    }
                }
            }
            .navigationTitle("Налаштування")
            .onDisappear {
            }
        }
    }
}