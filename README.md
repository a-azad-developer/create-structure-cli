# 📁 Project Structure Creator

A cross-platform bash script that automatically creates project directory structures from tree-like input. Works on **Linux**, **macOS**, and **Windows** (via Git Bash or WSL).

## ✨ Features

- 🏗️ **Create complex project structures** from a visual tree representation
- 📝 **Multiple input methods** - file, string, or interactive mode
- 🎯 **Flexible base path** - create structures anywhere
- 📊 **Verbose output** - see exactly what's being created
- 🎨 **Color-coded output** - easy to read and understand
- 🔄 **Cross-platform** - works on all major operating systems
- 📋 **Summary report** - shows what was created
- 🛡️ **Error handling** - validates input and handles errors gracefully

## 📋 Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Input Formats](#input-formats)
- [Examples](#examples)
- [Options](#options)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## 🚀 Installation

### Option 1: Download Script

```bash
# Download the script
curl -o create_structure.sh https://your-script-url

# Or using wget
wget -O create_structure.sh https://your-script-url

# Make it executable
chmod +x create_structure.sh
```

### Option 2: Create File Manually

1. Create a new file called `create_structure.sh`
2. Copy the script content into it
3. Make it executable: `chmod +x create_structure.sh`

### Option 3: Add to PATH (Optional)

```bash
# Move to a directory in your PATH
sudo mv create_structure.sh /usr/local/bin/
# Or add to ~/.local/bin
mkdir -p ~/.local/bin
mv create_structure.sh ~/.local/bin/
# Make sure ~/.local/bin is in your PATH
export PATH="$HOME/.local/bin:$PATH"
```

## 📖 Usage

### Basic Syntax

```bash
./create_structure.sh [OPTIONS]
```

### Input Methods

#### 1. **Interactive Mode** (Recommended)
```bash
./create_structure.sh -i
```
Then paste your structure and press `Ctrl+D` (Linux/macOS) or `Ctrl+Z` (Windows) when done.

#### 2. **From a File**
```bash
./create_structure.sh -f structure.txt
```

#### 3. **From a String**
```bash
./create_structure.sh -s "src/ ├── rag/ │    └── rag.module.ts ├── app.module.ts"
```

## 📝 Input Formats

### Basic Structure Format

The script accepts tree-like structures using these characters:
- `├──` for items (files or directories)
- `└──` for the last item in a directory
- `│` for vertical tree lines
- `/` at the end for directories

### Example Structure

```
project-name/
 ├── src/
 │    ├── components/
 │    │    ├── Header/
 │    │    │    ├── Header.tsx
 │    │    │    └── Header.css
 │    │    └── Footer/
 │    │         ├── Footer.tsx
 │    │         └── Footer.css
 │    ├── utils/
 │    │    ├── api.ts
 │    │    └── helpers.ts
 │    ├── App.tsx
 │    └── index.tsx
 ├── public/
 │    ├── index.html
 │    └── favicon.ico
 ├── package.json
 ├── tsconfig.json
 └── README.md
```

### Naming Conventions

- **Directories**: End with `/` (e.g., `src/`, `components/`)
- **Files**: No trailing slash (e.g., `main.ts`, `app.module.ts`)
- **Spacing**: Use consistent indentation (4 spaces recommended)
- **Tree characters**: Use `├──`, `└──`, and `│`

## 🎯 Options

| Option | Description | Example |
|--------|-------------|---------|
| `-f, --file <file>` | Read structure from a file | `-f structure.txt` |
| `-s, --string <string>` | Read structure from a string | `-s "src/ ├── main.ts"` |
| `-i, --interactive` | Interactive mode (paste structure) | `-i` |
| `-p, --path <path>` | Base path for creation | `-p ~/myproject` |
| `-v, --verbose` | Show detailed output | `-v` |
| `-h, --help` | Show help message | `-h` |

## 💡 Examples

### Example 1: Node.js Project

**Input:**
```bash
./create_structure.sh -s "
src/
 ├── controllers/
 │    ├── auth.controller.ts
 │    └── user.controller.ts
 ├── models/
 │    ├── user.model.ts
 │    └── product.model.ts
 ├── routes/
 │    ├── auth.routes.ts
 │    └── user.routes.ts
 ├── services/
 │    ├── auth.service.ts
 │    └── user.service.ts
 ├── utils/
 │    ├── logger.ts
 │    └── validator.ts
 ├── app.ts
 └── server.ts
"
```

**Result:**
```
src/
├── controllers/
│   ├── auth.controller.ts
│   └── user.controller.ts
├── models/
│   ├── user.model.ts
│   └── product.model.ts
├── routes/
│   ├── auth.routes.ts
│   └── user.routes.ts
├── services/
│   ├── auth.service.ts
│   └── user.service.ts
├── utils/
│   ├── logger.ts
│   └── validator.ts
├── app.ts
└── server.ts
```

### Example 2: React Project with Components

**Create a structure file:**
```bash
cat > react-structure.txt << 'EOF'
my-app/
 ├── src/
 │    ├── components/
 │    │    ├── common/
 │    │    │    ├── Button/
 │    │    │    │    ├── Button.tsx
 │    │    │    │    └── Button.css
 │    │    │    └── Input/
 │    │    │         ├── Input.tsx
 │    │    │         └── Input.css
 │    │    ├── pages/
 │    │    │    ├── Home/
 │    │    │    │    ├── Home.tsx
 │    │    │    │    └── Home.css
 │    │    │    └── About/
 │    │    │         ├── About.tsx
 │    │    │         └── About.css
 │    │    └── layouts/
 │    │         ├── MainLayout.tsx
 │    │         └── MainLayout.css
 │    ├── hooks/
 │    │    ├── useAuth.ts
 │    │    └── useApi.ts
 │    ├── utils/
 │    │    ├── api.ts
 │    │    └── constants.ts
 │    ├── App.tsx
 │    └── index.tsx
 ├── public/
 │    ├── index.html
 │    └── favicon.ico
 ├── package.json
 └── README.md
EOF

./create_structure.sh -f react-structure.txt -v
```

### Example 3: Python Project

```bash
./create_structure.sh -i -p ~/my-python-project
```

Then paste:
```
myproject/
 ├── src/
 │    ├── __init__.py
 │    ├── main.py
 │    ├── models/
 │    │    ├── __init__.py
 │    │    ├── user.py
 │    │    └── product.py
 │    ├── services/
 │    │    ├── __init__.py
 │    │    ├── auth_service.py
 │    │    └── data_service.py
 │    └── utils/
 │         ├── __init__.py
 │         ├── logger.py
 │         └── helpers.py
 ├── tests/
 │    ├── __init__.py
 │    ├── test_models.py
 │    └── test_services.py
 ├── requirements.txt
 ├── setup.py
 └── README.md
```

### Example 4: Mixed Project

```bash
# Create structure in a specific location
./create_structure.sh -f structure.txt -p ~/Documents/projects/myapp -v
```

## 🖥️ Windows Users

### Using Git Bash

1. **Install Git Bash** from [git-scm.com](https://git-scm.com)
2. **Open Git Bash** terminal
3. **Run the script** as shown above
4. **Use forward slashes** in paths (e.g., `-p /c/Users/username/project`)

### Using WSL (Windows Subsystem for Linux)

1. **Install WSL** if not already installed
2. **Open WSL terminal**
3. **Run the script** normally
4. **Access Windows files** via `/mnt/c/`

### Git Bash Example:
```bash
# Create structure in Windows Documents folder
./create_structure.sh -f structure.txt -p /c/Users/username/Documents/myproject
```

## 🔧 Troubleshooting

### Common Issues

#### 1. **"Permission denied" when running script**
```bash
# Make the script executable
chmod +x create_structure.sh
```

#### 2. **"Command not found" for tree command**
```bash
# Install tree (optional, for better visualization)
# Ubuntu/Debian
sudo apt-get install tree

# macOS
brew install tree

# Windows (Git Bash)
# Tree is usually included, or download from: http://gnuwin32.sourceforge.net/packages/tree.htm
```

#### 3. **Incorrect file placement**
- Ensure your tree structure has proper indentation
- Use consistent spacing (4 spaces recommended)
- Check that directories end with `/`

#### 4. **Windows line endings issue**
```bash
# Convert to Unix line endings
dos2unix create_structure.sh
# Or
sed -i 's/\r$//' create_structure.sh
```

#### 5. **Empty directories not created**
- The script creates directories when they have at least one file or subdirectory
- To create empty directories, add a placeholder file or use `mkdir -p` manually

### Validation Tips

1. **Test your structure** before running:
   ```bash
   # View the structure without creating files
   ./create_structure.sh -f structure.txt -v | grep "Creating"
   ```

2. **Check for hidden characters**:
   ```bash
   # Show hidden characters in your structure file
   cat -A structure.txt
   ```

3. **Verify indentation**:
   ```bash
   # Show line numbers and indentation
   cat -n structure.txt
   ```

## 📊 Output Examples

### Verbose Mode Output
```
Creating project structure...

Creating directory: src/
Creating directory: src/rag/
Creating file: src/rag/rag.module.ts
Creating file: src/rag/rag.service.ts
Creating file: src/rag/rag.controller.ts
Creating file: src/rag/graphify.service.ts
Creating file: src/rag/vector.service.ts
Creating file: src/rag/chunk.util.ts
Creating file: src/app.module.ts
Creating file: src/main.ts

✓ Structure created successfully!
Summary:
  Directories created: 2
  Files created: 8

Current directory structure:
.
└── src/
    ├── app.module.ts
    ├── main.ts
    └── rag/
        ├── chunk.util.ts
        ├── graphify.service.ts
        ├── rag.controller.ts
        ├── rag.module.ts
        ├── rag.service.ts
        └── vector.service.ts
```

## 🛠️ Advanced Usage

### Creating Structures Programmatically

```bash
# Generate a structure dynamically
STRUCTURE="src/
 ├── $(date +%Y%m%d)/
 │    ├── data.json
 │    └── log.txt
 └── config/
      └── settings.yaml"

./create_structure.sh -s "$STRUCTURE"
```

### Combining with Other Tools

```bash
# Create structure and initialize git
./create_structure.sh -f structure.txt -v && git init

# Create structure and install dependencies
./create_structure.sh -f node-project.txt && npm install

# Create structure and set permissions
./create_structure.sh -f structure.txt && chmod -R 755 src/
```

### Using in CI/CD Pipelines

```yaml
# GitHub Actions example
- name: Create project structure
  run: |
    chmod +x create_structure.sh
    ./create_structure.sh -f .github/structure.txt -v
```

## 🎨 Customization

### Adding Content to Files

The script currently creates empty files. To add content, you can extend it:

```bash
# Add content to specific files after creation
echo "export default {};" > src/app.module.ts
echo "console.log('Hello World');" > src/main.ts
```

### Modifying the Script

Key functions you can customize:

- `create_structure()` - Main creation logic
- `parse_and_create()` - Parsing and creation
- Color codes at the top for different output styles

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Commit your changes**: `git commit -m 'Add amazing feature'`
4. **Push to branch**: `git push origin feature/amazing-feature`
5. **Open a Pull Request**

### Development Guidelines

- Test on all platforms (Linux, macOS, Windows)
- Maintain backward compatibility
- Add comments for complex logic
- Update documentation for new features

## 📝 Changelog

### v2.0.0 (2024)
- ✅ Fixed directory depth tracking
- ✅ Added interactive mode
- ✅ Improved error handling
- ✅ Added color-coded output
- ✅ Windows compatibility improvements

### v1.0.0 (2023)
- Initial release
- Basic structure creation
- File and string input support

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by common project structure patterns
- Built with cross-platform compatibility in mind
- Thanks to all contributors and users

## 📞 Support

- **Issues**: Please report bugs via the issue tracker
- **Questions**: Open a discussion or issue
- **Feature requests**: We welcome suggestions!

## 📚 Related Resources

- [Project Structure Best Practices](https://github.com/kriasoft/Folder-Structure-Conventions)
- [Common Project Structures](https://github.com/ryanmcdermott/clean-code-javascript)
- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)

---

**Made with ❤️ for developers everywhere**

Happy coding! 🚀