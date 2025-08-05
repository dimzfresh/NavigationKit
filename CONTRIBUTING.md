# Contributing to NavigationKit

Thank you for your interest in contributing to NavigationKit! This document provides guidelines and information for contributors.

## Getting Started

1. Fork the repository
2. Clone your fork locally
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes thoroughly
6. Commit your changes: `git commit -m "Add: your feature description"`
7. Push to your fork: `git push origin feature/your-feature-name`
8. Create a Pull Request

## Development Setup

### Requirements
- Xcode 15.0+
- iOS 16.0+ SDK
- Swift 5.10+

### Building the Project
1. Open `Package.swift` in Xcode
2. Build the project (Cmd+B)
3. Run tests (Cmd+U)

## Code Style Guidelines

### Swift Code Style
- Use Swift 5.10+ features
- Follow Swift API Design Guidelines
- Use `@MainActor` for UI-related code
- Prefer `any Coordinator` over `AnyCoordinator`
- Use descriptive names for variables and functions

### Documentation
- Add documentation comments for public APIs
- Include usage examples in documentation
- Update README.md if adding new features

### Testing
- Write unit tests for new functionality
- Ensure all tests pass before submitting PR
- Test on iOS 16.0+ simulators

## Pull Request Guidelines

### Before Submitting
- [ ] Code follows the style guidelines
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] No breaking changes (unless major version)
- [ ] Feature is tested on iOS 16.0+

### PR Title Format
- `Add: feature description` (new features)
- `Fix: bug description` (bug fixes)
- `Update: change description` (updates)
- `Refactor: change description` (refactoring)

### PR Description
Include:
- Summary of changes
- Motivation for changes
- Testing performed
- Screenshots (if UI changes)

## Issue Guidelines

### Bug Reports
- Use the bug report template
- Include steps to reproduce
- Specify iOS/Xcode versions
- Add screenshots if applicable

### Feature Requests
- Use the feature request template
- Explain the problem being solved
- Describe the proposed solution
- Consider alternatives

## Release Process

### Versioning
We follow [Semantic Versioning](https://semver.org/):
- MAJOR.MINOR.PATCH
- Breaking changes = MAJOR version
- New features = MINOR version
- Bug fixes = PATCH version

### Release Checklist
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Version is updated in Package.swift
- [ ] Release notes are prepared
- [ ] Tag is created with version number

## Questions?

If you have questions about contributing, feel free to:
- Open a discussion
- Create an issue
- Contact the maintainers

Thank you for contributing to NavigationKit! 🚀 