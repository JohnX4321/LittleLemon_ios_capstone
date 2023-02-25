//
//  Utils.swift
//  LittleLemon
//
//  Created by Samarth MS on 25/02/23.
//

import Foundation
import SwiftUI
import CoreData

struct PredicateFetchedObjects<T,Content> : View where T : NSManagedObject, Content : View {
    
    let content: ([T]) -> Content
    
    var req: FetchRequest<T>
    var res: FetchedResults<T>{req.wrappedValue}
    
    init(predicate: NSPredicate = NSPredicate(value: true), sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping ([T]) -> Content) {
        self.content = content
        self.req = FetchRequest(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
    }
    
    var body: some View {
        self.content(res.map{ $0 })
    }
    
}


let styleGrey = Color(#colorLiteral(red: 0.686, green: 0.686, blue: 0.686, alpha: 1)) 
let styleGreen = Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1))
let styleYellow = Color(#colorLiteral(red: 0.957, green: 0.808, blue: 0.078, alpha: 1))
let styleBlack = Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1))

