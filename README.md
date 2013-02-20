EsxiBackup
======================
Esxi用のバックアップスクリプト

使用方法
--------------
１．vSphereClientから作業  
　１－１．sshを有効にする  
　１－２．vSphereClientから、バックアップ先のnfsをデータストアに追加する  
　１－３．vSphereClientから、スクリプトをEsxiにアップロードする  
２．sshから作業  
　２－１．スクリプトに実行権限を付与する  
　２－２．スクリプトのシンボリックリンクを/sbin直下に作成する  
　２－３．rootのcrontabにスケジュールを設定する（ちなみに時刻はUTC）  
　２－４．crondを再起動する  

ちなみにEsxiは再起動がかかると、crontabの設定がとびます。  
シンボリックリンクも確か消えます。  
再起動後も変わらずスケジュールバックアップを取らせるためには、  
rc.localを編集し、末尾にシンボリックリンク作成のコマンドと、  
crontabへ設定を吐き出すコマンド、crondの再起動コマンドを記述する必要があります  。
リストア方法
--------------
１．vmx、vmxf、vmsdをコピーコマンドで普通に戻す  
２．vmdkはthinに変換して元の場所に戻す  

vmkfstools -i /vmfs/volumes/NFS_ForEsxi/VM_NAME_monosparse.vmdk -d thin /vmfs/volumes/datastore1/VM_NAME/VM_NAME.vmdk
