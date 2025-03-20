//
//  Endpoint.swift
//  NetworkLayer
//
//  Created by hamid on 06.02.25.
//

import Foundation

//GET    Veri alma    Kullanıcı bilgisi çekme

//POST    Veri gönderme    Yeni post oluşturma

//PUT    Veri güncelleme    Post düzenleme

//DELETE    Veri silme    Post kaldırma
enum httpMethod: String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
}



enum Endpoint{
    case GetUsers
    case comments
}



protocol endpointProtocol {
    var baseUrl: String { get }
    var path : String { get }
    var method : httpMethod { get }
    var header : [String:String]? { get }
    
    // bir fonksiyon bana URLrequest dondursun
    func request() -> URLRequest
}




extension Endpoint:endpointProtocol{
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        
        // enum Endpoint tek tek alacak enum fazla case olsa otamatik olarak fix kiyip path yazmak gerekiyor
        switch self {
            
        case .GetUsers:
            return "/users"
      
        case .comments:
            return "/comments"
        }
    }
    
    var method: httpMethod {
        // htpp enumda yazilan get i retrunlar donduruyon enum end pointde kactane varsa yine hangisiyle donecekse burda yaziliyor
        switch self{
            
        case .GetUsers: return .get
        case .comments: return .get
        }
    }
    
    var header: [String : String]? {
       //token olmadigi icin nil donduruyoruz
        //var header : [String : String] = ["Authorization" : "bearer\(token)"]
        return nil
    }
    
    func request() -> URLRequest {
        guard var commpents = URLComponents(string: baseUrl)else{
            fatalError("url hatalidir")
        }
        commpents.path = path
        var request = URLRequest(url: commpents.url!)
        request.httpMethod = method.rawValue
        
        
        if let header = header{
            for (key,value) in header{
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
    
}
