//
//  NavigationControllerView.swift
//  
//
//  Created by Bradley Kukuk on 8/23/20.
//

struct NavigationControllerView: UIViewControllerRepresentable {
    func makeCoordinator() -> NavigationView.Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationView>) -> NavigationViewController {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationView>) -> NavigationViewController {
            let navigationViewController = NavigationViewController(for: directionsRoute!)
            navigationViewController.delegate = context.coordinator
            return navigationViewController
        }
    }
    
    func updateUIViewController(_ uiViewController: NavigationViewController, context: UIViewControllerRepresentableContext<NavigationView>) {
        // do nothing
    }
    
    class Coordinator: NSObject, NavigationViewControllerDelegate {
        var control: NavigationView
        
        init(_ control: NavigationView) {
            self.control = control
        }
    }
}
