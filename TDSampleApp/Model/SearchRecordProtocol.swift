//
//  SearchRecordProtocol.swift
//  TDSampleApp
//
//  Created by Jeremy Evans on 2018-05-10.
//  Copyright © 2018 jde. All rights reserved.
//

import Foundation

protocol SearchRecord {
    var url: String? {set get}
    var title: String? {set get}
    var icon : Icon? {set get}
}
