import { LightningElement, track } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class Drop_component extends LightningElement 
{
     fields = [NAME_FIELD,RATING_FIELD,INDUSTRY_FIELD];
     @track accountList = [];
    @track  accountId;
      message = 'Drop an account hear';
      dropElement(event)
      {
       this.accountId = event.dataTransfer.getData('account_id');
       console.log('accountId dropped location: ' + this.accountId);
       this.message = '';

      }
      allowDrop(event)
      {
        this.accountId = event.dataTransfer.getData('account_id');
        event.prventDefault();
      }
}