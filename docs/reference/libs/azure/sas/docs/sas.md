# Azure Shared Access Signatures

This module allows handling [Azure Shared Access Signatures](https://docs.microsoft.com/en-us/azure/storage/common/storage-dotnet-shared-access-signature-part-1) from Zerynth programs.

###### generate

```#!py3 generate(uri, key, ttl, policy_name=None)```

Generate a SAS for target `uri` signed with `key` valid till `ttl` (passed as epoch) and with optional `policy_name`.
