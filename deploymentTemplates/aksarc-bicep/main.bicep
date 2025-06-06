
targetScope='subscription'

param azureLocation string
param deploymentResourceGroupName string
param customLocationResourceID string

// Logical network
param logicalNetworkName string
param addressPrefix string
param dnsServers array
param vmSwitchName string
param ipAllocationMethod string
param vlan int
param vipPoolStart string
param vipPoolEnd string
param nextHopIpAddress string

// Provisioned cluster
param connectedClusterName string
param sshPublicKey string
param controlPlaneHostIP string
param kubernetesVersion string
param controlPlaneVMSize string
param controlPlaneNodeCount int
param nodePoolName string
param nodePoolVMSize string
param nodePoolOSType string
param nodePoolCount int
param nodePoolLabel string
param nodePoolLabelValue string
param nodePoolTaint string
param netWorkProfilNetworkPolicy string
param networkProfileLoadBalancerCount int

resource deploymentResourceGroup'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: deploymentResourceGroupName
  location: azureLocation
}

module aksarcModule 'aksarc.bicep' = {
  name: '${deployment().name}-aksarc'
  scope: resourceGroup(deploymentResourceGroupName)
  params:{
    kubernetesVersion: kubernetesVersion
    controlPlaneVMSize: controlPlaneVMSize
    controlPlaneNodeCount: controlPlaneNodeCount
    nodePoolName: nodePoolName
    nodePoolVMSize: nodePoolVMSize
    nodePoolLabel: nodePoolLabel
    nodePoolLabelValue: nodePoolLabelValue
    nodePoolTaint: nodePoolTaint
    networkProfileLoadBalancerCount: networkProfileLoadBalancerCount
    netWorkProfilNetworkPolicy: netWorkProfilNetworkPolicy
    connectedClusterName: connectedClusterName
    controlPlaneHostIP: controlPlaneHostIP
    sshPublicKey: sshPublicKey
    nodePoolOSType: nodePoolOSType
    nodePoolCount: nodePoolCount
    customLocationResourceID: customLocationResourceID
    azureLocation: azureLocation
    addressPrefix: addressPrefix
    dnsServers: dnsServers
    ipAllocationMethod: ipAllocationMethod
    vlan: vlan
    vmSwitchName: vmSwitchName
    vipPoolStart: vipPoolStart
    vipPoolEnd: vipPoolEnd
    nextHopIpAddress: nextHopIpAddress
    logicalNetworkName: logicalNetworkName
  }
  dependsOn: [
    deploymentResourceGroup
  ]
}
