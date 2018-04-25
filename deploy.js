// Deploy contract to ethereum network

const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

// Provider requires metamask mnemonic and a node in the network.
// Here infura is used. Sign up at infura.io
const provider = new HDWalletProvider(
    'unusual donor select sell raccoon office chapter miracle damage razor success become',
    'https://rinkeby.infura.io/mtFwL2yHZw0Vg9DawLnw'
);

const web3 = new Web3(provider);

const deploy = async () => {
    const accounts = await web3.eth.getAccounts();
    console.log('Attempting to deploy from', accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))
        .deploy({
            data: bytecode,
        })
        .send({
            gas: '1000000',
            from: accounts[0]
        })

    //Details required to work with contract
    console.log(result);
    console.log("-------------------------------------------");
    //Interface and contract address required for web3 in the server
    console.log(interface);
    console.log('Contract deployed to', result.options.address);
};
deploy();
