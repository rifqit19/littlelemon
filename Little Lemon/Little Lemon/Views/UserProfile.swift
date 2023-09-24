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
    
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack{
            Text("Personal information")
            
            Image("profile-image-placeholder")
            
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            TextField("Email", text: $email)
            
            Spacer()
            
            Button {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                self.presentation.wrappedValue.dismiss()
            } label: {
                Text("Logout")
            }


        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
