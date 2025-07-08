# Fonbet data parser

### Installation 🛠️

```bash
# Clone repository
git clone https://github.com/alekslitgh/fonbet-parser

# Install dependencies
npm install  # or pnpm install
```

### Environment Setup 🔐

```bash
# Copy and configure environment
cp .env.example .env
# Edit .env with your credentials
```

### Docker Commands 🐳

```bash
# Start PostgreSQL
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Reset all data
docker-compose down -v
```

### Runtime Commands 🏃

```bash
# before running ensure pg db is initialized and docker is running
npm run start       # Basic start
npm run start:dev   # Watch mode

```
