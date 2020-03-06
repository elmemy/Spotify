//
//  FeaturedPlaylistViewModel.swift
//  Spotify
//
//  Created by ahmed elmemy on 3/6/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa
class FeaturedPlaylistViewModel {
    let apiService :APIServiceProtocol
    private var  playList: [Item] = [Item]()
    private var  playlistsModel: [Playlists] = [Playlists]()
 
    
    var CellViewModel = Variable<[FeaturedPlaylistCellViewModel]>([])
    var alertMessage = Variable<String>("")
    var state =  Variable<State>(.empty)

    func RxSwift(){
        CellViewModel.asObservable()
        alertMessage.asObservable()
        state.asObservable()
    }
    
    
    
    var numbeOfCells : Int
    {
        return CellViewModel.value.count
    }
    
    
    var selectedItem: Item?
    
  
    
    init( apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        
    }
    
    
    
    func initFetch() {
        state.value = .loading
        apiService.fetchPopularPlaylist { [weak self] (success, playLists, error) in
            guard let self = self else {
                return
            }
            
            
            guard error == nil else {
                self.state.value = .error
                self.alertMessage.value = error?.rawValue ?? ""
                return
            }
            
            self.processFetchedPlayList(playLists: playLists)
            self.state.value = .populated

        }
        
        
    }
    
    
    func createCellViewModel(playList : Item)->FeaturedPlaylistCellViewModel
    {
        return FeaturedPlaylistCellViewModel(name: playList.name, ownderName: playList.owner.displayName.rawValue, image: playList.images[0].url)
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> FeaturedPlaylistCellViewModel {
        return CellViewModel.value[indexPath.row]
    }
    
    private func processFetchedPlayList( playLists: [Item] ) {
        self.playList = playLists // Cache
        var vms = [FeaturedPlaylistCellViewModel]()
        for playList in playLists {
            vms.append( createCellViewModel(playList: playList) )
        }
        self.CellViewModel.value = vms
    }
    
    
    
    
    
}
extension FeaturedPlaylistViewModel
{
    func userPressed(at indexPath:IndexPath)  {
        let playLists = self.playList[indexPath.row]
        selectedItem = playLists
        
    }
}
