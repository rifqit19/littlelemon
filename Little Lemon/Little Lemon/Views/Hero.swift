//
//  Hero.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 24/09/23.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Text("Little Lemon")
                        .font(.displayFont())
                        .foregroundColor(.primaryColor2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Chicago")
                        .font(.subTitleFont())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer(minLength: 5)

                    Text("""
                             We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.
                             """)
                    .font(.leadText())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Image("hero-image")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(maxWidth: 120, maxHeight: 140)
                    .clipShape(Rectangle())
                    .cornerRadius(16)
            }
        }
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
            .padding()
            .background(Color.primaryColor1)
            .frame(maxWidth: .infinity, maxHeight: 240)
    }
}
