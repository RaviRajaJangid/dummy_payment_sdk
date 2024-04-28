//
//  PaymentSDK.swift
//  DummyPaymentSDK
//
//  Created by Ravi Raja Jangid on 28/04/24.
//

import Foundation
import UIKit

public class PaymentSDK {
    
    public static func  startPayment(amount: Double,  delegate: PaymentProtocols)-> UINavigationController{
        let nvc =  CardDetailsVC.loadViewController()
          guard let vc = nvc.viewControllers.first as? CardDetailsVC else {
              fatalError("CardDetailsVC Not found")
          }
          
          vc.delegate = delegate
          vc.payment = Payment(amount: amount)
          return nvc
    }
}
