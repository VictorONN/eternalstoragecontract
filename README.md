# eternalstoragecontract

1. Deploy EternalStorage contract. This is our storage contract. 
2. Deploy Ballot contract(our logic contract). 
   In the constructor, set the owner, and the address of EternalStorage contract. 
   Changes to the logic are done inside our Ballot contract, and we redeploy it using the same procedure. Storage remains, but logic address changes. 

