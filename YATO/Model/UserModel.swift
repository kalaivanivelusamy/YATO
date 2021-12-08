
import Foundation

struct UserModel {
    
    let emailId: String
    let userName: String
    let userId: String
    let profilePhotoURL: String
    
    
    enum UserInfoKey {
        static let email = "email"
        static let name = "name"
        static let profilePhotoURL = "imageURL"
    }
    
    
    init(userId: String, name: String, emailId: String, photoUrl: String) {
        self.userId = userId
        self.emailId = emailId
        self.userName = name
        self.profilePhotoURL = photoUrl
        
    }
    
    init?(userId: String, userInfo: [String : Any]) {
        let userName = userInfo[UserInfoKey.name] as? String ?? ""
        let photoURL = userInfo[UserInfoKey.profilePhotoURL] as? String ?? ""
        let emailAddress = userInfo[UserInfoKey.email] as? String ?? ""
        
        self.init(userId: userId, name: userName, emailId: emailAddress, photoUrl: photoURL)
    }
}
