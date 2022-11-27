import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'

const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  const deployAdrress = await hre.deployments.deploy('Main', { from: deployer, log: true })
  const deployAdrress2 = await hre.deployments.deploy('Main', { from: deployAdrress.address, log: true })
}

export default deployer
