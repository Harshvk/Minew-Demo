//
//  AlertManager.swift
//  Minew-Demo
//
//  Created by Harsh Vardhan Kushwaha on 08/02/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func openAlertWithTextfield(title:String, completion: ((String)->())?) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            let answer = ac.textFields?.first
            completion?(answer?.text ?? "")
            ac.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { [unowned ac] _ in
            ac.dismiss(animated: true)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showAlertToast(title:String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)

        let dismissAction = UIAlertAction(title: "Dismiss", style: .default) { [unowned ac] _ in
            ac.dismiss(animated: true)
        }
        ac.addAction(dismissAction)
        present(ac, animated: true)
    }
}
