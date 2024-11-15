//
//  ViewController.swift
//  ManiAuthExampleNoPlugins
//
//  Created by Abdullah Rakhmatullaev on 06/11/24.
//
import UIKit
import Flutter
import FlutterPluginRegistrant


class ViewController: UIViewController, HostAppApi {
  
   
    
    private var token: Token = Token()
    private var hostInfo: HostInfo = HostInfo.make(withPaymentSystemId:"You payment system id goes here", locale: "uz")
    private var api: ManiAuthApi!
    var pluginsRegistered: Bool = false
 
    
    lazy var button: UIButton! = {
       
       let button = UIButton()
       button.setTitleColor(.blue, for: .normal)
       button.setTitle("show me Mani", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
       return button
       
     }()
    
    lazy var text: UILabel = UILabel(frame: CGRectMake(10, 10, 400, 300))
    
    func cancelWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        print("hello")
//        self.navigationController?.popViewController(animated: true)
    }
    func authSuccessToken(_ token: Token, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        self.token = token
        text.text = self.token.accessToken
        self.navigationController?.popViewController(animated: true)
    }
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let flutterEngine = appDelegate.flutterEngine
        SetUpHostAppApi(flutterEngine.binaryMessenger, self)
        api = ManiAuthApi.init(binaryMessenger: flutterEngine.binaryMessenger)
        self.button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.button.backgroundColor = .red
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 320),
            button.heightAnchor.constraint(equalToConstant: 44),
        ])
        text.textColor = UIColor.red
        text.text = token.accessToken
        text.numberOfLines = 10
        self.view.addSubview(text)
    }
    
    @objc private func didTapButton() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        registerFlutterPluginsIfNeeded(engine: appDelegate.flutterEngine)
        let flutterViewController = FlutterViewController(
            engine: appDelegate.flutterEngine, nibName: nil, bundle: nil)
     
        api.send(hostInfo) { (error) in
          if let error = error {
            print(error)
          }
        }
        
      

        self.navigationController?.pushViewController(flutterViewController, animated: true)

    }
    
    func registerFlutterPluginsIfNeeded(engine: FlutterEngine) {

        if !pluginsRegistered {
            GeneratedPluginRegistrant.register(with: engine)
            pluginsRegistered = true  // Mark plugins as registered
        } else {
            print("Plugins are already registered, skipping registration.")
        }
    }
  

}

