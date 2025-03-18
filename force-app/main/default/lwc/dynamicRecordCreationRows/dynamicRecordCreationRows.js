import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class DynamicRecordCreationRows extends NavigationMixin(LightningElement) 
{
    recordsLengthisone = false;
    recordsLengthisMoreThanOne = false;
    keyIndex = 0;
    @track itemList = [
        {
            'id':0,
            'Name': 'Test - ' + this.keyIndex
        }
    ]

   

    addRow()
    {
        ++ this.keyIndex;
        let NewRecord = {'id': this.keyIndex, 'Name': 'Test - ' + this.keyIndex};
        this.itemList.push(NewRecord); // [{id:0},{id:1}]
        console.log('itemsList: ' + JSON.stringify(this.itemList) + ' size: ' + this.itemList.length);

    }
    deleteRow(event)
    {
        let indexPosition = event.target.accessKey;
        console.log('index position: '+ indexPosition);

        if(this.itemList.length >=2)
        {
         this.itemList = this.itemList.filter(function(element){
               return parseInt(element.id) != parseInt(indexPosition)
         });

        }
      //  this.itemList.splice(indexPosition,1);
        console.log('after removing items length: ' + JSON.stringify(this.itemList) + 'size: ' + this.itemList.length);

    }

    handleSubmit()
    {
        let isValid = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
           console.log('element firstName: '+ element.FieldName  + 'isValid: ' + element.reportValidity());
           isValid = isValid && element.reportValidity();
         
        });
        if(isValid)
           {
               this.template.querySelectorAll('lightning-record-edit-form').forEach(element => {
                console.log('element: ' + JSON.stringify(element));
                element.submit();
               });
               this.dispatchEvent(new ShowToastEvent({"title": 'success',message: 'Contact Record saved successfully', variant: 'success'}));
               
               this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Contact',
                    actionName: 'home',
                }
            });

           }
           else
           {
            this.dispatchEvent(new ShowToastEvent({"title": 'error',message: 'please enter all valid fields', variant: 'error'}));
           }

    }
}