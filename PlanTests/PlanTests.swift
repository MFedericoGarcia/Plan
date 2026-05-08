//
//  PlanTests.swift
//  PlanTests
//
//  Created by Fede Garcia on 08/05/2026.
//

import XCTest
@testable import Plan

@MainActor
final class PlanTests: XCTestCase {

    private class MockNetworkManager: NetworkManagingProtocol {
        enum Mode { case success([User]), runtimeError(String) }
        let mode: Mode
        init(mode: Mode) { self.mode = mode }
        func getUsers(for endpoint: String, with key: String) async throws -> [User] {
            switch mode {
            case .success(let users):
                return users
            case .runtimeError(let message):
                throw MyError.runtimeError(message)
            }
        }
    }

    private func makeSampleUsers() -> [User] {
        return [
            User(
                id: 1,
                name: "John Doe",
                username: "jdoe",
                email: "john@doe.com",
                address: Address(street: "Main", suite: "Apt 1", city: "NYC", zipcode: "10001", geo: Geo(lat: "0", lng: "0")),
                phone: "123456789",
                website: "example.com",
                company: Company(name: "ACME", catchPhrase: "We build", bs: "biz"))
        ]
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelInitTriggersLoadSuccess() async throws {
        let expected = makeSampleUsers()
        let mock = MockNetworkManager(mode: .success(expected))
        let vm = UsersView.ViewModel(network: mock)

        // Wait briefly to allow Task in load() to run on MainActor
        try await Task.sleep(nanoseconds: 50_000_000) // 50ms

        let state = vm.state
        switch state {
        case .success(let users):
            // Access possibly MainActor-isolated values on the MainActor, then compare
            let usersCount = users.count
            let expectedCount = expected.count
            XCTAssertEqual(usersCount, expectedCount)

            let firstUserId = users.first?.id
            let expectedFirstId = expected.first?.id
            XCTAssertEqual(firstUserId, expectedFirstId)
        default:
            XCTFail("Expected success state after init autoload")
        }
    }

    func testViewModelInitTriggersLoadError() async throws {
        let message = "Network down"
        let mock = MockNetworkManager(mode: .runtimeError(message))
        let vm = UsersView.ViewModel(network: mock)

        try await Task.sleep(nanoseconds: 50_000_000)

        let state = vm.state
        switch state {
        case .error(let err):
            let expectedMessage = message
            XCTAssertEqual(err, expectedMessage)
        default:
            XCTFail("Expected error state after init autoload")
        }
    }

}
