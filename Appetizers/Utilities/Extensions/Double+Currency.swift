//
//  Double+Currency.swift
//  Appetizers
//
//  Created by Aaron on 2024/8/20.
//

import Foundation
import SwiftUI

extension Double {
    var currency: Text {
        let formatter = NumberFormatter()
        let object = NSNumber(floatLiteral: self)
        formatter.numberStyle = .currency

        return Text(object, formatter: formatter)
    }
}
