import { LightningElement } from 'lwc';
import Account_Object from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin} from 'lightning/navigation';

export default class CreateAccount_Record extends NavigationMixin(LightningElement) 
{
    name = '';
    phone = '';
    industry = '';
    accountId = '';
    handleChange(event)
    {
        if(event.target.label == 'Name')
        {
          this.name = event.target.value;
        }
        else if(event.target.label == 'Phone')
        {
         this.phone = event.target.value;
        }
        else if(event.target.label == 'Industry')
        {
         this.industry = event.target.value;
        }
        console.log('Name: ' + this.name + '  Phone: ' + this.phone + '  Industry: ' + this.industry);

    }

    createAccount()
    {
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.name;
        fields[PHONE_FIELD.fieldApiName] = this.phone;
        fields[INDUSTRY_FIELD.fieldApiName] = this.industry; // {'Name': 'raja','Phone':'1233','Industry': 'IT'}
        const recordInput = {apiName: Account_Object.objectApiName, fields}; // {'apiName': 'Account', 'fields1': {'Name': 'raja','Phone': '1233'}}
        console.log('recordInput: ' + JSON.stringify(recordInput));
        createRecord(recordInput)
        .then(account => 
        {
        console.log('newly created account: ' + JSON.stringify(account));
         this.accountId = account.id;
         this.dispatchEvent(new ShowToastEvent({title: 'Account create', message: 'Account created succssfully with id: ' + this.accountId, variant: 'success'}));
         this[NavigationMixin.Navigate](
            {
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.accountId,
                    objectApiName: 'Account',
                    actionName: 'view'
                }
            }
         );


        })
        .catch(error => {
            alert('error occured while inserting Account record');
            this.dispatchEvent(new ShowToastEvent({title: 'error while creating record', message: error.body.message,variant: 'error'}));
        })
        

    }
}