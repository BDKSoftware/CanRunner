//
//  ImagePicker.swift
//  CanRunner
//
//  Created by kook on 10/9/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
