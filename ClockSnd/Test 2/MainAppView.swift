import SwiftUI

class AppUserData: ObservableObject {
    @Published var userName: String = "Гість"
    @Published var isLoggedIn: Bool = false
    @Published var themeColorName: String = "blue"
}

struct MainAppView: View {
    @StateObject private var userData = AppUserData()
    @ObservedObject private var settings = GlobalAppSettings()

    var body: some View {
        TabView {
            ComplexProfileScreen(userData: userData)
                .tabItem {
                    Label("Профіль", systemImage: "person.crop.circle")
                }
            
            ItemListScreen()
                .tabItem {
                    Label("Товари", systemImage: "list.bullet")
                }
            
            SettingsScreen(appSettings: settings)
                .environmentObject(userData)
                .tabItem {
                    Label("Налаштування", systemImage: "gearshape.fill")
                }
        }
        .onAppear {
            print("MainAppView з'явився. Користувач: \(userData.userName)")
        }
    }
}

class GlobalAppSettings: ObservableObject {
    @Published var fontSizeModifier: Double = 0
    @Published var showDebugInfo: Bool = false

    init() {
    }
}

struct ComplexProfileScreen: View {
    @ObservedObject var userData: AppUserData
    @State private var newName: String = ""
    @State private var userBio: String = "Розкажіть про себе..."
    @State private var receiveNotifications: Bool = true
    @State private var profileStrength: Double = 0.2

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Особиста інформація")) {
                    if userData.isLoggedIn {
                        Text("Ім'я: \(userData.userName)")
                        TextField("Змінити ім'я", text: $newName)
                        Button("Зберегти ім'я") {
                            if !newName.isEmpty {
                                userData.userName = newName
                                newName = ""
                            }
                        }
                    } else {
                        Text("Будь ласка, увійдіть.")
                        Button("Увійти") {
                            userData.isLoggedIn = true
                            userData.userName = "Авторизований Користувач"
                        }
                    }
                }

                Section(header: Text("Біографія")) {
                    TextEditor(text: $userBio)
                        .frame(height: 100)
                    Slider(value: $profileStrength, in: 0...1)
                }

                Section(header: Text("Сповіщення")) {
                    Toggle("Отримувати сповіщення", isOn: $receiveNotifications)
                    Button(action: { print("Додаткові налаштування сповіщень") }) {
                        Image(systemName: "wrench.and.screwdriver")
                    }
                }
                
                Section(header: Text("Зображення профілю")) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .foregroundColor(Color.gray.opacity(0.4))
                        .accessibilityHidden(true)
                }
            }
            .navigationTitle(userData.isLoggedIn ? userData.userName : "Профіль")
        }
    }
}