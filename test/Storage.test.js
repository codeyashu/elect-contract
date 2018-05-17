/* // Test cases for Storage Contract

const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile/compileStorage');

let storage;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    storage = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({
            data: bytecode
        })
        .send({
            from: accounts[0], gas: '1000000'
        })
})

describe('Storage-- Smart contract', () => {

    it('deploys contract', () => {
        assert.ok(storage.options.address);
    })

    it('registers a voter', async () => {
        const status = await storage.methods.registerOnce(accounts[0], "vo101").send({
            from: accounts[0]
        })
        const electoralList = await storage.methods.getElectoral().call({
            from: accounts[0]
        });
        console.log(status);
        assert(1, electoralList.length);
    })
}) */