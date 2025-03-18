import { LightningElement, track, wire } from 'lwc';
import  searchAccounts  from '@salesforce/apex/AccountSearchController.searchAccounts';
const DELAY = 300;
export default class SearchAccount extends LightningElement 
{
     accountName = '';
     accountsCount=0;
    @track actList = [];
    error = '';
    @wire(searchAccounts,{actName: '$accountName'})
    searchresults({error,data}){
         if(data)
         {
          this.actList = data;
          this.accountsCount = this.actList.length;
          console.log('actList: ' + this.actList.length); // [{Id:001nms,Name:suman},{Id:001jsjs,Name: pavan}]
         }
         else
         {
            this.error = error;
         }
    }

    handleNameChange(event)
    {
        const searchString = event.target.value;
        window.clearTimeout(this.delayTimeOut);
        this.delayTimeOut = setTimeout(() => {
            this.accountName = searchString;
        },DELAY);
        console.log('accountName: ' + this.accountName);
    }

}