//
//  DishDetails.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 17/09/23.
//

import SwiftUI

struct DishDetails: View {
    let dish: Dish

    var body: some View {
        // Create the DishDetails view with details of the selected dish
        VStack{
            Text("Dish Details")
            
            Text(dish.title ?? "")
            Text(dish.price ?? "")
            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                // Handle AsyncImage phases here
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50) // Adjust the size as needed
                case .failure(_):
                    Text("Image Load Failed")
                case .empty:
                    Text("Loading...")
                default:
                    Text("Loading...")
                }
            }
                .navigationBarTitle(dish.title ?? "Unknown Dish")
            
        }
        
    }
}

