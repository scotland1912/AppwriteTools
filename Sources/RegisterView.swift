import Foundation
import SwiftUI
import Appwrite

public struct AppwriteRegisterView: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var confirmPassword: String
    @Binding var isLoading: Bool
    @State private var showLoginOption: Bool
    @State var registerAction: (() -> Void)
    @State var loginAction: (() -> Void)
    @State var invertedLightMode: Bool
    
    public init(email: Binding<String>, password: Binding<String>, confirmPassword: Binding<String>, isLoading: Binding<Bool>, registerAction: @escaping () -> Void, loginAction: (() -> Void)?, invertedLightMode: Bool) {
        self._email = email
        self._password = password
        self._confirmPassword = confirmPassword
        self._isLoading = isLoading
        self.showLoginOption = loginAction != nil
        self.registerAction = registerAction
        self.loginAction = loginAction ?? {}
        self.invertedLightMode = invertedLightMode
    }
    
    
    public var body: some View {
        VStack {
            List {
                Section {
                    TextField("E-Mail-Adresse", text: $email)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    SecureField("Passwort", text: $password)
                        .textContentType(.newPassword)
                    SecureField("Passwort bestätigen", text: $confirmPassword)
                        .textContentType(.newPassword)
                }
                .listRowBackground(invertedLightMode ? Color(uiColor: .secondarySystemBackground) : Color(uiColor: .secondarySystemGroupedBackground))
                Section {
                    Button(action: registerAction) {
                        VStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.blue)
                            } else {
                                Text("Account erstellen")
                                    .bold()
                            }
                        }
                        .frame(maxHeight: .infinity)
                        .frame(maxWidth: .infinity)
                    }
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .buttonStyle(.borderedProminent)
                    .frame(height: 50)
                    .opacity(isLoading ? 0.5 : 1.0)
                    .disabled(password.count < 8 || password != confirmPassword || !email.isValidEmail)
                    .listRowInsets(EdgeInsets())
                }
                .background(invertedLightMode ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGroupedBackground))
            }
            .scrollContentBackground(invertedLightMode ? .hidden : .visible)
            .listSectionSpacing(32)
            .listRowSpacing(16)
            if showLoginOption {
                Text("Du hast bereits einen Account?")
                    .font(.footnote)
                Button("Anmelden", action: loginAction)
                    .font(.footnote)
            }
        }
        .background(invertedLightMode ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    AppwriteRegisterView(email: .constant("test@test.test"), password: .constant("testtest"), confirmPassword: .constant("testtest"), isLoading: .constant(false), registerAction: { print("Register") }, loginAction: { print("Login") }, invertedLightMode: true)
}
