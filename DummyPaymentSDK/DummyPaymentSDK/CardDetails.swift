//
//  CardDetails.swift
//  DummyPaymentSDK
//
//  Created by Ravi Raja Jangid on 28/04/24.
//

import UIKit
public class Card {
    let number: String
    let expMonth: Int
    let expYear: Int
    let holderName: String
    unowned let payment: Payment
    
    init(number: String, expMonth: Int, expYear: Int, holderName: String, payment: Payment) {
        self.number = number
        self.expMonth = expMonth
        self.expYear = expYear
        self.holderName = holderName
        self.payment = payment
    }
}

 class CardDetailsVC: UIViewController {
     @IBOutlet weak var cardNumber: UITextField!
     @IBOutlet weak var cardExpMonth: UITextField!
     @IBOutlet weak var cardExpYear: UITextField!
     @IBOutlet weak var cardCVV: UITextField!
     @IBOutlet weak var cardHolderName: UITextField!
     var payment: Payment?
    public weak var delegate: PaymentProtocols?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func takeCardDetailsAndProcessPayment(){
        guard let Month = Int(cardExpMonth.text ?? "0"), let year = Int(cardExpYear.text ?? "0") else {
           
            fatalError("Enter card expiry Month")
        }
        guard let year = Int(cardExpYear.text ?? "0") else {
            fatalError("Enter card expiry year")
        }
        let cd: Card = Card(number: cardNumber?.text ?? "",
                      expMonth: Month,
                      expYear: year,
                      holderName: cardHolderName?.text ?? "",
                      payment: payment!)
        payment?.card = cd

        //TASKS:
        //Do network call
        //Parse and Process responses
        //Prepare for presenttaon model
        let error = isErrorRandom();
        
        if(error){
            delegate?.paymentFailed(details: PaymentFailedDetails(amount: payment?.amount ?? 0, transectionId: UUID.init(uuidString: "dsfsd#$53353^*&59756")?.uuidString ?? "", error: "Payment failed"))
        }
        
        if(!error){
            delegate?.paymentSuccess(details: PaymentSuccessDetails(amount: payment?.amount ?? 0, transectionId: UUID.init(uuidString: "dsfsd#$53353^*&59756")?.uuidString ?? ""))
        }
        
        self.dismiss(animated: true)
    }
    
     func isErrorRandom() -> Bool {
     let min: Int = 1, max: Int = 22
         return (Int(arc4random_uniform(UInt32(max - min))) + min) / 2 == 0
     }
     
     @IBAction func doPayment(_ sender: Any) {
         takeCardDetailsAndProcessPayment()
     }
     static func loadViewController()-> UINavigationController {
        let sb = UIStoryboard(name: "PaymentSB", bundle: Bundle(for: self))
        
        guard let nvc = sb.instantiateViewController(withIdentifier: "CardDetailsVC") as? UINavigationController else {
            fatalError("CardDetailsVC Not found")
        }
     
        return nvc
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
