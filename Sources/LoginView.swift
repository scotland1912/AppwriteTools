import Foundation
import SwiftUI

import Appwrite

public struct AppwriteLoginView: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var isLoading: Bool
    @State private var showResetPasswordOption: Bool
    @State private var showRegisterOption: Bool
    @State var loginAction: (() -> Void)
    @State var registerAction: (() -> Void)
    @State var resetPasswordAction: (() -> Void)
    @State var invertedLightMode: Bool
    
    public init(email: Binding<String>, password: Binding<String>, isLoading: Binding<Bool>, resetPasswordAction: (() -> Void)?, loginAction: @escaping (() -> Void), registerAction: (() -> Void)?, invertedLightMode: Bool) {
        self._email = email
        self._password = password
        self._isLoading = isLoading
        self.showResetPasswordOption = resetPasswordAction != nil
        self.showRegisterOption = registerAction != nil
        self.loginAction = loginAction
        self.registerAction = registerAction ?? {}
        self.resetPasswordAction = resetPasswordAction ?? {}
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
                        .textContentType(.password)
                }
                .listRowBackground(invertedLightMode ? Color(uiColor: .secondarySystemBackground) : Color(uiColor: .secondarySystemGroupedBackground))
                Section {
                    Button(action: loginAction) {
                        VStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.blue)
                            } else {
                                Text("Anmelden")
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
                    .disabled(password.count < 8 || !email.isValidEmail)
                    .listRowInsets(EdgeInsets())
                    if showResetPasswordOption {
                        HStack {
                            Spacer(minLength: 0)
                            VStack {
                                Text("Passwort vergessen?")
                                Button("Zurücksetzen", action: resetPasswordAction)
                                    .buttonStyle(.borderless)
                            }
                            Spacer(minLength: 0)
                        }
                        .font(.footnote)
                        .listRowBackground(invertedLightMode ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGroupedBackground))
                    }
                }
                .background(invertedLightMode ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGroupedBackground))
            }
            .scrollContentBackground(invertedLightMode ? .hidden : .visible)
            .listSectionSpacing(32)
            .listRowSpacing(16)
            if showRegisterOption {
                Text("Du hast noch keinen Account?")
                    .font(.footnote)
                Button("Account erstellen", action: registerAction)
                    .font(.footnote)
            }
        }
        .background(invertedLightMode ? Color(uiColor: .systemBackground) : Color(uiColor: .systemGroupedBackground))
    }
}

#Preview {
    AppwriteLoginView(email: .constant("test@test.test"), password: .constant("testtest"), isLoading: .constant(false), resetPasswordAction: { print("Reset Password") }, loginAction: { print("Login") }, registerAction: { print("Register") }, invertedLightMode: false)
}
