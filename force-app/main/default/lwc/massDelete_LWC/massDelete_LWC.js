import { LightningElement, track, wire } from 'lwc';
import retriveContacts from '@salesforce/apex/MassDeleteContacts.retriveContacts';
import deleteContacts from '@salesforce/apex/MassDeleteContacts.deleteContacts';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class MassDelete_LWC extends LightningElement 
{
    @track selectedContactIdsList = [];
    @track myContacts;
    myCntactsLength;
    @track columns = [
                      {label: 'First Name', fieldName: 'FirstName', Type: 'text'},
                      { label: 'Last Name', fieldName: 'LastName', type: 'text'}
                    ];
    @wire(retriveContacts) contacts;

    

    deleteSelectedRecords()
    {
        deleteContacts({contactIds: this.selectedContactIdsList})
        .then(result => {
          this.dispatchEvent(new ShowToastEvent({title: 'success', message: 'contacts deleted successfully', variant: 'successs'}));
          console.log('contacts size after deleting: ' + result.length);
          this.myCntactsLength = result.length;
          this.template.querySelector('lightning-datatable').selectedRows = [];

          return refreshApex(this.contacts);
        })
        .catch(error => {
            this.dispatchEvent(new ShowToastEvent({title: 'error', message: 'error occured while deleting contacts', variant: 'error'}))
        })
    }
    prepareSelectedRows(event)
    {
        this.selectedContactIdsList = [];
       let selectedRows = event.detail.selectedRows;
       for(let i=0; i < selectedRows.length;i++)
       {
           this.selectedContactIdsList.push(selectedRows[i].Id);       
       }
       console.log('selected Rows: ' + this.selectedContactIdsList); // (001shs,001scsm)
    }
    


}