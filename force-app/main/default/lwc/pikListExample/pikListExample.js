import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';  
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import LEAD_SOURCE from '@salesforce/schema/Contact.LeadSource';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import getProfiles from '@salesforce/apex/PickListHelper.getProfiles';

export default class PikListExample extends LightningElement 
{
    selectedValue;
    selectedAccountType;
    selectedLeadSource;
    profilePikList;
    selectedProfile;
    selectedMyProfile;

    get options()
    {
        return [{label: 'New', value: 'New'},{label: 'in progress', value: 'in progress'},{label: 'finished', value: 'finished'}];
       
    }
    handleChange(event)
    {
      console.log('event value: ' + event.target.value);
      this.selectedValue = event.target.value;
    }

    @wire(getPicklistValues, {
        recordTypeId:'0125g000000eHYuAAM',
        fieldApiName: TYPE_FIELD
    }) typeValues; //default id if there is no record Id: 012000000000000AAA
    // existing recordType Id: 0125g000000eHeY

  @wire(getPicklistValues,{recordTypeId: '0125g000000fCYTAA2', fieldApiName:LEAD_SOURCE})
  leadSorceValues;

  @wire(getProfiles)
  retriveProfiles({error,data})
  {
    let tempArray = [];
    console.log('profile Data: ' + JSON.stringify(data)); // {00e:Admin,001dmsa:sale,00900:sales12,0091:market}
    if(data)
    {
     for(let key in data)
    { // loop through map
      tempArray.push({label:data[key],value: key})
    }
    this.profilePikList = tempArray;
    console.log('profilePickList: ' + JSON.stringify(this.profilePikList)); // [{label:admin,value:00ee},{label:sales,value:00hdhd}]
    }
    else if(error)
    {
        alert('error occured while retriving profiles');
    }
    

  }
  profileChange(event)
  {
     this.selectedProfile = event.target.value;
     // this.template.querySelector("[data-id='selectId']").value = this.selectedProfile;
     this.template.querySelector('select.selectProfileList').value = this.selectedMyProfile;
  }
  connectedCallback()
  {
    console.log('connected call called');
  }
  clickMe(event)
  {
    console.log('leadSorceValues: ' + JSON.stringify(this.leadSorceValues));
    console.log('typeValues: ' + JSON.stringify(this.typeValues));
    console.log('TYPE_FIELD: ' + JSON.stringify(TYPE_FIELD));
    console.log('LEAD_SOURCE: ' + JSON.stringify(LEAD_SOURCE));
    console.log('account Object: ' + JSON.stringify(ACCOUNT_OBJECT));

  }
    handleTypeChange(event)
    {
      this.selectedAccountType = event.target.value;
    }
    handleLeadSourceChange(event)
    {
      this.selectedLeadSource = event.target.value;
    }

    handleMyProfileChange(event)
    {
         this.selectedMyProfile = event.target.value;
    }

}