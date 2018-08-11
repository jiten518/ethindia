module.exports = {
  networks: {
    local: {
      host: "172.16.23.189",
      port: 8548,
      network_id: 72618, // Match any network id
      eip155Block:0, // Match any network id
      chainId:72618,
      gas: 6852388
    },
    test_net: {
    },

    live: {
      // host: "178.25.19.88", // Random IP for example purposes (do not use)
      // port: 80,
      // network_id: 1,        // Ethereum public network
      // optional config values:
      // gas
      // gasPrice
      // from - default address to use for any transaction Truffle makes during migrations
      // provider - web3 provider instance Truffle should use to talk to the Ethereum network.
      //          - function that returns a web3 provider instance (see below.)
      //          - if specified, host and port are ignored.
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  },
};
