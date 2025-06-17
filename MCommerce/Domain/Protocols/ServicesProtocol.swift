//
//  ServicesProtocol.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

protocol RemoteServicesProtocol {
    func callRestApi(parameters : [String: Any], method : HTTPMethod, json:String)
    func callQueryApi<T: Decodable>(query: String, variables: [String: Any]?, useToken : Bool, completion : @escaping (Result<T, NetworkError>) -> Void)
}
