######################################################################

velero backup-location get
velero backup get

velero backup create mybackup --include-namespaces test
velero backup create minio-backup --include-namespaces minio-system
--include-resources
--exclude-resources

velero backup describe mybackup
velero backup logs mybackup
velero backup delete mybackup
velero backup delete --all

velero restore get
velero restore create mybackup-restore1 --from-backup mybackup
velero restore describe mybackup-restore1
velero restore logs mybackup-restore1
velero restore delete mybackup-restore1
velero restore delete --all

velero schedule get
velero schedule create firstschedule --schedule="@every 1day" --include-namespcaes
velero schedule delete firstschedule
velero schedule delete --all
