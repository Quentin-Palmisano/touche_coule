import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'

const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  await hre.deployments.deploy('Player', { from: deployer, log: true })
  await hre.deployments.deploy('Player2', { from: deployer, log: true })
  const myShip = await hre.deployments.deploy('MyShip', { from: deployer, log: true })
  const myShip2 = await hre.deployments.deploy('MyShip2', { from: deployer, log: true })
  const myShip3 = await hre.deployments.deploy('MyShip3', { from: deployer, log: true })
  const myShip4 = await hre.deployments.deploy('MyShip4', { from: deployer, log: true })
  const Main = await hre.deployments.get('Main')
  await hre.deployments.execute('Player', { from: deployer}, 'register', Main.address, myShip.address, myShip2.address)
  await hre.deployments.execute('Player2', { from: deployer}, 'register', Main.address, myShip3.address, myShip4.address)
}

export default deployer
