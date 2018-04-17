# Set the following 3 parameters first.
                        my_resource_group=<Resource group name containing your Linux VM and the storage account>
                        my_linux_vm=<Your Azure Linux VM name>
                        my_diagnostic_storage_account=<Your Azure storage account for storing VM diagnostic data>
                        
                        my_vm_resource_id=$(az vm show -g $my_resource_group -n $my_linux_vm --query "id" -o tsv)
                        
                        default_config=$(az vm diagnostics get-default-config \
                            | sed "s#__DIAGNOSTIC_STORAGE_ACCOUNT__#$my_diagnostic_storage_account#g" \
                            | sed "s#__VM_OR_VMSS_RESOURCE_ID__#$my_vm_resource_id#g")
                        
                        storage_sastoken= use the storage explorer with all the permission should look like this :
   sv=2015-12-11&ss=bfqt&srt=sco&sp=rwdlacup&st=2018-04-17T21%3A36%3A00Z&se=2099-04-29T21%3A36%3A00Z&sig=jUuIACj7c%2BmtB0m4m4bM6
                        
                          protected_settings="{'storageAccountName': '$my_diagnostic_storage_account', \
                            'storageAccountSasToken': '$storage_sastoken'}"
                        
az vm diagnostics set --settings "${default_config}"                             --protected-settings "${protected_settings}"                             --resource-group $my_resource_group --vm-name $my_linux_vm


