//
//  TableCellProtocol.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-09.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

protocol TableCellProtocol {
    static var identifier : String {get set}
    func setupAccessibility()
    func configure(from record:Topic)
}
