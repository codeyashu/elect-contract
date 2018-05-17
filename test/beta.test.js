const assert = require('assert');
const ganache = require('ganache-cli');
const Web3 = require('web3');
const web3 = new Web3(ganache.provider());
const { interface, bytecode } = require('../compile/compileBeta');

let beta;
let accounts;

beforeEach(async () => {
    accounts = await web3.eth.getAccounts();
    beta = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({
            data: bytecode
        })
        .send({
            from: accounts[0], gas: '1000000'
        })
})

describe('Beta-- Smart contract', () => {

    it('deploys the contract', () => {
        assert.ok(beta.options.address);
    })

    it('checks for constituencies', async () => {
        constituencies = await beta.methods.listConstituencies().call({
            from: accounts[0]
        })
        assert(constituencies.length, 7);
    })

    it('gets Votes', async () => {
        votes = await beta.methods.Constituency(302).call({
            from: accounts[0]
        })
       // assert(constituencies.length, 7);
        console.log(votes.p1);
    })

    it('gets Votes custom', async () => {
        votes = await beta.methods.getVotes(302).call({
            from: accounts[0]
        })
       // assert(constituencies.length, 7);
        console.log(votes);
    })
})