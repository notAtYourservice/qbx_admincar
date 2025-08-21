# Contributing to Qbox Admin Car Command

Thank you for your interest in contributing to the Qbox Admin Car Command! This document provides guidelines and information for contributors.

## 🚀 Getting Started

### Prerequisites
- Basic knowledge of Lua and FiveM development
- Understanding of Qbox framework
- Git and GitHub account

### Development Setup
1. Fork the repository
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/qbx_admincar.git
   cd qbx_admincar
   ```
3. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📋 Contribution Guidelines

### Code Style
- Follow existing code formatting and style
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and small

### Commit Messages
Use conventional commits format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for adding tests

### Pull Request Process
1. Ensure your code follows the existing style
2. Test your changes thoroughly
3. Update documentation if needed
4. Create a descriptive PR title and description
5. Link any related issues

## 🧪 Testing

### Manual Testing Checklist
- [ ] Command works with valid vehicles
- [ ] Error handling works correctly
- [ ] Permission system functions properly
- [ ] Vehicle saving works as expected
- [ ] Vehicle transfer works correctly
- [ ] Security features prevent abuse

### Test Scenarios
1. **Basic Usage**: `/admincar` with valid vehicle
2. **Transfer**: `/admincar [playerId]` to another player
3. **Invalid Cases**: Try with invalid vehicles, no vehicle, etc.
4. **Permissions**: Test with different permission levels

## 📚 Documentation

### Code Documentation
- Add JSDoc-style comments for functions
- Document configuration options
- Update README.md for new features

### README Updates
- Keep installation instructions current
- Update feature lists when adding new functionality
- Add examples for new commands

## 🐛 Bug Reports

When reporting bugs:
1. Use the bug report template
2. Provide clear reproduction steps
3. Include environment details
4. Add relevant screenshots/logs

## 💡 Feature Requests

When suggesting features:
1. Use the feature request template
2. Explain the use case clearly
3. Consider implementation complexity
4. Discuss alternatives considered

## 🏷️ Versioning

We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

## 📞 Support

- **Discord**: [Qbox Discord](https://discord.gg/qbox)
- **Issues**: Use GitHub issues for bugs and feature requests
- **Discussions**: Use GitHub discussions for questions

## 🎯 Code Review Process

1. **Automated Checks**: CI/CD will run basic checks
2. **Manual Review**: Maintainers will review code
3. **Testing**: Changes will be tested in a development environment
4. **Approval**: At least one maintainer approval required

## 📝 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## 🎉 Recognition

Contributors will be recognized in:
- Release notes for significant contributions
- Contributors section in README
- Special thanks in commits

Thank you for contributing to the Qbox community!
