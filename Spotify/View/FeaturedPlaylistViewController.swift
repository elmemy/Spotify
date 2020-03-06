//
//  FeaturedPlaylistViewController.swift
//  Spotify
//
//  Created by ahmed elmemy on 3/6/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class FeaturedPlaylistViewController: UIViewController {
    
    
    @IBOutlet weak var FeaturedPlaylistTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let bag = DisposeBag()
    let Api = APIService()
    
    lazy var viewModel: FeaturedPlaylistViewModel = {
        return FeaturedPlaylistViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        FeaturedPlaylistTableView.delegate = self
        FeaturedPlaylistTableView.dataSource = self
        initView()
        initVM()
        viewModel.RxSwift()
        
    }
    
    func initView() {
        self.navigationItem.title = "Featured Playlist"
        
    }
    
    
    func initVM() {
        
        // RxSwift binding
        
        viewModel.alertMessage.asObservable()
            .subscribe(onNext:{ value in
                DispatchQueue.main.async {
                    self.showAlert(value)
                }
            })
        
        viewModel.state.asObservable()
            .subscribe(onNext:{ value in
                
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    switch self.viewModel.state.value {
                    case .empty, .error:
                        self.activityIndicator.stopAnimating()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.FeaturedPlaylistTableView.alpha = 0.0
                        })
                    case .loading:
                        self.activityIndicator.startAnimating()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.FeaturedPlaylistTableView.alpha = 0.0
                        })
                    case .populated:
                        self.activityIndicator.stopAnimating()
                        UIView.animate(withDuration: 0.2, animations: {
                            self.FeaturedPlaylistTableView.alpha = 1.0
                        })
                    }
                }
            })
        
        viewModel.CellViewModel.asObservable()
            .subscribe(onNext:{ value in
                self.FeaturedPlaylistTableView.reloadData()
            })
            
            .addDisposableTo(bag)
        
        
        viewModel.initFetch()
        
    }
    
    
    func showAlert( _ message: String ) {
        if message != ""
        {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension FeaturedPlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturedPlaylistCell", for: indexPath) as? FeaturedPlaylistCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.featuredPlaylistCellViewModel = cellVM
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numbeOfCells
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.userPressed(at: indexPath)
        print(viewModel.selectedItem!.id)
    }
    
    
    
}


