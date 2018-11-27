//
//  AmericaTVGoForgotPasswordViewController.swift
//  AmericaTVGoAuthProvider-iOS
//
//  Created by Roi Kedarya on 17/07/2018.
//

import ApplicasterSDK

class AmericaTVGoForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: AmericaTVGoTextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = emailTextField.becomeFirstResponder()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        if let email = self.emailTextField.text,
            !email.isEmpty {
            self.activityIndicator.startAnimating()
            
            let manager = AmericaTVGoAPIManager.shared
            
            manager.forgotPassword(email: email) { (success: Bool, message: String?) in
                self.activityIndicator.stopAnimating()
                if success {
                    let alertViewController = UIAlertController(title: nil, message: message ?? "¡Recuperacion de contraseña exitoso!", preferredStyle: .alert)
                    
                    alertViewController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
                        self.dismiss(animated: true) {
                            
                        }
                    }))
                    
                    self.present(alertViewController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: nil, message: message ?? "Ocurrio un error.", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: nil,
                                                    message: "Por favor asegúrate de escribir tu email.",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
