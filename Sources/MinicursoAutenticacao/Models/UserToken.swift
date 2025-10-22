import Fluent

final class UserToken: Model, @unchecked Sendable {
    static let schema = "user_token"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Parent(key: "user_id")
    var user: User

    init() {}

    init(
        id: UUID? = nil,
        value: String,
        userId: User.IDValue
    ) {
        self.id = id
        self.value = value
        self.$user.id = userId
    }
    
    func toResponse() -> UserTokenResponse {
        return UserTokenResponse(
            token: self.value
        )
    }
}
