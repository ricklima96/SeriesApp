//
//  AuthenticationViewModel.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 02/07/23.
//

import Foundation
import LocalAuthentication

protocol AuthenticationViewModelProtocol {
    func checkDeviceBiometricAuthSupport()
    func promptBiometricAuth()
    func promptAuth()
    func optedOutOfAuth()
}

final class AuthenticationViewModel: ObservableObject, AuthenticationViewModelProtocol {
    @Published var deviceBiometricAuthSupport = false
    @Published var isUnlocked = false
    @Published var showPinCodeView = false

    var authMethod: String = UserDefaults.standard.string(forKey: "authMethod") ?? ""
    let context = LAContext()

    func checkDeviceBiometricAuthSupport() {
        let deviceBiometricAuthSupport = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)

        DispatchQueue.main.async {
            self.deviceBiometricAuthSupport = deviceBiometricAuthSupport
        }

        if !deviceBiometricAuthSupport {
            optedOutOfAuth()
        }
    }

    func promptBiometricAuth() {
        let reason = "Enable biometric authentication to secure your data."

        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                               localizedReason: reason) { [weak self] success, error in
            guard let self = self else { return }

            if success {
                self.finishConfiguringAuth(isUnlocked: true, authMethod: "biometric")
            } else {
                optedOutOfAuth()
                print(error)
            }
        }
    }

    func promptAuth() {
        if !isUnlocked {
            checkDeviceBiometricAuthSupport()
            switch authMethod {
            case "biometric":
                promptBiometricAuth()
            case "pin":
                break
                // promptPinAuth()
            default:
                break
            }
        }
    }

    func optedOutOfAuth() {
        finishConfiguringAuth(isUnlocked: true, authMethod: "none")
    }

    private func finishConfiguringAuth(isUnlocked: Bool, authMethod: String) {
        DispatchQueue.main.async {
            self.isUnlocked = isUnlocked
        }
        setAuthMethod(authMethod)
    }

    private func setAuthMethod(_ value: String) {
        UserDefaults.standard.set(value, forKey: "authMethod")
    }
}

// extension AuthenticationViewModel {
    // Unused code
    //    func promptPinAuth(pin: String? = "") {
    //        DispatchQueue.main.async {
    //            self.showPinCodeView = true
    //        }
    //
    //        if let savedPin = Helper.retrievePINCode() {
    //            if pin == savedPin {
    //                DispatchQueue.main.async {
    //                    self.showPinCodeView = false
    //                    self.isUnlocked = isUnlocked
    //                }
    //            }
    //        } else if let pin = pin {
    //            Helper.savePINCode(pin: pin)
    //            finishConfiguringAuth(isUnlocked: true, authMethod: "pin")
    //        }
    //    }
// }
