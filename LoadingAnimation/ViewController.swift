//
//  ViewController.swift
//  LoadingAnimation
//
//  Created by Sagar Baloch on 02/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var startLoadingTitle = true
    var loading: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading = LoadingView(controllerView: view, colorOfCircle: UIColor.blue.cgColor, radiusOfCircle: 200)
    }
    
    override func viewWillLayoutSubviews() {
        view.addSubview(loadingButton)
    }
    
    fileprivate lazy var loadingButton: UIButton = {
        let b = UIButton()
        b.frame = CGRect(x: (view.frame.width/2)-60, y: 100, width: 120, height: 50)
        b.backgroundColor = .red
        b.setTitle("Start Loading", for: .normal)
        b.addTarget(self, action: #selector(loadingButtonClicked), for: .touchUpInside)
        return b
    }()
    
    @objc func loadingButtonClicked(){
        guard let loadingView = loading else { return }
        if startLoadingTitle {
            //Showing the loading
            loadingView.startLoading()
            loadingButton.setTitle("Stop Loading", for: .normal)
            startLoadingTitle = false
        }else{
            //Stoping the loading
            loadingView.stopLoading()
            loadingButton.setTitle("Start Loading", for: .normal)
            startLoadingTitle = true
        }
    }
}

