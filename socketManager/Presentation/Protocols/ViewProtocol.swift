//
//  ViewProtocol.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

protocol PresenterProtocol: class {
    
    func resetUIWithConnection(status: Bool)
    func updateStatusViewWith(status: String)
    func update(message: String)
}
