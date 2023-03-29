//
//  ViewController.swift
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad () {
        super.viewDidLoad ()
        Allo.i ("viewDidLoad", String (describing: self))
        
        rotateFirebase ()
    }
    
    func rotateNotification (_ userInfo: [AnyHashable: Any]) {
        Allo.i ("rotateNotification", String (describing: self))
        
        // 푸시 알림 기본 데이터
        if let aps = userInfo ["aps"] as? [AnyHashable: Any],
           let alert = aps ["alert"] as? [AnyHashable: Any],
           let title = alert ["title"] as? String,
           let message = alert ["body"] as? String {
            // 추가 데이터 (바로가기 링크)
            let optionalLink : String? = userInfo ["link"] as? String
            Allo.i ("Check [\(title)][\(message)][\(String (describing: optionalLink))]")
            if let link = optionalLink {
                if let check = URL(string: link), check.scheme != nil, check.host != nil {
                    UIApplication.shared.open (check, options: [:], completionHandler: nil)
                }
            }
        }
    }

    func rotateFirebase () {
        Allo.i ("rotateFirebase", String (describing: self))

        NotificationCenter.default.addObserver(self,
                                               selector: #selector (rotateToken (_:)),
                                               name: NSNotification.Name ("FCMToken"),
                                               object: nil)
    }
    
    @objc func rotateToken (_ notification: Notification) {
        Allo.i ("rotateToken", String (describing: self))

        if let token = notification.userInfo?["token"] as? String {
            registDevice (token)
        }
    }
    
    func registDevice (_ token: String) {
        Allo.i ("registDevice ", String (describing: self))

        // 필요시 로컬 및 리모트 서버 연동하여 저장함
        Allo.i ("Check token [\(token)]")
    }
}

