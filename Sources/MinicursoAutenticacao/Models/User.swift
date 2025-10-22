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
        passwordHash: String
    ) {
        self.id = id
        self.username = username
        self.passwordHash = passwordHash
    }
}
