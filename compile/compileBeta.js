// Compiles Beta Contract

const path = require('path');
const fs = require('fs');
const solc = require('solc');

const betaPath = path.resolve(__dirname, '../contracts', 'Beta.sol');
const source = fs.readFileSync(betaPath, 'utf-8');

module.exports = solc.compile(source, 1).contracts[':Beta'];
