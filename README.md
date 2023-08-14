# Hyperledger Besu Setup for Private Network with Multiple Nodes


This tutorial assumes the only pre-requisite of using `docker` and `docker-compose` without needing to generate or install any other dependencies.

The current directory structure assumes that you can run the different parts respectively.

To run the `QBFT-quorum`:
```shell
cd qbft
# Running 4-node blockchain with QBFT
docker compose up -d 
``` 

## How to use Foundry for these examples.

Use the `devcontainer.json` specified to run the examples. The following commands, set up foundry.

```shell 
curl -L https://foundry.paradigm.xyz | bash
source /home/vscode/.bashrc
foundryup

```

Now we can compile, test and upload smart contracts to the blockchain we previously setup.

```shell

forge build

forge test

forge test --gas-report
export PK=<private_key>
##  It can be tested in this setup with: 
# export PK=0xc87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3
forge create --rpc-url http://localhost:8545 --private-key $PK src/HelloWorld.sol:HelloWorld --constructor-args "Greetings from a Smart Contract" --legacy
```


This will produce an output like:
```shell
Deployer: 0x627306090abaB3A6e1400e9345bC60c78a8BEf57
Deployed to: 0x8CdaF0CD259887258Bc13a92C0a6dA92698644C0 # <----- We want this
Transaction hash: 0xe10f2fcc73eede17c9447be6822154fb833e3a242ca559f4f66e2f954f8086a7
```

We obtain the address of the smart contract. Then, we can use `cast` to interact with it.

```shell
export CA=<contract_address>
## It should be something like:
# export CA=0xf25186B5081Ff5cE73482AD761DB0eB0d25abfBF
cast call $CA "greet()(string)"
# OUT: Greetings from a Smart Contract

cast send $CA "updateGreeting(string)" "Greetings from an updated Smart Contract" --private-key $PK
# OUT: Transaction

cast call $CA "greet()(string)"
# OUT: "Greetings from an updated Smart Contract"
```


## Configuration from scratch
To produce the configuration files necessary for *QBFT*, we use the following command:
```
`docker compose -f setup/qbft-setup.yml up`
```

## Resources and References
[Building and testing smart contracts with Foundry - Nader Dabit](https://nader.mirror.xyz/6Mn3HjrqKLhHzu2balLPv4SqE5a-oEESl4ycpRkWFsc)
[How to develop and deploy smart contracts with Foundry & Openzeppelin - pateldeep.eth](https://medium.com/coinmonks/how-to-develop-and-deploy-smart-contracts-with-foundry-openzeppelin-6bba51ddb438)