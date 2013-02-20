#!/bin/sh

#コールドで取得するので、仮想マシンをサスペンドに
#ホットで取得したいならこれはいらない
#その代り、vmdkにロックが掛かっているため、一工夫必要
#よくやる手法は、スナップショットをとり、ロックを外してコピーした後でスナップショットを削除
vim-cmd vmsvc/power.suspend `vim-cmd vmsvc/getallvms | awk '/VM_NAME/ {print $1;}'`

#前回バックアップを削除
#事前に別鯖のNFS共有領域をマウントしておく必要あり
rm -rf /vmfs/volumes/NFS_ForEsxi/VM_NAME
mkdir /vmfs/volumes/NFS_ForEsxi/VM_NAME

#vmx、vmxf、vmsdは普通にコピー
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmx /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmx
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmxf /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmxf
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmsd /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmsd

#vmdkは普通にコピーすると、HDDのマックス容量でコピーが走るので、
#monosparseに変換しながらコピーする
vmkfstools -i /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmdk -d monosparse /vmfs/volumes/NFS_ForEsxi/VM_NAME_monosparse.vmdk

#サスペンド解除で終わり
vim-cmd vmsvc/power.on `vim-cmd vmsvc/getallvms | awk '/VM_NAME/ {print $1;}'`

