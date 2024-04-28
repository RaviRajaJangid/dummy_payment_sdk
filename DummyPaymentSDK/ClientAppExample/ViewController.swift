//
//  ViewController.swift
//  ClientAppExample
//
//  Created by Ravi Raja Jangid on 28/04/24.
//

import UIKit
import DummyPaymentSDK


class ViewController: UIViewController {
    let gTotal = 1200.00
    

    @IBOutlet weak var _labelTotal: UILabel!
    @IBAction func onSubmit(_ sender: Any) {
       startPayment()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        _labelTotal.text = String(gTotal)
        
    }
    
}

extension ViewController: PaymentProtocols {
    func paymentSuccess(details: DummyPaymentSDK.PaymentSuccessDetails) {
        
    }
    
    func paymentFailed(details: DummyPaymentSDK.PaymentFailedDetails) {
        
    }
    
    func startPayment(){
       let nvc = PaymentSDK.startPayment(amount: gTotal, delegate: self)
       self.present(nvc, animated: true)
    }
}
