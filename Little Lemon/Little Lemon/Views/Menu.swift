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

    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true

    
    @State var loaded = false
    @State var isKeyboardVisible = false


    var body: some View {
        VStack{
            
            Header()
            
            VStack{
                if !isKeyboardVisible {
                    withAnimation() {
                        Hero()
                            .frame(maxHeight: 180)
                    }
                }
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            .background(Color.primaryColor1)
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                Text("ORDER FOR DELIVERY!")
                    .font(.sectionTitle())
                    .bold()
                    .foregroundColor(.highlightColor2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.leading)

                
                HStack(spacing: 20) {
                    Toggle("Starters", isOn: $startersIsEnabled)
                    Toggle("Mains", isOn: $mainsIsEnabled)
                    Toggle("Desserts", isOn: $dessertsIsEnabled)
                    Toggle("Drinks", isOn: $drinksIsEnabled)
                }
                .toggleStyle(MyToggleStyle())
                .padding(.horizontal)
            }

            
            FetchedObjects(predicate: buildPredicate(),
                           sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List(dishes) { dish in
                    NavigationLink(destination: DishDetails(dish: dish)){
                        HStack {
                            VStack{
                                Text(dish.title ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.sectionCategories())
                                    .foregroundColor(.black)
                                
                                Spacer(minLength: 10)

                                Text(dish.descriptionDish ?? "")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.paragraphText())
                                    .foregroundColor(.primaryColor1)
                                    .lineLimit(2)
                                
                                Spacer(minLength: 5)

                                Text("$" + (dish.price ?? ""))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.highlightText())
                                    .foregroundColor(.primaryColor1)
                                    .monospaced()

                                
                            }
                            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                case .failure(_):
                                    Text("Image Load Failed")
                                case .empty:
                                    ProgressView()
                                default:
                                    ProgressView()
                                }
                            }
                            .frame(width: 90, height: 90)
                            .clipShape(Rectangle())
                        }
                        .padding(.vertical)
                        .frame(maxHeight: 150)
                    }
                } .listStyle(.plain)
               
            }


        }
        .onAppear {
            if !loaded {
                self.getMenuData()
                loaded = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = true
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
            withAnimation {
                self.isKeyboardVisible = false
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
                        dish.descriptionDish = menuItem.descriptionDish
                        dish.category = menuItem.category
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
    
//    func buildPredicate() -> NSPredicate {
//        if searchText.isEmpty {
//            return NSPredicate(value: true)
//        } else {
//            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
//        }
//    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)

        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }

}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
