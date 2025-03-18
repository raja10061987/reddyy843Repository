import { LightningElement } from 'lwc';
// import CONTACT_OBJECT from "@salesforce/schema/Contact";
import CONTACT_OBJECT from "@salesforce/schema/Contact";

export default class ContactFormReadOnly extends LightningElement {
    recordId = '0035g00000fjERnAAM';
    objectName = CONTACT_OBJECT;
    handleLoad(event) {
        // console.log('event Type: ' + event.type);
        // console.log('event Detail: ' + event.detail);
      }
    
      updateRecordId(event) {
        this.recordId = "0035g00000fjEHmAAM";
        console.log('on button click1 event Type: ' + event.type);
        console.log('on button click1 event Detail: ' + JSON.stringify(event.detail));
      }
}