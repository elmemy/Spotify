//
//  APIService.swift
//  Spotify
//
//  Created by ahmed elmemy on 3/6/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//


import Foundation
import Alamofire
import RxSwift
import RxCocoa

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    func fetchPopularPlaylist( complete: @escaping ( _ success: Bool, _ Playlists: [Item], _ error: APIError? )->() )
}

class APIService: APIServiceProtocol {
    
    fileprivate let bag = DisposeBag()
    
    
    var Home : PlaylistsModel?
    var PlaylistsData   = [Item]()
    
    
    let header = [
        "Authorization":"Bearer  BQCFfq5-B7R47zH9VsJ58IkQPDw4E5dB1q-vkSf2z8evep4KP-_1EbAYfGYNQvgviG2sGt0iPxeTydKN5bB_zMALMOBeWShe0FG2mkbZt7A3HamLBJnW-u74DE2iqp6-YByz9wMgPVpmRJylJffAhJlmFgZFRNeNFDO26oKBobhrMOHwa1qgKu76063xSMhLljW7efh3aDWVrig86b3U8zX3Z4WoMUmRTNj2KWGXWx86CMzw9iGm67SQdPEiN9i7K-cClicHSz-lCPbVvlDiM7l5xXtlcxk8Qg",
    ]
    
    func fetchPopularPlaylist( complete: @escaping ( _ success: Bool, _ Playlists: [Item], _ error: APIError?)->()) {
        DispatchQueue.global().async {
            sleep(3)
            Alamofire.request(URLs.featuredPlaylists, method: .get, parameters: nil,headers:self.header ).responseJSON { (response) in
                
                switch response.result{
                case .success(_):
                    
                    do{
                        let data = try JSONDecoder().decode(PlaylistsModel.self, from: response.data!)
                        self.Home = data
                        self.handeleViewData(homeData: data)
                        complete(true, self.PlaylistsData, nil)
                        
                    }catch{
                        complete(false,[],APIError.serverOverload)
                        print(error)
                    }
                    
                case .failure(_):
                    complete(false,[],APIError.noNetwork)
                }
            }
            
        }
    }
    
    
    
    
    
    
    func handeleViewData(homeData: PlaylistsModel){
        PlaylistsData = homeData.playlists.items
    }
}
