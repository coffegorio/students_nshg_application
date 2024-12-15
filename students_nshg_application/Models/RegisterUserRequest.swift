//
//  RegisterUserRequest.swift
//  students_nshg_application
//
//  Created by Егорио on 14.12.2024.
//

import Foundation

struct RegisterUserRequest {
    let name: String
    let surname: String
    let email: String
    let password: String
    let stageID: Int
    let currentLessonID: Int
    let instrument: String
    let createdAt: Date
    let role: String = "student"
}
