//
//  Menu.swift
//  Little Lemon
//
//  Created by rifqi triginandri on 17/09/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @State var searchText = ""

    
    
    @State var loaded = false


    var body: some View {
        VStack{
            Text("Your App Title")
                .font(.title)
            
            Text("Chicago")
                .font(.subheadline)
            
            Text("Short description of your app")
                .font(.body)
            
            TextField("Search menu", text: $searchText)
            
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List(dishes) { dish in
                    NavigationLink(destination: DishDetails(dish: dish)){
                        HStack {
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
                            .frame(width: 50, height: 50) // Adjust the size as needed
                        }
                    }
                }
                .listStyle(.plain)
            }


        }
        .onAppear {
            if !loaded {
                self.getMenuData()
                loaded = true
            }
        }
        
    }
    
    //MARK: function
    
    func getMenuData(){
        PersistenceController.shared.clear()

        let serverURLString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        guard let url = URL(string: serverURLString) else{
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let menuList = try decoder.decode(MenuList.self, from: data)
                                        
                    for menuItem in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        // Set any additional properties here if needed
                    }
                    
                    try? viewContext.save() // Save the data into the database

                    
                } catch {
                    print("Error decoding menu data: \(error)")
                }
            } else if let error = error {
                print("Error fetching menu data: \(error)")
            }
            
        }
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        return [sortDescriptor]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }


}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
