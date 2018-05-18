const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile/compileElect');

let elect;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    elect = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({
            data: bytecode
        })
        .send({
            from: accounts[0], gas: '1000000'
        })
})

describe('Elect-- Smart contract', () => {

    it('deploys the contract', () => {
        assert.ok(elect.options.address);
    })

    it('checks for manager', async () => {
        manager = await elect.methods.manager().call({
            from: accounts[0]
        })
        assert(accounts[0], manager);
    })

    it('cast one vote', async () => {
        await elect.methods.castVote(301, 2, 0x6f42EA18488FA3A79C3014D6Ca40D82BF74DB0da).send({
            from: accounts[0]
        })
        const voters = await elect.methods.getVoters().call({
            from: accounts[0]
        })
        assert.equal(accounts[0], voters[0]);
        assert.equal(1, voters.length);
    })
})