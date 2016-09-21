import Foundation

extension Court {
    static func array(from json: [String : AnyObject]) -> [Court] {
        return json.values.flatMap { court in
            guard let json = court as? [String : AnyObject] else {
                return nil
            }
            return Court(from: json)
        }
    }
    
    init?(from json: [String : AnyObject]) {
        guard let id = json["id"] as? Int else {
            return nil
        }
        
        self.id = id
        
        if let users = json["users"] as? [String : AnyObject] {
            self.players = users.values.flatMap { user in
                guard let json = user as? [String : AnyObject] else {
                    return nil
                }
                return User(from: json)
            }
        } else {
            self.players = [User]()
        }
    }
}

extension User {
    init?(from json: [String : AnyObject]) {
        guard let uid = json["uuid"] as? String,
            let name = json["name"] as? String,
            let email = json["email"] as? String,
            let avatar = json["avatar"] as? String,
            let photoURL = URL(string: avatar) else {
                return nil
        }
        
        self.uid = uid
        self.displayName = name
        self.email = email
        self.photoURL = photoURL
    }
    
    func toJSON() -> [String : Any] {
        return ["uuid" : uid,
                "name" : displayName,
                "email" : email,
                "avatar" : photoURL.absoluteString]
    }
}

extension Message {
    static func array(from json:[String : AnyObject]) -> [Message] {
        return json.values.flatMap { message in
            guard let json = message as? [String : AnyObject] else {
                return nil
            }
            return Message(from: json)
        }
    }
    
    init?(from json: [String : AnyObject]) {
        guard let text = json["message"] as? String,
            let userName = json["name"] as? String,
            let userUid = json["uuid"] as? String,
            let avatar = json["avatar"] as? String,
            let userAvatar = URL(string: avatar) else {
                return nil
        }
        
        self.text = text
        self.userName = userName
        self.userUid = userUid
        self.userAvatar = userAvatar
    }
    
    func toJSON() -> [String : Any] {
        return ["message" : text,
                "name" : userName,
                "uuid" : userUid,
                "avatar" : userAvatar.absoluteString]
    }
}
