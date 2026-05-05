# Plan – Users App (SwiftUI + MVVM)

## Overview
- iOS app that fetches users from a public API and displays a list with navigation to a detail screen. It uses SwiftUI, MVVM, async/await (or completion fallback), Codable models, and explicit view state handling (loading, success, error).

## Features
- List users (name, email)
- Detail screen (name, email, phone, website)
- MVVM architecture
- Networking with async/await, error handling
- Codable data models
- ViewState enum: loading, success, error
- Loading indicator and error view with retry

## Architecture (MVVM)
- Model: `User` (Codable, Identifiable)
- View: `UsersView`, `SuccessView`, `UserDetailView`, `LoadingView`, `ErrorView`
- ViewModel: `UsersView.ViewModel` (observable, exposes `state` and `load()`/`reload()`)
- Networking: `NetworkManager` (shared) + `Endpoints`
