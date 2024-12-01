const baseContract = artifacts.require("baseContract");
module.exports = async function (deployer) {
    //set owners to generated owners
    const owners = await web3.eth.getAccounts();
    await deployer.deploy(baseContract, owners);
};
