import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

/// Manager responsible for signing in, up, and out
final class AuthManager {
    /// Singleton instance of the manager
    static let shared = AuthManager()
    
    /// Check on user logged in or not
    /// - Returns: Returns true if yes or not if false
    func checkOnLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func loginWithGoogle(viewController: UIViewController,
                         completion: @escaping (Result<MovieUser, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                completion(.failure(AuthError.unknownError))
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let user = result?.user else {
                    completion(.failure(AuthError.unknownError))
                    return
                }
                let movieUser = MovieUser(id: user.uid,
                                          firstName: user.displayName ?? "Guest",
                                          email: user.email ?? "",
                                          avatarImageUrl: user.photoURL)
                completion(.success(movieUser))
            }
        }
    }
    
    /// Attempt to sign up
    /// - Parameters:
    ///   - email: User email
    ///   - password: User password
    ///   - confirmPassword: User confirm password
    ///   - firstName: User Firstname
    ///   - lastName: User Lastname
    ///   - completion: Callback that returns MovieUser or result
    func createUser(email: String?, password: String?, confirmPassword: String?,
                    firstName: String?, lastName: String?,
                    completion: @escaping (Result<MovieUser, Error>) -> Void) {
        guard let email = email, let password = password,
              let confirmPassword = confirmPassword,
              let firstName = firstName, let lastName = lastName,
              email != "", password != "", confirmPassword != "",
              firstName != "", lastName != "" else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard password == confirmPassword else {
            completion(.failure(AuthError.passwordNotMatched))
            return
        }
        
        Auth.auth().createUser(withEmail: email,
                               password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let result = result {
                if let email = result.user.email {
                    let user = MovieUser(
                        id: result.user.uid,
                        firstName: firstName, lastName: lastName, email: email
                    )
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.unknownError))
                }
            }
        }
    }
}
