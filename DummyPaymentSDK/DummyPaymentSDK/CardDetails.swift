//
//  CardDetails.swift
//  DummyPaymentSDK
//
//  Created by Ravi Raja Jangid on 28/04/24.
//

import UIKit
public class Card {
    let number: String
    let expDay: Int
    let expYear: Int
    let holderName: String
    unowned let payment: Payment
    
    init(number: String, expDay: Int, expYear: Int, holderName: String, payment: Payment) {
        self.number = number
        self.expDay = expDay
        self.expYear = expYear
        self.holderName = holderName
        self.payment = payment
    }
}
public struct PaymentSuccessDetails {
    let amount: Double
    let transectionId: String
}

public struct PaymentFailedDetails {
    let amount: Double
    let transectionId: String
    let error: String
}

public protocol PaymentProtocols:AnyObject{
    func paymentSuccess(details: PaymentSuccessDetails)
    func paymentFailed(details: PaymentFailedDetails)
}

class Payment {
    var card: Card?
    let amount: Double
    init(amount: Double) {
        self.amount = amount
    }
}

 class CardDetailsVC: UIViewController {
    var payment: Payment?
    public weak var delegate: PaymentProtocols?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func takeCardDetailsAndProcessPayment(amount: Double){
        let cd = Card(number: "123412341234", expDay: 2, expYear: 25, holderName: "RAVI RAJA JANGID",payment: payment!)
       
        
    }
    
    static func loadViewController()-> UINavigationController {
        let sb = UIStoryboard(name: "PaymentSB", bundle: Bundle(for: self))
        
        guard let nvc = sb.instantiateViewController(withIdentifier: "CardDetailsVC") as? UINavigationController else {
            fatalError("CardDetailsVC Not found")
        }
     
        return nvc
    }
}
