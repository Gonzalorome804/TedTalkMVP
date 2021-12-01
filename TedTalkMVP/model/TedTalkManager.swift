//
//  TedTalkManager.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 30/11/2021.
//

import Foundation

enum ParseErrors: Error {
    case fileNotFound
    case invalidData
    case decodingDataIsCorrupted
    case decodingErrorOnKey(String)
    case decodingGeneralError(String)
}

class TedTalkManager {
    func parseFromJson(fileName: String, onCompletion: @escaping (Result<[TedTalk], ParseErrors>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Bundle.main.url(forResource: fileName, withExtension: "json")
            guard let myUrl = url else {
                onCompletion(.failure(.fileNotFound))
                return
            }
            guard let myData = try?
                    Data(contentsOf: myUrl) else {
                onCompletion(.failure(.invalidData))
                print("The data is invalid")
                return
            }
            do {
                let talks = try JSONDecoder().decode([TedTalk].self, from: myData)
                onCompletion(.success(talks))
            } catch DecodingError.dataCorrupted(_) {
                onCompletion(.failure(.decodingDataIsCorrupted))
                print("Happened a problem decoding the data: Data corrupted")
            } catch DecodingError.keyNotFound(let codingKey, _) {
                onCompletion(.failure(.decodingErrorOnKey(codingKey.stringValue)))
                print("Happened a problem decoding the data: \(codingKey.stringValue)")
            } catch let error {
                onCompletion(.failure(.decodingGeneralError(error.localizedDescription)))
                print("Happened a problem decoding the data: \(error.localizedDescription)")
            }
        }
    }
}
