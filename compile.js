// Compiles solidity file

const path = require('path');
const fs = require('fs');
const solc = require('solc');

const electPath = path.resolve(__dirname, 'contracts', 'Elect.sol');
const source = fs.readFileSync(electPath, 'utf-8');

// module.exports = solc.compile(source, 1).contracts[':Elect'];

console.log(solc.compile(source, 1).contracts[':Elect'])