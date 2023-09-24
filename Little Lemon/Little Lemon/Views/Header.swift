//
//  Header.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 24/09/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            ZStack {
                Image("logo")
                    .frame(maxHeight: 50)

                HStack {
                    Spacer()
                    NavigationLink(destination: UserProfile()) {
                        Image("profile-image-placeholder")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxHeight: 50)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }

    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
