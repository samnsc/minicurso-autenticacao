import Fluent

final class User: Model, @unchecked Sendable {
    static let schema = "user"

    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "photo_url")
    var photoUrl: String
    
    required init() { }
    
    init(
        id: UUID? = nil,
        username: String,
        passwordHash: String,
        photoUrl: String = "https://www.vets4pets.com/siteassets/species/cat/cat-close-up-of-side-profile.jpg"
    ) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
        self.photoUrl = photoUrl
    }
    
    func toResponse() -> UserResponse {
        return UserResponse(
            username: self.username,
            photoUrl: self.photoUrl
        )
    }
    
    func generateToken() throws -> UserToken {
        return UserToken(
            value: [UInt8].random(count: 64).base64,
            userId: try self.requireID()
        )
    }
}
