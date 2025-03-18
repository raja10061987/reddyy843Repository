import { LightningElement, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class DisplyDateUsingWire extends LightningElement 
{
     myData;
     columns = 
     [
        {label: 'Name',fieldName: 'Name', type: 'text'},
        {label: 'Phone',fieldName: 'Phone', type: 'text'},
        {label: 'Industry', fieldName: 'Industry', type: 'text'},
        {label: 'type', fieldName: 'Type', type: 'text'}
    ];

    @wire(getAccounts)
    getRecords({error1,data})
   {
    if(data)
    {
        this.myData = data;
        console.log('returned Data: ' + JSON.stringify(this.myData));
    }
    else if(error1)
    {
     this.myData = undefined;
     console.log('error occured@: ' + error1.body.message);
     alert('error occured while retriving account records');
    }

   }

}