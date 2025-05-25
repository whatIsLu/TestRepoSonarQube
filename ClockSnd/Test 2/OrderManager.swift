import Foundation

class OrderManager {
    var activeOrders: [String: Double] = [:]
    var onOrderUpdate: (() -> Void)?

    func addOrder(id: String, amount: Double) {
        if amount <= 0 {
            print("Сума замовлення має бути позитивною.")
            return
        }
        activeOrders[id] = amount
        logOrderActivity(message: "Замовлення \(id) додано на суму \(amount)")
        onOrderUpdate?()
    }

    func updateOrderAmount(id: String, newAmount: Double) {
        if newAmount <= 0 {
            print("Нова сума замовлення має бути позитивною.")
            return
        }
        if activeOrders[id] != nil {
            activeOrders[id] = newAmount
            logOrderActivity(message: "Сума замовлення \(id) оновлена до \(newAmount)")
            onOrderUpdate?()
        } else {
            print("Замовлення \(id) не знайдено для оновлення.")
        }
    }

    private func logOrderActivity(message: String) {
        print("[LOG Orders] \(Date()): \(message)")
    }

    func calculateTotalActiveOrdersValue() -> Double {
        var total: Double = 0
        for orderId in activeOrders.keys {
            total += activeOrders[orderId]!
        }
        return total
    }
    
    func setupOrderNotifications() {
        self.onOrderUpdate = {
            print("Список замовлень оновлено. Поточна кількість: \(self.activeOrders.count)")
        }
    }

    deinit {
        print("OrderManager deallocated")
    }
}

class OrderUIManager {
    let orderManager: OrderManager

    init(orderManager: OrderManager) {
        self.orderManager = orderManager
        orderManager.onOrderUpdate = {
             self.refreshUI()
        }
    }

    func refreshUI() {
        print("UI оновлено, кількість замовлень: \(orderManager.activeOrders.count)")
    }

    deinit {
        print("OrderUIManager deallocated")
    }
}