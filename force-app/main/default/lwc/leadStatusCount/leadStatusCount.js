import { LightningElement,wire,track } from 'lwc';
import retriveLeads from '@salesforce/apex/LeadsController.retriveLeads';

export default class LeadStatusCount extends LightningElement 
{
  @track leadsList = [];
   totalCount = 0;
  @wire(retriveLeads)
  getResult(result)
  {
       if(result.data)
       {
         let leadRecords = result.data;
         console.log('leadRecords: ' + JSON.stringify(leadRecords)); // {"Open - Not Contacted":3,"Working - Contacted":2,"Closed - Converted":1,"Closed - Not Converted":2}
        for(let key in leadRecords)
        {
            this.totalCount+= leadRecords[key];
          this.leadsList.push({value: leadRecords[key],key: key}); // [{value:1,key:lead-not-conncted},{value:2,key:working}]
        }
        console.log('myLeadList: ' + JSON.stringify(this.leadsList));
        console.log('totalCount: '+ this.totalCount);

       }
       else if(result.error)
       {
           alert('error occured while retriving lead records');
       }
  }
}