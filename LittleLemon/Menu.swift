//
//  Menu.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import SwiftUI
import CoreData
import Foundation

var rawData: String = ""
var controller = PersistenceController()
var hasMenuLoaded = false


func fetchController(search: Bool, filter: String, searchStr: String) -> [NSSortDescriptor] {
    if search {
        return [NSSortDescriptor(key: "title", ascending: true)]
    } else {
        return findSortDescriptors(filterStyle: filter)
    }
}
                                 
                                 func findSortDescriptors(filterStyle: String) -> [NSSortDescriptor] {
            switch filterStyle {
            case "A-Z":
                return [NSSortDescriptor(key: "title", ascending: true)]
            case "Z-A":
                return [NSSortDescriptor(key: "title", ascending: false)]
            case "$-$$$":
                return [NSSortDescriptor(key: "price", ascending: true)]
            case "$$$-$":
                return [NSSortDescriptor(key: "price", ascending: false)]
            default:
                return [NSSortDescriptor(key: "title", ascending: true)]
            }
        }

                                 func predicateController(search: Bool, searchStr: String) -> NSPredicate {
            if search {
                return NSPredicate(format: "title CONTAINS[cd] %@", searchStr)
            } else {
                return NSPredicate(format: "price CONTAINS[cd] %@", "10")
            }
        }
                                 
                                 func clearDB(dishes: [Dish]) {
            let range = dishes.count-1
            for c in 0...range {
                let d = dishes[c]
                persistence.container.viewContext.delete(d)
            }
            try? persistence.container.viewContext.save()
        }

                                 var searchOn = false
                                 var filter = "A-Z"
                                 var searchStr = "10"
struct Menu: View {
            @Environment(\.managedObjectContext) private var viewContext
            @State var refresh = false
            @State var searchTerm = ""
            @State var filterText = ""
    
    func buildSortDescriptors() -> [NSSortDescriptor]{
                return [
                    NSSortDescriptor(key:"title",
                                     ascending: true,
                                     selector: #selector(NSString.localizedStandardCompare))
                ]
            
        }
        
    func buildPredicate(filter:String) -> NSPredicate{
        if(!filter.isEmpty && searchTerm == ""){
            return NSPredicate(format: "category CONTAINS[cd] %@", filter)
        } else {
            return searchTerm == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchTerm)
            
        }
    }
            
            func update() {
                refresh.toggle()
            }
            
            func getMenuData() {
                if(hasMenuLoaded) {
                    clearDB(dishes: Array(dishes))
                }
                let dataAddress: String =
                        "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
                 
                let url = URL(string: dataAddress)
                let req = URLRequest(url: url!)
                let dataTask = URLSession.shared.dataTask(with: req) {d,r,e in
                    if let data = d,
                       let string = String(data: data, encoding: .utf8) {
                        rawData = string
                    }
                    let jsonData = rawData.data(using: .utf8)
                    if let menu = try? JSONDecoder().decode(MenuList.self, from: jsonData!) {
                        for item in menu.menu {
                            let sel = Dish(context: viewContext)
                            sel.title = item.title
                            sel.image = item.image
                            sel.price = item.price
                            sel.category = item.category
                        }
                        try? persistence.container.viewContext.save()
                    }
                }
                dataTask.resume()
                hasMenuLoaded=true
                update()
            }
            
            @FetchRequest(sortDescriptors: fetchController(search: searchOn, filter: filter, searchStr: searchStr),
            predicate: predicateController(search: searchOn, searchStr: searchStr))
            var dishes: FetchedResults<Dish>
            
            
    var body: some View {
        VStack {
            HStack {
                Image("littlelemonlogo - small")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 60, alignment: .top)
                Image("Profile")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
            }.background(Color.white)
            
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Text("Little Lemon").font(.largeTitle).foregroundColor(Color.yellow)
                                .frame(width: 200, alignment: .leading)
                            Text("Chicago").font(.title2).foregroundColor(Color.white)
                                .frame(width: 100, alignment: .leading)
                            
                        }
                        Image("Stock Image")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 75, alignment: .trailing)
                    }
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.body).foregroundColor(Color.white)
                        .padding(.vertical, 5)
                }.frame(width: 300, height: 250)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black,lineWidth: 7)
                        .frame(width: 270, height: 45)
                        .background(Color.gray)
                    HStack {
                        Image(systemName: "magnifyingglass").resizable()
                            .aspectRatio(contentMode: .fit)
                        TextField("Serach",text: $searchTerm)
                    }.frame(width: 250, height: 25)
                }
            }
            .frame(width: 400, height: 330).background(Color.green)
            
            Text("ORDER FOR DELIVERY!")
                .bold()
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal){
                HStack(spacing:10){
                    Button {
                        filterText = ""
                    } label: {
                        Text("Menu")
                            .bold()
                            .padding(10)
                    }
                    .background(styleGreen)
                    .foregroundColor(styleYellow)
                    .cornerRadius(10)
                    
                    Button {
                        filterText = "starters"
                    } label: {
                        Text("Starters")
                            .bold()
                            .padding(10)
                    }
                    .background(styleGreen)
                    .foregroundColor(styleYellow)
                    .cornerRadius(10)
                    
                    Button {
                        filterText = "mains"
                    } label: {
                        Text("Mains")
                            .bold()
                            .padding(10)
                    }
                    .background(styleGreen)
                    .foregroundColor(styleYellow)
                    .cornerRadius(10)
                    
                    Button {
                        filterText = "desserts"
                    } label: {
                        Text("Desserts")
                            .bold()
                            .padding(10)
                    }
                    .background(styleGreen)
                    .foregroundColor(styleYellow)
                    .cornerRadius(10)
                    
                    Button {
                        filterText = "drinks"
                    } label: {
                        Text("Drinks")
                            .bold()
                            .padding(10)
                    }
                    .background(styleGreen)
                    .foregroundColor(styleYellow)
                    .cornerRadius(10)
                    
                    
                }
            }
            
            /*List (dishes)*/
            PredicateFetchedObjects(
                predicate:buildPredicate(filter:filterText), sortDescriptors:buildSortDescriptors()){  (dishes: [Dish]) in
                    List{ VStack{
                        ForEach(dishes, id: \.self) {dish in
                            HStack {
                                VStack {
                                    Text(dish.title ?? "Unknown title").frame(width: 150,alignment: .leading).font(.title3)
                                    Text("$" + (dish.price ?? "Unknown Price")).frame(width: 150, alignment: .leading).font(.body)
                                }.frame(alignment: .leading)
                                Spacer()
                                AsyncImage(url: URL(string:dish.image ?? "ellipsis")) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                    
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 50, alignment: .trailing)
                            }
                            .frame(width: 300, alignment: .center)
                        }
                        
                    }.onAppear {
                        if(!hasMenuLoaded) {
                            getMenuData()
                        }
                    }
                    }
                }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
