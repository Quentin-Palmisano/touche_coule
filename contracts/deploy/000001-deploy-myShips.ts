import 'dotenv/config'
import { DeployFunction } from 'hardhat-deploy/types'

const deployer: DeployFunction = async hre => {
  if (hre.network.config.chainId !== 31337) return
  const { deployer } = await hre.getNamedAccounts()
  // Déploiement des joueurs
  await hre.deployments.deploy('Player', { from: deployer, log: true })
  await hre.deployments.deploy('Player2', { from: deployer, log: true })

  // Déploiement des bateaux
  const myShip = await hre.deployments.deploy('MyShip', { from: deployer, args: [deployer], log: true })
  const myShip2 = await hre.deployments.deploy('MyShip2', { from: deployer, args: [myShip.address], log: true })
  const myShip3 = await hre.deployments.deploy('MyShip3', { from: deployer, args: [myShip2.address], log: true })
  const myShip4 = await hre.deployments.deploy('MyShip4', { from: deployer, args: [myShip3.address], log: true })

  // Récupération du contrat 'Main'
  const Main = await hre.deployments.get('Main')

  // Enregistrement des bateaux des joueurs
  await hre.deployments.execute('Player', { from: deployer}, 'register', Main.address, myShip.address, myShip2.address)
  await hre.deployments.execute('Player2', { from: deployer}, 'register', Main.address, myShip3.address, myShip4.address)
  
  // Récupération des positions des bateaux alliés
  await hre.deployments.execute('MyShip', { from: deployer}, 'getPos', myShip2.address)
  await hre.deployments.execute('MyShip2', { from: deployer}, 'getPos', myShip.address)
  await hre.deployments.execute('MyShip3', { from: deployer}, 'getPos', myShip4.address)
  await hre.deployments.execute('MyShip4', { from: deployer}, 'getPos', myShip3.address)
}

export default deployer