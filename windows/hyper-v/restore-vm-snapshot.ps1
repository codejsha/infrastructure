Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeControlPlaneMachine1" -Confirm:$false
Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeControlPlaneMachine2" -Confirm:$false
Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeControlPlaneMachine3" -Confirm:$false
Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeNodeMachine1" -Confirm:$false
Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeNodeMachine2" -Confirm:$false
Restore-VMSnapshot -Name "checkpoint01" -VMName "KubeNodeMachine3" -Confirm:$false
