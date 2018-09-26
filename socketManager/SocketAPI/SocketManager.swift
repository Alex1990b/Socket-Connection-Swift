//
//  SocketManager.swift
//  ConnectToWifi
//
//  Created by Sasha on 23.08.18.
//  Copyright © 2018 Sasha. All rights reserved.
//

import Foundation

final class SocketDataManager: NSObject, SocketConnectionProtocol {
  
    private  var readStream: Unmanaged<CFReadStream>?
    private var writeStream: Unmanaged<CFWriteStream>?
    private var inputStream: InputStream?
    private var outputStream: OutputStream?
    private var messages = [AnyHashable]()
    
    weak var uiDelegate :PresenterProtocol!
    
    init(with presenter: PresenterProtocol){
        self.uiDelegate = presenter
    }
    
    func connectWith(socket: DataSocketProtocol) {
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, (socket.ipAddress as CFString), UInt32(socket.port)!, &readStream, &writeStream)
        messages = [AnyHashable]()
    }
    
    func open() {
        outputStream = writeStream?.takeRetainedValue()
        inputStream = readStream?.takeRetainedValue()
        outputStream?.delegate = self
        inputStream?.delegate = self
        outputStream?.schedule(in: RunLoop.current, forMode: .defaultRunLoopMode)
        inputStream?.schedule(in: RunLoop.current, forMode: .defaultRunLoopMode)
        outputStream?.open()
        inputStream?.open()
    }
    
    func close() {
        uiDelegate?.resetUIWithConnection(status: false)
        inputStream?.close()
        outputStream?.close()
        inputStream?.remove(from: RunLoop.current, forMode: .defaultRunLoopMode)
        outputStream?.remove(from: RunLoop.current, forMode: .defaultRunLoopMode)
        inputStream?.delegate = nil
        outputStream?.delegate = nil
        inputStream = nil
        outputStream = nil
    }
    
    func send(message: String) {
        
        let response = "msg:\(message)"
        let buff = [UInt8](message.utf8)
        if let _ = response.data(using: .ascii) {
            outputStream?.write(buff, maxLength: buff.count)
        }
    }
}

extension SocketDataManager: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        
        switch eventCode {
        case .openCompleted:
            uiDelegate?.resetUIWithConnection(status: true)
        case .hasBytesAvailable:
            procces(stream: aStream)
        case .hasSpaceAvailable:
            print("Stream has space available now")
        case .errorOccurred:
            print("\(aStream.streamError?.localizedDescription ?? "")")
        case .endEncountered:
            aStream.close()
            aStream.remove(from: RunLoop.current, forMode: .defaultRunLoopMode)
            uiDelegate?.resetUIWithConnection(status: false)
        default:
            print("Unknown event")
        }
    }
}

private extension SocketDataManager {
    
    func procces(stream: Stream) {
        if stream == inputStream {
            var dataBuffer = Array<UInt8>(repeating: 0, count: 1024)
            var len: Int
            while (inputStream?.hasBytesAvailable)! {
                len = (inputStream?.read(&dataBuffer, maxLength: 1024))!
                if len > 0 {
                    let data = Data(bytes: dataBuffer)
                    let output = String(bytes: dataBuffer, encoding: .ascii)
                    if nil != output {
                        print("server said: \(output ?? "")")
                        uiDelegate?.update(message: "server said: \(String(describing: output))")
                    }
                }
            }
        }
    }
}
