import UIKit

var str = "Hello, playground"

protocol ItemStoring {
    associatedtype Datatype
    
    var items: [Datatype] { get set }
}

extension ItemStoring {
    mutating func add(item: Datatype) {
        items.append(item)
    }
}

struct NameDatabase: ItemStoring {
    var items = [Int]()
}

var intDatabase = NameDatabase()
intDatabase.add(item: 23)
intDatabase.add(item: 43)
print(intDatabase.items)
// print [23, 43]

class StringDateBase: ItemStoring {
    var items = [String]()
}
var stringDatabase = StringDateBase()
stringDatabase.add(item: "Андрей")
stringDatabase.add(item: "kdsk")
print(stringDatabase.items)
// print ["Андрей", "kdsk"]
