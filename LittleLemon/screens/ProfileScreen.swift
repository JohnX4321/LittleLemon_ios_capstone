//
//  ProfileScreen.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.presentationMode) var presentation
    let firstName: String = UserDefaults.standard.string(forKey: KEY_FIRSTNAME) ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: KEY_LASTNAME) ?? ""
    let email: String = UserDefaults.standard.string(forKey: KEY_EMAIL) ?? ""
    var body: some View {
        NavigationView {
            VStack {
                Text("My Information")
                    .font(.system(size: 30))
                    .bold()
                Image("Profile")
                    .resizable().scaledToFit()
                Text("\(firstName)").padding()
                Text("\(lastName)").padding()
                Text("\(email)").padding()
                NavigationLink(destination: {OnboardingScreen()},
                               label: {Text("Logout")
                        .padding(10).frame(maxWidth: .infinity)
                        .cornerRadius(10)
                    .padding()})
                .isDetailLink(false)
                .navigationBarBackButtonHidden(true)
                .simultaneousGesture(TapGesture().onEnded{
                    UserDefaults.standard.set(false, forKey: KEY_LOGGEDIN)
                })
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Circle().frame(width: 50, height: 50).padding()
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
