import { ContractFactory } from 'ethers'
import { ethers, network } from 'hardhat'
import fs from 'fs'

type ContractJson = { abi: any; bytecode: string }
const artifacts: { [name: string]: ContractJson } = {
  // eslint-disable-next-line global-require
  BeraV3PoolDeployer: require('../artifacts/contracts/BeraV3PoolDeployer.sol/BeraV3PoolDeployer.json'),
  // eslint-disable-next-line global-require
  BeraV3Factory: require('../artifacts/contracts/BeraV3Factory.sol/BeraV3Factory.json'),
}

async function main() {
  const [owner] = await ethers.getSigners()
  const networkName = network.name
  console.log('owner', owner.address)

  let beraV3PoolDeployerAddress = ''
  let beraV3PoolDeployer
  const BeraV3PoolDeployer = new ContractFactory(
    artifacts.BeraV3PoolDeployer.abi,
    artifacts.BeraV3PoolDeployer.bytecode,
    owner
  )
  if (!beraV3PoolDeployerAddress) {
    beraV3PoolDeployer = await BeraV3PoolDeployer.deploy()

    beraV3PoolDeployerAddress = beraV3PoolDeployer.address
    console.log('beraV3PoolDeployer', beraV3PoolDeployerAddress)
  } else {
    beraV3PoolDeployer = new ethers.Contract(beraV3PoolDeployerAddress, artifacts.BeraV3PoolDeployer.abi, owner)
  }

  let beraV3FactoryAddress = ''
  let beraV3Factory
  if (!beraV3FactoryAddress) {
    const BeraV3Factory = new ContractFactory(artifacts.BeraV3Factory.abi, artifacts.BeraV3Factory.bytecode, owner)
    beraV3Factory = await BeraV3Factory.deploy(beraV3PoolDeployerAddress)

    beraV3FactoryAddress = beraV3Factory.address
    console.log('beraV3Factory', beraV3FactoryAddress)
  } else {
    beraV3Factory = new ethers.Contract(beraV3FactoryAddress, artifacts.BeraV3Factory.abi, owner)
  }

  // Set FactoryAddress for pancakeV3PoolDeployer.
  await beraV3PoolDeployer.setFactoryAddress(beraV3FactoryAddress)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
