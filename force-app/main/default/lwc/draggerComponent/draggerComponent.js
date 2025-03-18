import { LightningElement, wire } from 'lwc';
import getAccountList from '@salesforce/apex/AccountController.getAccountList';
export default class DraggerComponent extends LightningElement 
{
  @wire(getAccountList) accounts;
  handleDragStart(event)
  {
    console.log('accout item id: ' + event.target.dataset.item);
    console.log('accesskey: ' + event.target.accessKey);
   event.dataTransfer.setData("account_id", event.target.dataset.item);
  }
}