// To test Elect contract using mocha

const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile');

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

describe('Elect -- Smart contract', () => {

    it('deploys the contract', () => {
        assert.ok(elect.options.address);
    })

    it('checks for manager', async () => {
        manager = await elect.methods.getManager().call({
            from: accounts[0]
        })
        assert(accounts[0], manager);
    })

    it('cast one vote', async () => {
        await elect.methods.castVote(1).send({
            from: accounts[0]
        })
        const voters = await elect.methods.getVoters().call({
            from: accounts[0]
        })
        assert.equal(accounts[0], voters[0]);
        assert.equal(1, voters.length);
    })

    it('cast multiple votes', async () => {
        await elect.methods.castVote(1).send({
            from: accounts[0]
        })
        await elect.methods.castVote(2).send({
            from: accounts[1]
        })
        await elect.methods.castVote(3).send({
            from: accounts[2]
        })
        await elect.methods.castVote(4).send({
            from: accounts[3]
        })
        await elect.methods.castVote(5).send({
            from: accounts[4]
        })
        const voters = await elect.methods.getVoters().call({
            from: accounts[0]
        })
        assert.equal(5, voters.length);
    })
})