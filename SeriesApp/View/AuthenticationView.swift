//
//  AuthenticationView.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 02/07/23.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                if !viewModel.isUnlocked {
                    Image("lock")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
            }
            if viewModel.authMethod == "" && viewModel.deviceBiometricAuthSupport {
                AlertView()
            }
        }
        .onAppear {
            viewModel.promptAuth()
        }
    }
}

struct AlertView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Authentication").font(.headline)
                // Button("Enable 4 PIN authentication", role: .cancel) { viewModel.promptPinAuth() }
                Button("Enable biometric authentication", role: .cancel, action: viewModel.promptBiometricAuth)
                Button("Continue without authentication", role: .cancel, action: viewModel.optedOutOfAuth)
        }
        .frame(width: 300, height: 200)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(UIColor.systemBackground))
            .shadow(radius: 2))
    }
}

struct PinCodeView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State private var pinCode: String = ""

    var body: some View {
        Text("Unfinished code.")
//        VStack(alignment: .center, spacing: 20) {
//            Text("Enter 4 digit PIN").font(.headline)
//            TextField("PIN", text: $pinCode)
//                                .keyboardType(.numberPad)
//                                .frame(maxWidth: 100)
//                                .multilineTextAlignment(TextAlignment.center)
//            Button("submit", role: .cancel) {
//                viewModel.promptPinAuth(pin: pinCode)
//            }
//        }
//        .frame(width: 300, height: 200)
//        .background(RoundedRectangle(cornerRadius: 10)
//            .foregroundColor(Color(UIColor.systemBackground))
//            .shadow(radius: 2))
    }
}
