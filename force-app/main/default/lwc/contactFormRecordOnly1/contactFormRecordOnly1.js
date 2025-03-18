import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import  CONTACT_OBJECT from '@salesforce/schema/Contact';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import MOBILEPHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import BIRTHDATE_FIELD from '@salesforce/schema/Contact.Birthdate';



export default class ContactFormRecordOnly1 extends LightningElement 
{
    contactRecordId = '0035g00000o32L8AAI';
    @wire(getRecord, {
        recordId: "$contactRecordId",
        fields:[
            FIRSTNAME_FIELD,
            LASTNAME_FIELD,
            MOBILEPHONE_FIELD,
            EMAIL_FIELD,
            BIRTHDATE_FIELD
        ]

    })
    contactRecord;

    @wire(getObjectInfo,{
        objectApiName: CONTACT_OBJECT
    })
    contactObjectInfo;


    get contactFields()
    {
        if (this.contactRecord.data && this.contactObjectInfo.data)
        { 
        console.log('contactRecord: ' +  JSON.stringify(this.contactRecord?.data));
        console.log('contactObjectInfo: ' + JSON.stringify(this.contactObjectInfo?.data));
        let contactFieldsArray = [];
        let key = 0;
        for(let field in this.contactRecord?.data.fields)
        {
           if(Object.prototype.hasOwnProperty.call(this.contactRecord.data.fields,field))
           {
            console.log('each field: ' + field);
            contactFieldsArray.push({
                key: key++,
                apiName: field,
                label: this.contactObjectInfo.data.fields[field].label,
                value: this.contactRecord.data.fields[field].value
               });

           }
        }
        console.log('contactFieldsArray: ' + JSON.stringify(contactFieldsArray));
        return contactFieldsArray;

    }
}
    


}