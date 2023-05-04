//
//  DependencyInjectionPatternTests.swift
//  DependencyInjectionPatternTests
//
//  Created by Miguel Angel Bric Ulloa on 04/05/23.
//

import XCTest
@testable import Dependency_Injection_Pattern

final class DependencyInjectionPatternTests: XCTestCase {
    
    var viewModel: UsersViewModel!
    var provider: UsersProviderProtocol!

    override func setUpWithError() throws {
        provider = UsersProviderMock()
        viewModel = UsersViewModel(provider: provider)
    }

    override func tearDownWithError() throws {
        provider = nil
        viewModel = nil
    }

    func testGetUserFromProvider() throws {
        let expectation = expectation(description: "retrieving data...")
        viewModel.getUserFromProvider { usersModelArray in
            usersModelArray.forEach { object in
                print("title: ", object.name!)
            }
            XCTAssertTrue(usersModelArray.count>0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.1)
    }


}
