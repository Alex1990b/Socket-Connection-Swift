//
//  File.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

protocol DataSocketProtocol {
    var ipAddress: String { get set }
    var port: String { get set }
}
