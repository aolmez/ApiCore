//
//  Team.swift
//  ApiCore
//
//  Created by Ondrej Rafaj on 11/12/2017.
//

import Foundation
import Vapor
import Fluent
import FluentPostgreSQL
import DbCore
import ErrorsCore
import ImageCore


/// Teams array type typealias
public typealias Teams = [Team]


/// Team object
public final class Team: DbCoreModel {
    
    /// Team errors
    public enum Error: FrontendError {
        
        /// Team identifier already exists
        case identifierAlreadyExists
        
        /// Error identifier
        public var identifier: String {
            return "app_error.identifier_already_exists"
        }
        
        /// Error HTTP status code
        public var status: HTTPStatus {
            return .conflict
        }
        
        /// Reason for failure
        public var reason: String {
            switch self {
            case .identifierAlreadyExists:
                return "Team identifier already exists"
            }
        }
        
    }
    
    /// Constructing new team
    public struct New: Content {
        
        /// Name
        public var name: String
        
        /// Identifier
        public var identifier: String
        
        /// Team color, random color chosen if none is set
        public var color: String?
        
        /// Team initials, calculated if not set
        public var initials: String?
        
        /// Convert to Team
        public func asTeam() -> Team {
            return Team(name: name, identifier: identifier, color: color, initials: initials)
        }
        
    }
    
    /// Name object
    public struct Name: Content {
        
        /// Name
        public var name: String
        
        /// Initializer
        public init(name: String) {
            self.name = name
        }
        
    }
    
    /// Identifier object
    public struct Identifier: Content {
        
        /// Identifier
        public var identifier: String
        
        /// Initializer
        public init(identifier: String) {
            self.identifier = identifier
        }
        
    }
    
    /// Object id
    public var id: DbCoreIdentifier?
    
    /// Name
    public var name: String
    
    /// Identifier
    public var identifier: String
    
    /// Team color
    public var color: String
    
    /// Team initials
    public var initials: String
    
    /// Admin team
    public var admin: Bool
    
    /// Initializer
    public init(id: DbCoreIdentifier? = nil, name: String, identifier: String, color: String? = nil, initials: String? = nil, admin: Bool = false) {
        self.name = name
        self.identifier = identifier
        self.color = color ?? Color.randomColor().hexValue
        self.initials = initials ?? name.initials
        self.admin = admin
    }
    
}

// MARK: - Relationships

extension Team {
    
    /// Users relation
    public var users: Siblings<Team, User, TeamUser> {
        return siblings()
    }
    
}

// MARK: - Migrations

extension Team: Migration {
    
    /// Migration preparations
    public static func prepare(on connection: DbCoreConnection) -> Future<Void> {
        return Database.create(self, on: connection) { (schema) in
            schema.addField(type: DbCoreColumnType.id(), name: CodingKeys.id.stringValue, isIdentifier: true)
            schema.addField(type: DbCoreColumnType.varChar(40), name: CodingKeys.name.stringValue)
            schema.addField(type: DbCoreColumnType.varChar(40), name: CodingKeys.identifier.stringValue)
            schema.addField(type: DbCoreColumnType.varChar(6), name: CodingKeys.color.stringValue)
            schema.addField(type: DbCoreColumnType.varChar(2), name: CodingKeys.initials.stringValue)
            schema.addField(type: DbCoreColumnType.bool(), name: CodingKeys.admin.stringValue)
        }
    }
    
    /// Migration reverse
    public static func revert(on connection: DbCoreConnection) -> Future<Void> {
        return Database.delete(Team.self, on: connection)
    }
    
}

// MARK: - Queries

extension Team {
    
    /// Does team exist? That is the question!
    public static func exists(identifier: String, on req: Request) throws -> Future<Bool> {
        return try Team.query(on: req).filter(\Team.identifier == identifier).count().map(to: Bool.self, { (count) -> Bool in
            return count > 0
        })
    }
    
}

// MARK: - Helpers

extension Array where Element == Team {
    
    /// Team ids alone in an array
    public var ids: [DbCoreIdentifier] {
        let teamIds = compactMap({ (team) -> DbCoreIdentifier in
            return team.id!
        })
        return teamIds
    }
    
    /// Contains a team with id?
    public func contains(_ teamId: DbCoreIdentifier) -> Bool {
        return ids.contains(teamId)
    }
    
    /// Contains an admin team?
    public func contains(admin: Bool) -> Bool {
        return compactMap({ $0.admin == admin }).count > 0
    }
    
    /// Contains an admin team?
    public var containsAdmin: Bool {
        return contains(admin: true)
    }
    
}
