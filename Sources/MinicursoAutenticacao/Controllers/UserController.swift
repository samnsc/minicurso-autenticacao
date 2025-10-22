import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        routes.post("register", use: self.register)
        routes.post("login", use: self.login)
        routes.get("photo", use: self.photo)
    }

    @Sendable
    func register(request: Request) async throws -> HTTPStatus {
        return .ok
    }
    
    @Sendable
    func login(request: Request) async throws -> HTTPStatus {
        return .ok
    }
    
    @Sendable
    func photo(request: Request) async throws -> HTTPStatus {
        return .ok
    }
}
