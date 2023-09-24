//
//  UserProfile.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 17/09/23.
//

import SwiftUI

struct UserProfile: View {
    
    @State private var firstName: String = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State private var lastName: String = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State private var email: String = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var phoneNumber: String = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
    
    @State var orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
    @State var passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
    @State var specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
    @State var newsletter = UserDefaults.standard.bool(forKey: kNewsletter)
    
    @State private var isLoggedOut = false
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ScrollView{
            NavigationLink(destination: Onboarding(), isActive: $isLoggedOut) { }
            VStack{
                VStack(spacing: 5){
                    VStack{
                        Text("Avatar")
                            .onboardingTextStyle()
                        
                        HStack{
                            Image("profile-image-placeholder")
                                .resizable()
                                .aspectRatio( contentMode: .fit)
                                .frame(maxHeight: 75)
                                .clipShape(Circle())
                                .padding(.trailing)
                            Button("Change") { }
                                .buttonStyle(ButtonStylePrimaryColor1())
                            Button("Remove") { }
                                .buttonStyle(ButtonStylePrimaryColorReverse())
                            
                        }
                    }
                    
                    
                    VStack{
                        Text("First name")
                            .onboardingTextStyle()
                        TextField("First Name", text: $firstName)
                    }
                    
                    VStack{
                        Text("First name")
                            .onboardingTextStyle()
                        TextField("Last Name", text: $lastName)
                    }
                    
                    VStack{
                        Text("Email")
                            .onboardingTextStyle()
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                    }
                    
                    VStack{
                        Text("Phone Number")
                            .onboardingTextStyle()
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.namePhonePad)
                    }
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .padding()
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Email notifications")
                            .font(.regularText())
                            .foregroundColor(.primaryColor1)
                        
                        Spacer(minLength: 10)

                        Toggle("Order statuses", isOn: $orderStatuses)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Password changes", isOn: $passwordChanges)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Special offers", isOn: $specialOffers)
                            .toggleStyle(iOSCheckboxToggleStyle())
                        Toggle("Newsletter", isOn: $newsletter)
                            .toggleStyle(iOSCheckboxToggleStyle())
                    }
                    Spacer()
                }
                .padding()
                .font(Font.leadText())
                .foregroundColor(.primaryColor1)
                
                Spacer()
                
                Button {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    UserDefaults.standard.set("", forKey: kFirstName)
                    UserDefaults.standard.set("", forKey: kLastName)
                    UserDefaults.standard.set("", forKey: kEmail)
                    UserDefaults.standard.set("", forKey: kPhoneNumber)
                    UserDefaults.standard.set(false, forKey: kOrderStatuses)
                    UserDefaults.standard.set(false, forKey: kPasswordChanges)
                    UserDefaults.standard.set(false, forKey: kSpecialOffers)
                    UserDefaults.standard.set(false, forKey: kNewsletter)

                    isLoggedOut = true

                } label: {
                    Text("Logout")
                }
                .buttonStyle(ButtonStyleYellowColorWide())
                
                Spacer(minLength: 20)
                
                HStack {
                    Button("Discard Changes") {
                        firstName = firstName
                        lastName = lastName
                        email = email
                        phoneNumber = phoneNumber
                        
                        orderStatuses = orderStatuses
                        passwordChanges = passwordChanges
                        specialOffers = specialOffers
                        newsletter = newsletter
                        self.presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(ButtonStylePrimaryColorReverse())
                    Button("Save changes") {
                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)
                        UserDefaults.standard.set(phoneNumber, forKey: kPhoneNumber)
                        UserDefaults.standard.set(orderStatuses, forKey: kOrderStatuses)
                        UserDefaults.standard.set(passwordChanges, forKey: kPasswordChanges)
                        UserDefaults.standard.set(specialOffers, forKey: kSpecialOffers)
                        UserDefaults.standard.set(newsletter, forKey: kNewsletter)
                        self.presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(ButtonStylePrimaryColor1())
                }
                
                
                
                
            }
            .onAppear{
                firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
                lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
                email = UserDefaults.standard.string(forKey: kEmail) ?? ""
                phoneNumber = UserDefaults.standard.string(forKey: kPhoneNumber) ?? ""
                
                orderStatuses = UserDefaults.standard.bool(forKey: kOrderStatuses)
                passwordChanges = UserDefaults.standard.bool(forKey: kPasswordChanges)
                specialOffers = UserDefaults.standard.bool(forKey: kSpecialOffers)
                newsletter = UserDefaults.standard.bool(forKey: kNewsletter)

            }
        }
        .navigationTitle("Personal information")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
