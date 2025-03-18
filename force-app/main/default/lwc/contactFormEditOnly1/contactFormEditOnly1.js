import { LightningElement,track,wire } from 'lwc';
import { getRecord,updateRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import MOBILEPHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import BIRTHDATE_FIELD from '@salesforce/schema/Contact.Birthdate';


export default class ContactFormEditOnly1 extends LightningElement 
{
    conatctRecordId = '0035g00000o32KyAAI';
    orizionalContactRecord = {};
    @track
    contactRecordEditabel;

    
    @wire(getObjectInfo,{
        objectApiName: CONTACT_OBJECT
    })
    contactObjectInfo;


    @wire(getRecord,{
        recordId: '$conatctRecordId',
        fields:[
            FIRSTNAME_FIELD,
            LASTNAME_FIELD,
            MOBILEPHONE_FIELD,
            EMAIL_FIELD,
            BIRTHDATE_FIELD
        ]
    })
    contactRecordResult({data,error})
    {
        if(data)
        {
         this.orizionalContactRecord = data; // pass by reference
         this.contactRecordEditabel = JSON.parse(JSON.stringify(data)); // pass by value
        }
        else if(error)
        {
         console.log(JSON.stringify(error));
        }
    }


    get contactFields()
    {
        let contactFieldsArray = [];
        let key = 0;
       // console.log('contactObjectInfo: ' + JSON.stringify(this.contactObjectInfo?.data));
      //  console.log('contactRecordEditabel: ' + JSON.stringify(this.contactRecordEditabel));  

        if(this.contactRecordEditabel && this.contactObjectInfo?.data)
          {
          for(let field in this.contactRecordEditabel.fields)
          {
            if(Object.prototype.hasOwnProperty.call(this.contactRecordEditabel.fields,field))
            { // if the field is accessable
               contactFieldsArray.push({
                    key: key++,
                    apiName:field,
                    label: this.contactObjectInfo.data.fields[field].label,
                    value: this.contactRecordEditabel.fields[field].value
               });
            }
          }
        }
      //  console.log('contactFieldsArray: ' + JSON.stringify(contactFieldsArray));
        return contactFieldsArray;
    }


    updateContactField(event)
    {
      let ApiName = event.target.name;
      console.log('API name: ' +  ApiName);
      if(Object.prototype.hasOwnProperty.call(this.contactRecordEditabel.fields,ApiName) && this.contactRecordEditabel.fields[ApiName])
      {
        this.contactRecordEditabel.fields[ApiName].value = event.target.value;
      }
     // console.log('after updating contactRecordEditabel: ' + JSON.stringify(this.contactRecordEditabel));
      

    }


    // updateRecord()
    // {
    //     let contact = {};
    //     contact.fields = JSON.parse(JSON.stringify(this.contactRecordEditabel.fields));

    //     for(let field in contact.fields)
    //     {
    //      contact.fields[field] = contact.fields[field].value;
    //     }
    //     contact.fields.id = this.contactRecordEditabel.id.slice();
    //     console.log('after update record: ' + JSON.stringify(contact));

    //     updateRecord(contact)
    //     .then((response) => 
    //     {
    //         console.log('success response: ' + JSON.stringify(response));
    //     alert('contact record updated successfully');
    //     })
    //     .catch((error) => {
    //         console.log('error: ' + JSON.stringify(error));
    //       alert('unable to update the record');
          
    //     })


        
        
    // }


    updateRecord()
    {
        let contact = {};
    // contact.fields = { ...this.contactRecordEditabel.fields };
    contact.fields = JSON.parse(JSON.stringify(this.contactRecordEditabel.fields));
    for (let field in contact.fields) {
      if (Object.prototype.hasOwnProperty.call(contact.fields, field)) {
        contact.fields[field] = contact.fields[field].value;
      }
    }
    contact.fields.Id = this.contactRecordEditabel.id;
    console.log(JSON.stringify(contact));
    updateRecord(contact)
      .then((response) => {
        console.log("Record Updated");
        console.log('success response: ' + JSON.stringify(response));
        alert('contact record updated successfully');
      })
      .catch((error) => {
        console.log("Unable to update record");
        console.log('error: ' + JSON.stringify(error));
       alert('unable to update the record');
       
      });
    }
    resetForm()
    {
        // console.log('orizionalContactRecord: ' + JSON.stringify(this.orizionalContactRecord));
        // console.log('New Contact Record: ' + JSON.stringify(this.contactRecordEditabel));
        this.contactRecordEditabel = JSON.parse(JSON.stringify(this.orizionalContactRecord)); // pass by value
       // console.log('orizional record updated ' + JSON.stringify(this.contactRecordEditabel));

    }
}