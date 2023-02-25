//
//  OnboardingScreen.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import SwiftUI
import Foundation

let KEY_FIRSTNAME="fnkey"
let KEY_LASTNAME="lnkey"
let KEY_EMAIL="emailkey"
let KEY_LOGGEDIN="loggedinkey"

struct OnboardingScreen: View {
    
    @State var firstName = ""
    @State var lastname = ""
    @State var email = ""
    @State private var showAlert = false
    @State var isLoggedIn = false

    var body: some View {
        
        NavigationView {
            VStack {
                NavigationLink(destination: HomeScreen(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                    .isDetailLink(false).navigationBarBackButtonHidden(true)
                VStack {
                    Image("littlelemonlogo - small")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 60, alignment: .top)
                    Divider()
                }.background(Color.white)
                
                ScrollView {
                    VStack {
                        Text("Create account").font(.title3).foregroundColor(Color.black)
                            .bold().padding(.top,40)
                        ZStack {
                            TextField("First Name",text: $firstName).padding(.horizontal,12)
                            RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 2)
                            
                        }.frame(width: 290, height: 30)
                        ZStack {
                            TextField("Last Name",text: $lastname).padding(.horizontal,12)
                            RoundedRectangle(cornerRadius: 10).stroke(Color.black,lineWidth: 2)
                        }.frame(width: 290,height: 30)
                        ZStack{
                            TextField("Email", text: $email).padding(.horizontal, 12)
                            RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2)
                        }.frame(width: 290, height: 30)
                    }.frame(width: 300)
                }
                Button {
                    if (firstName.isEmpty) {
                        showAlert=true
                    } else if (lastname.isEmpty) {
                        showAlert=true
                    } else if (email.isEmpty) {
                        showAlert = true
                    } else {
                        UserDefaults.standard.set(firstName, forKey: KEY_FIRSTNAME)
                        UserDefaults.standard.set(lastname, forKey: KEY_LASTNAME)
                        UserDefaults.standard.set(email, forKey: KEY_EMAIL)
                        isLoggedIn = true;
                        UserDefaults.standard.set(isLoggedIn, forKey: KEY_LOGGEDIN)
                    }
                } label: {
                    Text("Login").padding(.horizontal,80).bold()
                }.buttonStyle(.borderedProminent).padding()
                    .alert( isPresented: $showAlert) {
                        Alert(title: Text("Error During Submission"),
                        message: Text("All fields should have valid text"))
                    }
                    .tint(Color(#colorLiteral(red: 0.286, green: 0.370, blue: 0.340, alpha: 1)))
                Spacer()
            }.onAppear {
                if (UserDefaults.standard.bool(forKey: KEY_LOGGEDIN)) {
                    isLoggedIn=true
                }
            }
        }
        
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
