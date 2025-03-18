import { LightningElement, track } from 'lwc';
import createAccounts from '@salesforce/apex/AccountCreationController.createAccounts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import insertAccountRecord from '@salesforce/apex/AccountCreationController.insertAccountRecord';
export default class MultipleAccountCreation extends LightningElement 
{
    @track keyIndex = 0;
    @track actRecordList = [{ Name: '',Industry: '',Phone: ''}];
    addRow()
    {
         this.keyIndex++;
        this.actRecordList.push({Name:'xxxx',Industry:'', Phone: ''});
        console.log('actRecordList:: ' + JSON.stringify(this.actRecordList));
    }
    changeHandler(event)
    {
       
        if(event.target.name == 'accName')
        {
           this.actRecordList[event.target.accessKey].Name = event.target.value;
           console.log('after changing name: ' + JSON.stringify(this.actRecordList));
        }
        else if(event.target.name == 'accIndustry')
        {
          this.actRecordList[event.target.accessKey].Industry = event.target.value;
          console.log('after changing Industry: ' + JSON.stringify(this.actRecordList));
        }
        else if(event.target.name == 'accPhone')
        {
          this.actRecordList[event.target.accessKey].Phone = event.target.value;
          console.log('after changing Phone: ' + JSON.stringify(this.actRecordList));
        }
       
    }

    removeRow(event)
    {
        if(this.actRecordList.length > 1)
        {
            this.actRecordList.splice(event.target.accessKey,1);
            this.keyIndex--;
        }
        


    }

    saveMultipleRows()
    {
        let isValid = true;
        this.template.querySelectorAll('lightning-input').forEach(element => {
            isValid =  isValid && element.reportValidity();
        });
        if(isValid)
        {
        createAccounts({actList: this.actRecordList})
        .then(result => {
        //    this.actRecordList.forEach(item => {
        //     item.Name = '';
        //     item.Industry = '';
        //     item.Phone = '';
        //    });
           this.actRecordList = [{ Name: '',Industry: '',Phone: ''}];
           this.dispatchEvent(new ShowToastEvent({title: 'success',message: 'accounts successfully creeated', variant: 'success'}));
        })
        .catch(error =>{
            this.dispatchEvent(new ShowToastEvent({title: 'error',message: error.body.message, variant: 'error'}));
        })
    }
    else
    {
        alert('please fill up all mandatory fields');
    }

    }
}