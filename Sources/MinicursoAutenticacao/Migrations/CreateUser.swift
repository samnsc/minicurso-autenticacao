import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("user")
            .id()
            .field("username", .string, .required)
            .field("password_hash", .string, .required)
            .field("photo_url", .string, .required, .sql(.default("https://www.vets4pets.com/siteassets/species/cat/cat-close-up-of-side-profile.jpg")))
            .unique(on: "password_hash")
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("user").delete()
    }
}
