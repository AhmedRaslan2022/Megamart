//
//  HighlightedButton.swift
//  Megamart
//
//  Created by Macintosh on 13/07/2022.
//

import Foundation
import UIKit

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .systemIndigo: .blue
        }
    }
}
