import { LightningElement, track } from 'lwc';
import insertRecord from '@salesforce/apex/AccountCreationController.insertAccountRecord';
import Account_Name from '@salesforce/schema/Account.Name';
import Account_Phone from '@salesforce/schema/Account.Phone';
import Account_Rating from '@salesforce/schema/Account.Rating';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class AccountCreation_Apex extends LightningElement 
{
     accountRecord = { Name: Account_Name, Phone: Account_Phone, Rating: Account_Rating };
    title = ''
    // {"Name":{"fieldApiName":"Name","ObjectApiName": "Account"},"Phone": {"fieldApiName": "Phone", "ObjectApiName": "Account"}}
     error = '';
    @track accountId1 = '';
    handleNameChange(event)
    {
     this.accountRecord.Name = event.target.value;
     this.title = 'Name title';
    }
    handlePhoneChange(event)
    {
     this.accountRecord.Phone = event.target.value;
     this.title = 'Phone title';
    }
    handleRatingChange(event)
    {
    this.accountRecord.Rating = event.target.value;
    this.title = 'Rating title';
    }

    handleInsertRecord()
    {
        console.log('accountRecord:@@: ' + JSON.stringify(this.accountRecord)); // {Name:pavan,Rating: Hot,Phone:1233}
        if(this.accountRecord == '')
        {
           this.error = 'account record should not be empty';
           this.accountId1 = '';
           return;
        }
        insertRecord({actObj: this.accountRecord}).
        then(result => {
            console.log('result: ' + JSON.stringify(result));
            this.accountId1 = result.Id;
            this.error = '';
            console.log('accountId1: ' + this.accountId1);
            const showEvent = new ShowToastEvent({title: 'Success',message: 'account created with Id: ' + result.Id, variant: 'success'});
            this.dispatchEvent(showEvent);
            this.accountRecord = '';
        }).
        catch(error => {
           this.error = error.body.message;
           this.accountId1 = '';
           this.accountRecord = { Name: '', Phone: '', Rating: '' };
           console.log('error: ' + this.error);
           this.dispatchEvent(new ShowToastEvent({title: 'error', message: this.error, variant: 'error'}));
        })       
    }

}