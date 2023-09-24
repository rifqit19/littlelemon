//
//  Onboarding.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 17/09/23.
//

import SwiftUI

public let kFirstName = "first name key"
public let kLastName = "last name key"
public let kEmail = "e-mail key"
let kIsLoggedIn = "kIsLoggedIn"


struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    
    @State var isLoggedIn = false

    @State private var showingAlert = false
    @State var alertMessage = ""

    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                TextField("First Name", text: $firstName)
                    .keyboardType(.default)
                TextField("Last Name", text: $lastName)
                    .keyboardType(.default)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                Button {
                    if firstName.isEmpty || lastName.isEmpty || email.isEmpty{
                        alertMessage = "All field are required"
                        showingAlert = true
                    }else{
                        
                        if(isValidEmail(email)){
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)

                            isLoggedIn = true

                        }else{
                            alertMessage = "Email not valid"
                            showingAlert = true

                        }
                    }
                } label: {
                    Text("Register")
                }
                
            }.alert(alertMessage , isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }

    }
    
    //MARK: custom fnuction
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
