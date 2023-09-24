//
//  Home.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 17/09/23.
//

import SwiftUI

struct Home: View {
    
    let persistence = PersistenceController.shared
    
    var body: some View {
        Menu()
            .environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
