#!/bin/sh

#�R�[���h�Ŏ擾����̂ŁA���z�}�V�����T�X�y���h��
#�z�b�g�Ŏ擾�������Ȃ炱��͂���Ȃ�
#���̑��Avmdk�Ƀ��b�N���|�����Ă��邽�߁A��H�v�K�v
#�悭����@�́A�X�i�b�v�V���b�g���Ƃ�A���b�N���O���ăR�s�[������ŃX�i�b�v�V���b�g���폜
vim-cmd vmsvc/power.suspend `vim-cmd vmsvc/getallvms | awk '/VM_NAME/ {print $1;}'`

#�O��o�b�N�A�b�v���폜
#���O�ɕʎI��NFS���L�̈���}�E���g���Ă����K�v����
rm -rf /vmfs/volumes/NFS_ForEsxi/VM_NAME
mkdir /vmfs/volumes/NFS_ForEsxi/VM_NAME

#vmx�Avmxf�Avmsd�͕��ʂɃR�s�[
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmx /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmx
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmxf /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmxf
cp /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmsd /vmfs/volumes/NFS_ForEsxi/VM_NAME.vmsd

#vmdk�͕��ʂɃR�s�[����ƁAHDD�̃}�b�N�X�e�ʂŃR�s�[������̂ŁA
#monosparse�ɕϊ����Ȃ���R�s�[����
vmkfstools -i /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmdk -d monosparse /vmfs/volumes/NFS_ForEsxi/VM_NAME_monosparse.vmdk

#�T�X�y���h�����ŏI���
vim-cmd vmsvc/power.on `vim-cmd vmsvc/getallvms | awk '/VM_NAME/ {print $1;}'`

