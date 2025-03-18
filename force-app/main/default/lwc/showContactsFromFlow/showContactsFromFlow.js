import { LightningElement, api } from 'lwc';

export default class ShowContactsFromFlow extends LightningElement 
{
    @api records = [];
    @api fieldColumns = [
        { label: 'First Name', fieldName: 'FirstName', type: 'text'},
        { label: 'Last Name', fieldName: 'LastName'},
        { label: 'Phone', fieldName: 'Phone'},
        {label: 'Email', fieldName: 'Email'}
    ]

    connectedCallback()
    {
        console.log('records: ' + JSON.stringify(this.records));
    }
}