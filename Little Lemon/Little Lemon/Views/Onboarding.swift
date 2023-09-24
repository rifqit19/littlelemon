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
public let kPhoneNumber = "phone number key"
let kIsLoggedIn = "kIsLoggedIn"

public let kOrderStatuses = "order statuses key"
public let kPasswordChanges = "password changes key"
public let kSpecialOffers = "special offers key"
public let kNewsletter = "news letter key"



struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var phoneNumber = ""
    

    @State var isLoggedIn = false

    @State private var showingAlert = false
    @State var alertMessage = ""

    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: Home(), isActive: $isLoggedIn){
                    EmptyView()
                }
                
                VStack{
                    Hero()
                        .background(Color.primaryColor1)
                        .frame(maxHeight: 180)

                    VStack{
                        Text("First name")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                            .keyboardType(.default)
                        
                        Text("Last name")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                            .keyboardType(.default)
                        
                        Text("Email")
                            .onboardingTextStyle()
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .padding()

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
                                UserDefaults.standard.set(true, forKey: kOrderStatuses)
                                UserDefaults.standard.set(true, forKey: kPasswordChanges)
                                UserDefaults.standard.set(true, forKey: kSpecialOffers)
                                UserDefaults.standard.set(true, forKey: kNewsletter)
                                firstName = ""
                                lastName = ""
                                email = ""
                                isLoggedIn = true


                            }else{
                                alertMessage = "Email not valid"
                                showingAlert = true

                            }
                        }
                    } label: {
                        Text("Register")
                    }
                    .buttonStyle(ButtonStyleYellowColorWide())
                    
                    Spacer()
                }

                
            }.alert(alertMessage , isPresented: $showingAlert) {
                Button("OK", role: .cancel){}
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
            .navigationBarBackButtonHidden()

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
