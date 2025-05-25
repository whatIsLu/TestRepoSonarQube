import SwiftUI

struct Item: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var price: Double
    var lastUpdated: Date = Date()
}

struct ItemRowView: View {
    let item: Item

    init(item: Item) {
        self.item = item
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(String(format: "Ціна: %.2f грн", item.price))
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "tag.fill")
        }
        .padding(.vertical, 4)
    }
}

struct ItemListScreen: View {
    @State private var items: [Item] = [
        Item(name: "Ноутбук 'Мрія'", price: 35999.99),
        Item(name: "Смартфон 'Лідер'", price: 18500.00),
        Item(name: "Навушники 'Звук'", price: 3200.50)
    ]
    @State private var searchText: String = ""
    @State private var itemViewID: UUID = UUID()

    private var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Пошук товарів...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .id(itemViewID)

                List(filteredItems) { item in
                    ItemRowView(item: item)
                }
                
                HStack {
                    Button("Додати товар") {
                        let newItem = Item(name: "Новий товар \(items.count + 1)", price: Double.random(in: 100...1000))
                        items.append(newItem)
                    }
                    .padding()

                    Button("Змінити ID Пошуку") {
                        itemViewID = UUID()
                    }
                    .padding()
                }
            }
            .navigationTitle("Каталог Товарів")
        }
    }
}