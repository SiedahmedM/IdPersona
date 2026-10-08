# IdPersona

An early data-model experiment for grouping trading wallets by their activity. The committed work is a Prisma schema and SQLite migration. The web application is still a starter page.

## The data model

[`prisma/schema.prisma`](prisma/schema.prisma) defines three models:

| Model | Purpose |
| --- | --- |
| `Trade` | Wallet, market, buy or sell side, price, size, timestamp, and optional transaction metadata |
| `Cluster` | A group with optional confidence and pattern descriptions |
| `ClusterMember` | A wallet's membership in a cluster |

Trades have both a unique `tradeUid` and a compound uniqueness constraint on wallet, market, timestamp, side, price, and size. The schema reserves `tradeUid` for a content-based identifier; code to compute it is not included. Indexes cover wallet lookups and market activity over time.

Cluster membership is unique per wallet and cluster, with cascading deletion when a cluster is removed. The schema defines where analysis results would be stored. Trade ingestion, similarity calculations, and clustering have not been implemented.

## Inspect locally

The stack is Next.js 16, React 19, TypeScript, Tailwind CSS 4, Prisma 6, and SQLite.

Install dependencies from the repository root:

```sh
npm ci
```

Create a root `.env` file:

```dotenv
DATABASE_URL="file:./dev.db"
```

Then initialize the database and inspect it:

```sh
npx prisma generate
node -e "require('fs').writeFileSync('prisma/dev.db', '', { flag: 'a' })"
npx prisma migrate deploy
npx prisma studio
```

Creating the empty database file avoids a missing-file migration error observed on Windows. The command preserves an existing file.

`npm run dev` opens the web app at `http://localhost:3000`, but there is no analysis UI or API yet. `ml-distance` and Vitest are listed in the package manifest; neither an analysis implementation nor a test suite is present.
