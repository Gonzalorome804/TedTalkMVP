//
//  TedTalkManager.swift
//  TedTalkMVP
//
//  Created by Gonzalo Romero on 30/11/2021.
//

import Foundation

enum ParseErrors: Error {
    case wrongURL
    case fileNotFound
    case invalidData
    case decodingDataIsCorrupted
    case decodingErrorOnKey(String)
    case decodingGeneralError(String)
}

class TedTalkManager {
    
    func retrieveFromServer(onCompletion: @escaping (Result<[TedTalk], ParseErrors>) -> Void){
        let url = URL(string: "https://raw.githubusercontent.com/Globant-Academy-iOS/iOS_Academy_base_project/main/Ted%20Talk/Ted%20Talk/Assets/tedTalks.json")
        guard let myURL = url else {
            onCompletion(.failure(.wrongURL))
            return
        }
        let task = URLSession.shared.dataTask(with: myURL) {(myData, response, error) in
            guard let receivedData = myData else{
                onCompletion(.failure(.invalidData))
                return
            }
            do {
                let tedTalks = try JSONDecoder().decode([TedTalk].self, from: receivedData)
                onCompletion(.success(tedTalks))
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
        task.resume()
    }
    
}
