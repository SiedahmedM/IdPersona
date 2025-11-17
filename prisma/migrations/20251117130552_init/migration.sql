-- CreateTable
CREATE TABLE "Trade" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "tradeUid" TEXT NOT NULL,
    "wallet" TEXT NOT NULL,
    "marketId" TEXT NOT NULL,
    "marketTitle" TEXT,
    "outcome" TEXT,
    "side" TEXT NOT NULL,
    "price" DECIMAL NOT NULL,
    "size" DECIMAL NOT NULL,
    "timestamp" DATETIME NOT NULL,
    "pseudonym" TEXT,
    "txHash" TEXT
);

-- CreateTable
CREATE TABLE "Cluster" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "confidence" REAL,
    "patterns" TEXT,
    "lastUpdated" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "ClusterMember" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "wallet" TEXT NOT NULL,
    "clusterId" INTEGER NOT NULL,
    CONSTRAINT "ClusterMember_clusterId_fkey" FOREIGN KEY ("clusterId") REFERENCES "Cluster" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Trade_tradeUid_key" ON "Trade"("tradeUid");

-- CreateIndex
CREATE INDEX "Trade_wallet_idx" ON "Trade"("wallet");

-- CreateIndex
CREATE INDEX "Trade_marketId_timestamp_idx" ON "Trade"("marketId", "timestamp");

-- CreateIndex
CREATE INDEX "Trade_timestamp_idx" ON "Trade"("timestamp");

-- CreateIndex
CREATE INDEX "Trade_txHash_idx" ON "Trade"("txHash");

-- CreateIndex
CREATE INDEX "Trade_pseudonym_idx" ON "Trade"("pseudonym");

-- CreateIndex
CREATE UNIQUE INDEX "Trade_wallet_marketId_timestamp_side_price_size_key" ON "Trade"("wallet", "marketId", "timestamp", "side", "price", "size");

-- CreateIndex
CREATE INDEX "Cluster_lastUpdated_idx" ON "Cluster"("lastUpdated");

-- CreateIndex
CREATE INDEX "Cluster_confidence_idx" ON "Cluster"("confidence");

-- CreateIndex
CREATE INDEX "ClusterMember_wallet_idx" ON "ClusterMember"("wallet");

-- CreateIndex
CREATE INDEX "ClusterMember_clusterId_idx" ON "ClusterMember"("clusterId");

-- CreateIndex
CREATE UNIQUE INDEX "ClusterMember_clusterId_wallet_key" ON "ClusterMember"("clusterId", "wallet");
