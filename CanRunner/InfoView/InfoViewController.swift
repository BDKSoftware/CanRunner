//
//  InfoViewController.swift
//  CanRunner
//
//  Created by kook on 10/9/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI

struct InfoViewController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = InfoView()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
