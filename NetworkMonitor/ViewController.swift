//
//  ViewController.swift
//  NetworkMonitor
//
//  Created by Shivam Rishi on 10/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    private let networkMonitor = NetworkMonitor()
    
    private let notificationCenter = NotificationCenter.default
    private let networkConnectivityView = NetworkConnectivityView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(networkConnectivityView)
        notificationCenter.addObserver(self,
                                       selector: #selector(listeningNetworkConnection),
                                       name: NSNotification.Name("connectionType"),
                                       object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
      
    
    @objc func appDidBecomeActive() {
        networkMonitor.startMonitoring()

    }
    
    @objc func appMovedToBackground() {
        networkMonitor.stopMonitoring()
    }
    
    @objc private func listeningNetworkConnection() {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        let connectionType = networkMonitor.connectionType
        let lowDataMode = networkMonitor.lowDataMode
        let hotspotMode = networkMonitor.hotspotMode
        if networkMonitor.isConnected{
            print("connected")
            networkConnectivityView.configure(
                with: NetworkConnectivityViewViewModel(
                    networkStatus: .connected,
                    networkType: connectionType,
                    lowDataMode: lowDataMode,
                    hotspotMode: hotspotMode))
            view.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.6)
        } else {
            print("Not connected")
            networkConnectivityView.configure(
                with: NetworkConnectivityViewViewModel(
                    networkStatus: .notConnected,
                    networkType: connectionType,
                    lowDataMode: lowDataMode,
                    hotspotMode: hotspotMode))
            view.backgroundColor = UIColor.systemRed.withAlphaComponent(0.6)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        networkConnectivityView.frame = CGRect(x: 0,
                                               y: 0,
                                               width: view.frame.size.width,
                                               height: 50)
        networkConnectivityView.center = view.center
    }
}

