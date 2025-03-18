import { LightningElement,track,wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

export default class DataTableWithWire extends LightningElement 
{
    @track columns = [
        {label: 'Name', fieldName: 'Name',type: 'text'},
        {label: 'Phone',fieldName: 'Phone',type:'text'},
        {label: 'Industry',fieldName: 'Industry', type: 'text'}
    ];
    
    @wire(getAccounts) actRecords;
    connectedCallback()
    {
        console.log('records: ' + this.actRecords)
    }
}