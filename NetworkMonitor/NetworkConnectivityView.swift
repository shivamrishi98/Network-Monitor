//
//  NetworkConnectivityView.swift
//  NetworkMonitor
//
//  Created by Shivam Rishi on 10/03/21.
//

import UIKit

enum NetworkStatus:String {
    case connected = "Connected"
    case notConnected = "Not Connected"
}

struct NetworkConnectivityViewViewModel {
    let networkStatus:NetworkStatus
    let networkType:NetworkMonitor.ConnectionType
    let lowDataMode:Bool
    let hotspotMode:Bool
}

class NetworkConnectivityView: UIView {

    private let statusLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let typeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let lowDataModeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let hotspotModeLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(statusLabel)
        addSubview(typeLabel)
        addSubview(lowDataModeLabel)
        addSubview(hotspotModeLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        statusLabel.frame = CGRect(x: 10,
                             y: 0,
                             width: frame.size.width-20,
                             height: 50)
        
        typeLabel.frame = CGRect(x: 10,
                                 y: statusLabel.frame.origin.y + statusLabel.frame.size.height,
                             width: frame.size.width-20,
                             height: 50)
        
        lowDataModeLabel.frame = CGRect(x: 10,
                                 y: typeLabel.frame.origin.y + typeLabel.frame.size.height + 50,
                             width: frame.size.width-20,
                             height: 50)
        
        hotspotModeLabel.frame = CGRect(x: 10,
                                 y: lowDataModeLabel.frame.origin.y + lowDataModeLabel.frame.size.height,
                             width: frame.size.width-20,
                             height: 50)
        
        

    }
    
    func configure(with viewModel:NetworkConnectivityViewViewModel) {
        statusLabel.text = "Network Status: \(viewModel.networkStatus.rawValue)"
        typeLabel.text = "Connection Type: \(viewModel.networkType.rawValue)"
        lowDataModeLabel.text = "Low Data Mode: \(viewModel.lowDataMode)"
        hotspotModeLabel.text = "Hotspot Mode: \(viewModel.hotspotMode)"
    }
    

}
