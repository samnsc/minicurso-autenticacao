import Fluent
import Vapor
import Crypto

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.post("register", use: self.register)
        routes.post("login", use: self.login)
        routes.get("photo", use: self.photo)
    }

    @Sendable
    func register(request: Request) async throws -> UserTokenResponse {
        let userRequest = try request.content.decode(UserRequest.self)
        
        if userRequest.password.count < 8
            || userRequest.password != userRequest.passwordConfirmation
        {
            throw Abort(.unprocessableEntity, reason: "Password is too short or doesn't match confirmation")
        }
        
        let user = try userRequest.toModel()
        try await user.create(on: request.db)
        
        let userToken = try user.generateToken()
        try await userToken.create(on: request.db)
    
        return userToken.toResponse()
    }
    
    @Sendable
    func login(request: Request) async throws -> UserTokenResponse {
        guard let authentication = request.headers.basicAuthorization else {
            throw Abort(.unauthorized)
        }
        
        let user = try await User.query(on: request.db)
            .filter(\.$username == authentication.username)
            .first()
        
        guard let user = user else {
            throw Abort(.unauthorized)
        }
        
        if !(try Bcrypt.verify(authentication.password, created: user.passwordHash)) {
            throw Abort(.unauthorized)
        }
        
        let userToken = try user.generateToken()
        try await userToken.create(on: request.db)
        
        return userToken.toResponse()
    }
    
    @Sendable
    func photo(request: Request) async throws -> UserResponse {
        guard let authentication = request.headers.bearerAuthorization else {
            throw Abort(.unauthorized)
        }
        
        let userToken = try await UserToken.query(on: request.db)
            .filter(\UserToken.$value == authentication.token)
            .with(\.$user)
            .first()
        
        guard let userToken = userToken else {
            throw Abort(.unauthorized)
        }
        
        return userToken.user.toResponse()
    }
}
