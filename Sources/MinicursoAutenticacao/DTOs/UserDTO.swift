import Vapor
import Crypto

struct UserRequest: Content {
    var username: String
    var password: String
    var passwordConfirmation: String
    
    func toModel() throws -> User {
        return User(
            username: username,
            passwordHash: try Bcrypt.hash(password),
            photoUrl: "https://www.vets4pets.com/siteassets/species/cat/cat-close-up-of-side-profile.jpg"
        )
    }
}

struct UserResponse: Content {
    var username: String
    var photoUrl: String
}

