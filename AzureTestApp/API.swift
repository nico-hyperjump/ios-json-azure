//
//  API.swift
//  AzureTestApp
//
//  Created by nico on 07.06.20.
//  Copyright © 2020 nico. All rights reserved.
//

import Foundation

protocol APIDelegate: Codable {
    associatedtype Response
    func didLoad (data: Response)
}

class BaseDelegate<T>: APIDelegate {
    typealias Response = T
    func didLoad(data: T) {
    }
}

struct TheResponse: Codable {
    var name: String
}

public class APILoader {
    weak var delegate: BaseDelegate<TheResponse>?
    
    public func load() {
        let dataTask = URLSession.shared.dataTask(with:  URL(string: "http://localhost:3000/ping")!) { (data, response, error) in
            let dat = try? JSONDecoder().decode(TheResponse.self, from: data!)
            self.delegate?.didLoad(data: dat!)
        }
        dataTask.resume()
    }
}
