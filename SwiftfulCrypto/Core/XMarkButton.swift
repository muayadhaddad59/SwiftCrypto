//
//  XMarkButton.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-07.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(
            action: {
                presentationMode.wrappedValue.dismiss()
            },
            label: {
                Image(systemName: "xmark")})
    }
}

#Preview {
    XMarkButton()
}
