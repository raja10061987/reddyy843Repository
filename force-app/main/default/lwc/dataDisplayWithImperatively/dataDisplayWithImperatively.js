import { LightningElement } from 'lwc';
import getActRecords from '@salesforce/apex/AccountController.getAccountRecordList';

export default class DataDisplayWithImperatively extends LightningElement 
{
    actData = [];
    errorData;
    columns = [
        {label: 'Name',fieldName: 'Name',type: 'text'},
        {label: 'Type', fieldName: 'Type', type: 'text'},
        {label: 'Phone', fieldName: 'Phone', type: 'text'},
        {label: 'Industry', fieldName: 'Industry', type: 'text'}
    ];
    connectedCallback()
    {
        getActRecords()
        .then(result => {
            this.actData = result;
            console.log('actsData: ' + JSON.stringify(this.actData)); // [{"Id":"001zsmcbm","Name": "pavan"},{"Id":"001dcns","Name": "Suman"}]
        })
        .catch(error => {
          this.errorData = error;
          console.log('error occured while retriving records');
        })
    }
}